import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPaymentPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberController;
  final int amount;
  final VoidCallback onBack;
  final void Function(String phoneNumber) onInitiateStk;
  final void Function(String transactionId) onCompletePayment;

  const TicketPaymentPage({
    super.key,
    required this.formKey,
    required this.phoneNumberController,
    required this.amount,
    required this.onBack,
    required this.onInitiateStk,
    required this.onCompletePayment,
  });

  @override
  State<TicketPaymentPage> createState() => _TicketPaymentPageState();
}

class _TicketPaymentPageState extends State<TicketPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TicketPaymentBloc, TicketPaymentState>(
            builder: (context, state) {
              Color borderColor;
              IconData icon;
              String message;

              if (state is StkPushSent) {
                borderColor = Colors.green;
                icon = Icons.check_circle;
                message =
                    "M-Pesa prompt sent. Complete payment on your phone, then tap 'Complete Payment'.";
              } else if (state is ConfirmPaymentLoading) {
                borderColor = Colors.blue;
                icon = Icons.hourglass_top;
                message = "Confirming payment, please wait...";
              } else if (state is ConfirmPaymentLoaded) {
                switch (state.status) {
                  case 'PENDING':
                    borderColor = Colors.orange;
                    icon = Icons.schedule;
                    message =
                        "Payment is still processing. Please wait a moment and try again.";
                    break;

                  case 'CANCELLED':
                  case 'REVERSED':
                    borderColor = Theme.of(context).colorScheme.error;
                    icon = Icons.cancel;
                    message =
                        "Payment was cancelled or reversed. Please initiate payment again.";
                    break;

                  case 'FAILED':
                    borderColor = Theme.of(context).colorScheme.error;
                    icon = Icons.error;
                    message =
                        "Payment failed. If you were charged, please contact support at hello@opencrafts.io.";
                    break;

                  case 'SUCCESS':
                    return const SizedBox.shrink();
                  default:
                    return const SizedBox.shrink();
                }
              } else if (state is PurchaseError) {
                borderColor = Theme.of(context).colorScheme.error;
                icon = Icons.error;
                message = "Failed to send M-Pesa prompt. Please try again.";
              } else {
                return const SizedBox.shrink();
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: borderColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: borderColor),
                    const SizedBox(width: 8),
                    Expanded(child: Text(message)),
                  ],
                ),
              );
            },
          ),

          Row(
            spacing: 10.0,
            children: [
              Text("3.", style: Theme.of(context).textTheme.headlineSmall),
              Text("Payment", style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          Text(
            "Enter the phone number to receive an M-Pesa prompt.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // Payment Form
          Form(
            key: widget.formKey,
            child: Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "M-Pesa Phone Number",
                      hintText: "07XXXXXXXX",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
                      }

                      final cleaned = value.replaceAll(RegExp(r'\s+'), '');

                      if (!RegExp(r'^(07|01)\d{8}$').hasMatch(cleaned)) {
                        return "Enter a valid Safaricom number";
                      }

                      return null;
                    },
                  ),
                ),
                BlocBuilder<TicketPaymentBloc, TicketPaymentState>(
                  builder: (context, state) {
                    final bool disablePayNow =
                        state is PurchaseLoading ||
                        state is ConfirmPaymentLoading ||
                        (state is ConfirmPaymentLoaded &&
                            state.status == 'PENDING');
                    return state is PurchaseLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : FilledButton(
                            onPressed: disablePayNow
                                ? null
                                : state is StkPushSent
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "An M-Pesa prompt has already been sent. Please complete payment.",
                                        ),
                                      ),
                                    );
                                  }
                                : () {
                                    if (widget.formKey.currentState!
                                        .validate()) {
                                      widget.onInitiateStk(
                                        widget.phoneNumberController.text
                                            .trim(),
                                      );
                                    }
                                  },
                            child: Text(
                              state is PurchaseError ? "Try Again" : "Pay Now",
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
          // Manual Payment Instructions
          // Center(
          //   child: Container(
          //     padding: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(16),
          //       color: Theme.of(context).colorScheme.surfaceContainerHighest,
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       spacing: 8,
          //       children: const [
          //         Text(
          //           "Manual Payment Instructions",
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //         Text("1. Go to M-Pesa"),
          //         Text("2. Select Lipa na M-Pesa"),
          //         Text("2. Select Paybill"),
          //         Text("3. Enter Business Number: XXXXX"),
          //         Text("4. Enter Account No: EVENT123"),
          //         Text("5. Enter Amount and confirm"),
          //         Text("After payment, click 'Complete Payment' below."),
          //       ],
          //     ),
          //   ),
          // ),
          // Amount Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Amount to Pay"),
                Text(
                  "KES ${widget.amount}",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Buttons
          BlocBuilder<TicketPaymentBloc, TicketPaymentState>(
            builder: (context, state) {
              return Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state is PurchaseLoading
                          ? null
                          : widget.onBack,
                      child: const Text("Back"),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<TicketPaymentBloc, TicketPaymentState>(
                      builder: (context, state) {
                        return state is ConfirmPaymentLoading
                            ? Center(
                                child: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : FilledButton(
                                onPressed: state.transId != null
                                    ? () {
                                        widget.onCompletePayment(
                                          state.transId!,
                                        );
                                      }
                                    : null,
                                child: const Text("Complete Payment"),
                              );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
