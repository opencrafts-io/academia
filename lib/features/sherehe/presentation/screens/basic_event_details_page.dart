import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:academia/features/sherehe/presentation/widgets/event_visibility_selector.dart';
import 'package:academia/features/sherehe/presentation/widgets/modern_input_decoration.dart';
import 'package:flutter/material.dart';

class BasicEventDetailsPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ScopeTypes? selectedEventScopeType;
  final Set<Institution> selectedEventInstitutions;
  final TextEditingController nameController;
  final TextEditingController startDateTimeController;
  final TextEditingController endDateTimeController;
  final TextEditingController locationController;
  final Future<void> Function(bool isStart) onSelectDateAndTime;
  final Function(Set<Institution>?)? onInstitutionsChanged;
  final ValueChanged<ScopeTypes?> onScopeChanged;
  final VoidCallback onNext;

  const BasicEventDetailsPage({
    super.key,
    required this.formKey,
    required this.selectedEventScopeType,
    required this.selectedEventInstitutions,
    required this.nameController,
    required this.startDateTimeController,
    required this.endDateTimeController,
    required this.locationController,
    required this.onSelectDateAndTime,
    required this.onInstitutionsChanged,
    required this.onScopeChanged,
    required this.onNext,
  });

  String _getScopeDescription(ScopeTypes? scope) {
    switch (scope) {
      case ScopeTypes.public:
        return "Anyone can view and attend this event. Best for open events.";

      case ScopeTypes.institution:
        return "Only people from selected institutions can see and attend this event.";

      case ScopeTypes.private:
        return "Only people you directly share the event with can access it. An event link will be sent to your email after creation, which you can share with your guests.";

      default:
        return "Choose who can see and attend your event.";
    }
  }

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Event Visibility",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 6),
                    Tooltip(
                      message: "Control who can see and access your event.",
                      child: Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  _getScopeDescription(selectedEventScopeType),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),

                EventVisibilitySelector(
                  selectedEventScopeType: selectedEventScopeType,
                  selectedEventInstitutions: selectedEventInstitutions,
                  onInstitutionsChanged: onInstitutionsChanged,
                  onScopeChanged: onScopeChanged,
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: locationController,
              decoration: buildModernInputDecoration(
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
