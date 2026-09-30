import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/agenda_event.dart';
import 'agenda_sync_status.dart';

class AgendaEventCard extends StatelessWidget {
  const AgendaEventCard({super.key, required this.event, this.onTap});

  final AgendaEvent event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final start = event.startTime?.toLocal();
    final end = event.endTime?.toLocal();

    return Card.outlined(
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  width: 4,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.summary?.trim().isNotEmpty == true
                          ? event.summary!
                          : 'Untitled agenda event',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (event.description?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        event.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (start != null) ...[
                      const SizedBox(height: 12),
                      _EventMetadata(
                        icon: Icons.schedule_outlined,
                        text: event.allDay
                            ? '${DateFormat.yMMMMd().format(start)} · All day'
                            : '${DateFormat.yMMMMd().format(start)} · ${DateFormat.jm().format(start)}${end == null ? '' : ' – ${DateFormat.jm().format(end)}'}',
                      ),
                    ],
                    if (event.location?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 6),
                      _EventMetadata(
                        icon: Icons.place_outlined,
                        text: event.location!,
                      ),
                    ],
                    const SizedBox(height: 10),
                    AgendaSyncStatus(status: event.syncStatus),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventMetadata extends StatelessWidget {
  const _EventMetadata({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
