import 'package:academia/features/sherehe/presentation/widgets/modern_input_decoration.dart';
import 'package:flutter/material.dart';

class BasicEventDetailsPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController dateTimeController;
  final TextEditingController locationController;
  final VoidCallback onSelectDateAndTime;
  final VoidCallback onNext;
  final BuildContext context;

  const BasicEventDetailsPage({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.dateTimeController,
    required this.locationController,
    required this.onSelectDateAndTime,
    required this.onNext,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Tell us about your event.",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: nameController,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'Event Name',
                hintText: 'Fun day',
              ),

              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 3) {
                  return 'Please enter an event name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: dateTimeController,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'Date & Time',
                hintText: 'Select date and time',
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: onSelectDateAndTime,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date and time';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: locationController,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'Location',
                hintText: 'e.g., Conference Hall A, Online via Zoom',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            FilledButton.icon(onPressed: onNext, label: const Text('Next')),
          ],
        ),
      ),
    );
  }
}
