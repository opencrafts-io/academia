import 'package:academia/features/sherehe/presentation/bloc/event_links/event_link_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showCreateLinkBottomSheet(BuildContext context, String eventId) {
  final formKey = GlobalKey<FormState>();

  final maxUsesController = TextEditingController();
  final expiryController = TextEditingController();

  DateTime? selectedExpiryDateTime;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          Future<void> pickExpiryDateTime() async {
            final selectedDate = await _pickDateTime(
              context,
              initialDateTime: DateTime.now().add(const Duration(days: 1)),
            );

            if (selectedDate == null) return;

            setModalState(() {
              selectedExpiryDateTime = selectedDate;

              expiryController.text = DateFormat.yMMMMEEEEd().add_jm().format(
                selectedDate,
              );
            });
          }

          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Event Link",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
          
                  const SizedBox(height: 8),
          
                  Text(
                    "Generate a shareable event link with usage limits and expiration.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
          
                  const SizedBox(height: 24),
          
                  TextFormField(
                    controller: maxUsesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Maximum Uses",
                      hintText: "e.g. 100",
                      prefixIcon: Icon(Icons.people_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter max uses";
                      }
          
                      final parsed = int.tryParse(value);
          
                      if (parsed == null || parsed <= 0) {
                        return "Enter a valid number";
                      }
          
                      return null;
                    },
                  ),
          
                  const SizedBox(height: 16),
          
                  TextFormField(
                    controller: expiryController,
                    readOnly: true,
                    onTap: pickExpiryDateTime,
                    decoration: const InputDecoration(
                      labelText: "Expiry Date & Time",
                      hintText: "Select expiry",
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                    validator: (_) {
                      if (selectedExpiryDateTime == null) {
                        return "Please select expiry date";
                      }
          
                      return null;
                    },
                  ),
          
                  const SizedBox(height: 28),
          
                  BlocBuilder<EventLinkBloc, EventLinkState>(
                    builder: (context, state) {
                      final isLoading = state is CreateEventInviteLoading;
          
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
          
                                  context.read<EventLinkBloc>().add(
                                    CreateEventInvite(
                                      eventId: eventId,
                                      maxUses: int.parse(
                                        maxUsesController.text.trim(),
                                      ),
                                      expiresAt: selectedExpiryDateTime!
                                          .toUtc()
                                          .toIso8601String(),
                                    ),
                                  );
                                },
                          icon: isLoading
                              ? SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                )
                              : const Icon(Icons.add_link),
                          label: Text(
                            isLoading ? "Creating..." : "Create Link",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<DateTime?> _pickDateTime(
  BuildContext context, {
  DateTime? initialDateTime,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final now = DateTime.now();

  final initial = initialDateTime ?? now;

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: firstDate ?? now,
    lastDate: lastDate ?? DateTime(2100),
  );

  if (pickedDate == null) return null;

  if (!context.mounted) return null;

  final pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initial),
  );

  if (pickedTime == null) return null;

  return DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}
