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
    final progress = (currentPage + 1) / 3;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text("Ticket Booking"),
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
      body: PageView(
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
            ),
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
              onCompletePayment: () {},
            ),
          ],
        ],
      ),
    );
  }
}
