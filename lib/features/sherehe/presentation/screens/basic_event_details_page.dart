import 'package:academia/features/sherehe/presentation/widgets/modern_input_decoration.dart';
import 'package:flutter/material.dart';

class BasicEventDetailsPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController startDateTimeController;
  final TextEditingController endDateTimeController;
  final TextEditingController locationController;
  final Future<void> Function(bool isStart) onSelectDateAndTime;
  final VoidCallback onNext;

  const BasicEventDetailsPage({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.startDateTimeController,
    required this.endDateTimeController,
    required this.locationController,
    required this.onSelectDateAndTime,
    required this.onNext,
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
              controller: startDateTimeController,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'Start Date & Time',
                hintText: 'Select Start date and time',
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () => onSelectDateAndTime(true),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select the start date and time';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: endDateTimeController,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'End Date & Time',
                hintText: 'Select End date and time',
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () => onSelectDateAndTime(false),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select the end date and time';
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
