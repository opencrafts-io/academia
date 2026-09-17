import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void showCreateTicketLinkBottomSheet(BuildContext context, String ticketId) {
  final formKey = GlobalKey<FormState>();

  final maxUsesController = TextEditingController();
  final expiryController = TextEditingController();

  DateTime? selectedExpiryDateTime;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (modalContext) {
      return BlocProvider.value(
        value: context.read<TicketLinkBloc>(),
        child: StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> pickExpiryDateTime() async {
              final selectedDate = await pickDateTime(
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
                      "Create Ticket Link",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Generate a shareable ticket link with usage limits and expiration.",
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

                    BlocBuilder<TicketLinkBloc, TicketLinkState>(
                      builder: (context, state) {
                        final isLoading = state is CreateTicketInviteLoading;

                        return SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    context.read<TicketLinkBloc>().add(
                                      CreateTicketInvite(
                                        ticketId: ticketId,
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
        ),
      );
    },
  );
}

void showEditTicketLinkBottomSheet({
  required BuildContext context,
  required String ticketId,
  required String inviteId,
  required int maxUses,
  required String expiresAt,
}) {
  final formKey = GlobalKey<FormState>();

  final expiresAtDate = DateTime.parse(expiresAt).toLocal();
  final maxUsesController = TextEditingController(text: maxUses.toString());
  final expiryController = TextEditingController(
    text: DateFormat.yMMMMEEEEd().add_jm().format(expiresAtDate),
  );

  DateTime? selectedExpiryDateTime = expiresAtDate;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (modalContext) {
      return BlocProvider.value(
        value: context.read<TicketLinkBloc>(),
        child: StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> pickExpiryDateTime() async {
              final selectedDate = await pickDateTime(
                context,
                initialDateTime: selectedExpiryDateTime,
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
                      "Edit Ticket Link",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Edit the usage limits and expiration of this ticket link.",
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

                    BlocBuilder<TicketLinkBloc, TicketLinkState>(
                      builder: (context, state) {
                        final isLoading = state is UpdateTicketInviteLoading;

                        return SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    context.read<TicketLinkBloc>().add(
                                      UpdateTicketInvite(
                                        inviteId: inviteId,
                                        ticketId: ticketId,
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
                              isLoading ? "Updating..." : "Update Link",
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
        ),
      );
    },
  );
}

void showDeleteTicketInviteDialog({
  required BuildContext context,
  required String inviteId,
  required String ticketId,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: context.read<TicketLinkBloc>(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          titlePadding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_forever_rounded,
                  size: 36,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Delete Invite?",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                "Are you sure you want to delete this invite link? This action cannot be undone.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: BlocBuilder<TicketLinkBloc, TicketLinkState>(
                      builder: (context, state) {
                        final isLoading = state is DeleteTicketInviteLoading;

                        return FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onError,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<TicketLinkBloc>().add(
                                    DeleteTicketInvite(
                                      inviteId: inviteId,
                                      ticketId: ticketId,
                                    ),
                                  );
                                },
                          child: isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onError,
                                  ),
                                )
                              : const Text("Delete"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
