import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class PaymentTypeSelectionPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController paybillNumberController;
  final TextEditingController accountReferenceController;
  final TextEditingController tillNumberController;
  final TextEditingController sendMoneyPhoneController;
  final PaymentTypes? selectedPaymentType;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final ValueChanged<PaymentTypes?> onPaymentTypeChanged;

  const PaymentTypeSelectionPage({
    super.key,
    required this.formKey,
    required this.paybillNumberController,
    required this.accountReferenceController,
    required this.tillNumberController,
    required this.sendMoneyPhoneController,
    required this.selectedPaymentType,
    required this.onPaymentTypeChanged,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  State<PaymentTypeSelectionPage> createState() =>
      _PaymentTypeSelectionPageState();
}

class _PaymentTypeSelectionPageState extends State<PaymentTypeSelectionPage> {
  String _paymentTypeLabel(PaymentTypes type) {
    switch (type) {
      case PaymentTypes.paybill:
        return 'Paybill';
      case PaymentTypes.till:
        return 'Till Number';
      case PaymentTypes.sendMoney:
        return 'Send Money';
      case PaymentTypes.pochi:
        return 'Pochi La Biashara';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Text(
              "Select your preferred payment method.",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<PaymentTypes>(
              decoration: const InputDecoration(
                labelText: 'Payment Type',
                border: OutlineInputBorder(),
              ),
              initialValue: widget.selectedPaymentType,
              items: PaymentTypes.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(_paymentTypeLabel(type)),
                );
              }).toList(),
              onChanged: widget.onPaymentTypeChanged,
              validator: (value) =>
                  value == null ? 'Please select a payment type' : null,
            ),

            const SizedBox(height: 16),

            if (widget.selectedPaymentType == PaymentTypes.paybill) ...[
              TextFormField(
                controller: widget.paybillNumberController,
                decoration: const InputDecoration(
                  labelText: 'Paybill Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter paybill number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Digits only';
                  }
                  if (value.length < 5 || value.length > 6) {
                    return 'Paybill must be 5–6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: widget.accountReferenceController,
                decoration: const InputDecoration(
                  labelText: 'Account Reference',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter account reference';
                  }
                  if (value.length < 3) {
                    return 'Reference too short';
                  }
                  if (value.length > 20) {
                    return 'Reference too long';
                  }
                  return null;
                },
              ),
            ],

            if (widget.selectedPaymentType == PaymentTypes.till) ...[
              TextFormField(
                controller: widget.tillNumberController,
                decoration: const InputDecoration(
                  labelText: 'Till Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter till number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Digits only';
                  }
                  if (value.length < 5 || value.length > 6) {
                    return 'Till number must be 5–6 digits';
                  }
                  return null;
                },
              ),
            ],

            if (widget.selectedPaymentType == PaymentTypes.sendMoney ||
                widget.selectedPaymentType == PaymentTypes.pochi) ...[
              TextFormField(
                controller: widget.sendMoneyPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'e.g. 07XXXXXXXX',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter phone number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Phone number must be exactly 10 digits';
                  }
                  if (!value.startsWith('07') && !value.startsWith('01')) {
                    return 'Must start with 07 or 01';
                  }
                  return null;
                },
              ),
            ],

            const Spacer(),

            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onPrevious,
                    child: const Text('Back'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: widget.onNext,
                    label: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
