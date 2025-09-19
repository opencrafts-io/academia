import 'package:academia/config/config.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class AgendaEventCard extends StatelessWidget {
  final AgendaEvent event;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AgendaEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 0,
      child: InkWell(
        onTap:
            onTap ??
            () async {
              if (await Vibration.hasVibrator()) {
                Vibration.vibrate(
                  pattern: [0, 50, 100, 50],
                  intensities: [0, 128, 0, 128],
                );
              }
              if (!context.mounted) return;
              AgendaItemViewRoute(id: event.id).push(context);
            },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Title
              Text(
                event.summary ?? "Untitled Agenda Event",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),

              // Event Description
              Text(
                event.description ?? "No description provided",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              // Event Date
              Text(
                DateFormat.yMMMMd().format(event.startTime!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),

              // Action Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Duration/All-day indicator
                  Visibility(
                    visible: !event.allDay,
                    child: Text(
                      "Duration ${DateFormat("HH:mm").format(event.startTime!)} - ${DateFormat("HH:mm").format(event.endTime!)}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Visibility(
                    visible: event.allDay,
                    child: Text(
                      "Event lasts for entire day",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Spacer(),

                  // Action Buttons
                  if (onDelete != null) ...[
                    IconButton.outlined(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                      tooltip: 'Delete event',
                    ),
                  ],
                  if (onEdit != null) ...[
                    IconButton.filled(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit event',
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
