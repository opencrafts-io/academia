import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketFlowPage extends StatefulWidget {
  final String eventId;

  const TicketFlowPage({super.key, required this.eventId});

  @override
  State<TicketFlowPage> createState() => _TicketFlowPageState();
}

class _TicketFlowPageState extends State<TicketFlowPage> {
  final PageController _pageController = PageController();
  final _paymentPageFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  int currentPage = 0;
  Ticket? _selectedTicket;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    context.read<UserTicketSelectionBloc>().add(
      FetchTicketsByEventId(eventId: widget.eventId),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _selectedTicket != null && _selectedTicket!.ticketPrice == 0
        ? (currentPage + 1) / 2
        : (currentPage + 1) / 3;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Quit Ticket Booking"),
                content: const Text(
                  "Are you sure you want to quit the ticket booking process?",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      context.read<TicketPaymentBloc>().add(
                        ResetTicketPaymentState(),
                      );
                      Navigator.pop(context);
                      context.pop();
                    },
                    child: const Text("Quit"),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            );
          },
        ),
        title: const Text("Ticket Booking"),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: 'Need help?',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    "Need Help?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  content: const Text(
                    "If you experience any issues while purchasing or booking a ticket, "
                    "please contact our support team at hello@opencrafts.io",
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: BlocListener<TicketPaymentBloc, TicketPaymentState>(
        listener: (context, state) {
          if (state is PurchaseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "There was an error sending an Mpesa Prompt, please click Try Again to resend",
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }

          if (state is ConfirmPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "There was an error confirming payment, please try again",
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }

          if (state is FreeTicketBooked) {
            context.pop();

            // Delay snackbar so it shows after pop
            Future.microtask(() {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Ticket booked successfully 🎉"
                    "Go to 'My Tickets' to view your ticket.",
                  ),
                ),
              );
            });
          }

          if (state is ConfirmPaymentLoaded) {
            switch (state.status) {
              case 'SUCCESS':
                context.pop();

                // Delay snackbar so it shows after pop
                Future.microtask(() {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Ticket purchased successfully 🎉"
                        "Go to 'My Tickets' to view your ticket.",
                      ),
                    ),
                  );
                });
                break;

              case 'PENDING':
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Payment is still being processed. "
                      "Please wait a moment and try again.",
                    ),
                  ),
                );
                break;

              case 'CANCELLED':
              case 'REVERSED':
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Payment was cancelled or reversed. "
                      "Please initiate payment again.",
                    ),
                  ),
                );
                break;

              case 'FAILED':
              default:
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Payment Failed"),
                    content: const Text(
                      "The payment failed. If you were charged on your end, "
                      "please contact our support team at hello@opencrafts.io",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
            }
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => currentPage = index),
          children: [
            UserTicketSelectionPage(
              eventId: widget.eventId,
              selectedTicket: _selectedTicket,
              quantity: _quantity,
              onTicketSelected: (ticket) {
                setState(() {
                  _selectedTicket = ticket;
                  _quantity = ticket == null ? 1 : _quantity;
                });
              },
              onQuantityChanged: (qty) {
                setState(() => _quantity = qty);
              },
              onContinue: _nextPage,
            ),
            if (_selectedTicket != null) ...[
              ReviewTicketPage(
                ticket: _selectedTicket!,
                quantity: _quantity,
                onPrevious: _previousPage,
                onNext: _nextPage,
                isFreeEvent: _selectedTicket!.ticketPrice == 0,
              ),
              if (_selectedTicket!.ticketPrice > 0)
                TicketPaymentPage(
                  formKey: _paymentPageFormKey,
                  phoneNumberController: _phoneController,
                  amount: _selectedTicket!.ticketPrice * _quantity,
                  onBack: _previousPage,
                  onInitiateStk: (phone) {
                    if (_selectedTicket != null) {
                      context.read<TicketPaymentBloc>().add(
                        PurchaseTicket(
                          ticketId: _selectedTicket!.id!,
                          ticketQuantity: _quantity,
                          phoneNumber: phone,
                        ),
                      );
                    }
                  },
                  onCompletePayment: (transactionID) {
                    context.read<TicketPaymentBloc>().add(
                      ConfirmPayment(transId: transactionID),
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}
