import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketPaymentPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumberController;
  final int amount;
  final VoidCallback onBack;
  final void Function(String phoneNumber) onInitiateStk;
  final VoidCallback onCompletePayment;

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
          // Header
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
                    return FilledButton(
                      onPressed: state is TicketPaymentLoading
                          ? null
                          : () {
                              if (widget.formKey.currentState!.validate()) {
                                widget.onInitiateStk(
                                  widget.phoneNumberController.text.trim(),
                                );
                              }
                            },
                      child: state is TicketPaymentLoading
                          ? const CircularProgressIndicator()
                          : const Text("Pay Now"),
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
                      onPressed: state is TicketPaymentLoading
                          ? null
                          : widget.onBack,
                      child: const Text("Back"),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: state is TicketPaymentLoading
                          ? null
                          : () {
                              if (widget.formKey.currentState!.validate()) {
                                widget.onCompletePayment();
                              }
                            },
                      child: state is TicketPaymentLoading
                          ? const CircularProgressIndicator()
                          : const Text("Complete Payment"),
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
