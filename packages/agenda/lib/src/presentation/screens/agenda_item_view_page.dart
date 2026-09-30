import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../../domain/entities/agenda_event.dart';
import '../cubit/agenda_cubit.dart';
import '../cubit/agenda_state.dart';
import '../widgets/agenda_sync_status.dart';

class AgendaItemViewPage extends StatelessWidget {
  const AgendaItemViewPage({super.key, this.agendaEventID});

  final String? agendaEventID;

  Future<void> _edit(BuildContext context, AgendaEvent event) async {
    await context.push<void>('/calendar/create', extra: event);
  }

  Future<void> _delete(BuildContext context, AgendaEvent event) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete agenda item?'),
        content: const Text('This event will be removed from your agenda.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final deleted = await context.read<AgendaCubit>().delete(event.id);
    if (deleted && context.mounted) {
      HapticFeedback.mediumImpact();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      builder: (context, state) {
        final event = state.events
            .where((item) => item.id == agendaEventID)
            .firstOrNull;
        return SheetContentScaffold(
          topBar: AppBar(
            title: const Text('Agenda item'),
            leading: IconButton(
              tooltip: 'Close',
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded),
            ),
            actions: [
              IconButton(
                tooltip: 'Refresh agenda status',
                onPressed: () => context.read<AgendaCubit>().reload(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: event == null
              ? _MissingEvent(error: state.error, loading: state.isLoading)
              : _EventDetails(
                  event: event,
                  error: state.error,
                  isSaving: state.isSaving,
                  onEdit: () => _edit(context, event),
                  onDelete: () => _delete(context, event),
                ),
        );
      },
    );
  }
}

class _MissingEvent extends StatelessWidget {
  const _MissingEvent({required this.error, required this.loading});

  final String? error;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              const CircularProgressIndicator()
            else ...[
              Text(error ?? 'This agenda item is not available.'),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: () => context.read<AgendaCubit>().reload(),
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  const _EventDetails({
    required this.event,
    required this.error,
    required this.isSaving,
    required this.onEdit,
    required this.onDelete,
  });

  final AgendaEvent event;
  final String? error;
  final bool isSaving;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final start = event.startTime?.toLocal();
    final end = event.endTime?.toLocal();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              event.summary?.trim().isNotEmpty == true
                  ? event.summary!
                  : 'Untitled agenda event',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            AgendaSyncStatus(status: event.syncStatus),
            if (start != null ||
                event.timezone != null ||
                event.location?.trim().isNotEmpty == true) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (start != null)
                      _DetailRow(
                        icon: Icons.schedule_outlined,
                        text: event.allDay || end == null
                            ? '${DateFormat.yMMMMd().format(start)}${event.allDay ? ' · All day' : ''}'
                            : '${DateFormat.yMMMMd().format(start)} · ${DateFormat.jm().format(start)} – ${DateFormat.jm().format(end)}',
                      ),
                    if (event.location?.trim().isNotEmpty == true)
                      _DetailRow(
                        icon: Icons.place_outlined,
                        text: event.location!,
                      ),
                    if (event.timezone != null)
                      _DetailRow(icon: Icons.public, text: event.timezone!),
                  ],
                ),
              ),
            ],
            if (event.description?.trim().isNotEmpty == true) ...[
              const SizedBox(height: 24),
              Text('Description', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(event.description!, style: theme.textTheme.bodyLarge),
            ],
            if (event.attendees.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Attendees', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...event.attendees.map(
                (attendee) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  leading: const Icon(Icons.person_outline),
                  title: Text(
                    attendee.displayName ?? attendee.email ?? 'Attendee',
                  ),
                  subtitle:
                      attendee.displayName != null && attendee.email != null
                      ? Text(attendee.email!)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: theme.colorScheme.surfaceContainerLow,
                ),
              ),
            ],
            if (error != null) ...[
              const SizedBox(height: 12),
              Text(
                error!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isSaving ? null : onDelete,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isSaving ? null : onEdit,
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit'),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
