import 'package:academia/config/config.dart';
import 'package:academia/features/sherehe/domain/entities/invite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

enum LinkType { ticket, event }

class PrivateLinkWidget extends StatefulWidget {
  final int index;
  final LinkType linkType;
  final Invite invite;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PrivateLinkWidget({
    super.key,
    required this.index,
    required this.linkType,
    required this.invite,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<PrivateLinkWidget> createState() => _PrivateLinkWidgetState();
}

class _PrivateLinkWidgetState extends State<PrivateLinkWidget> {
  void _copyLink(String link) async {
    await Clipboard.setData(ClipboardData(text: link));
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = widget.invite.isExpired;
    final link =
        'https://academia.opencrafts.io${widget.linkType == LinkType.ticket ? TicketFlowWithInviteRoute(invite: widget.invite.token).location : ShereheDetailsWithTokenRoute(invite: widget.invite.token).location}';
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.link_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.linkType == LinkType.ticket
                            ? "Ticket Link ${widget.index + 1}"
                            : "Event Link ${widget.index + 1}",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isExpired
                              ? Theme.of(context).colorScheme.errorContainer
                              : Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          isExpired ? 'Expired' : 'Active',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: isExpired
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.onErrorContainer
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onTertiaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: widget.onEdit,
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: widget.onDelete,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: SelectableText(
                      link,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  isExpired
                      ? Icon(
                          Icons.link_off_rounded,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        )
                      : IconButton(
                          tooltip: "Copy link",
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                          ),
                          onPressed: () => _copyLink(link),
                          icon: const Icon(Icons.copy_rounded),
                        ),
                ],
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.calendar_today_outlined,
                    label: isExpired ? 'Expired' : 'Valid Until',
                    value: DateFormat.yMMMEd().add_jm().format(
                      DateTime.parse(widget.invite.expiresAt).toLocal(),
                    ),
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.people_outline,
                    label: 'Max Uses',
                    value: '${widget.invite.maxUses}',
                    isMaxUses: true,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isExpired ? 'Final Count' : 'Usage Progress',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${widget.invite.usedCount}/${widget.invite.maxUses} uses',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: widget.invite.usageProgress,
                minHeight: 8,
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isExpired ? null : () => _copyLink(link),
                    icon: const Icon(Icons.copy_outlined),
                    label: const Text('Copy Link'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isExpired
                        ? null
                        : () async {
                            final box =
                                context.findRenderObject() as RenderBox?;

                            // final text =
                            //     'You have been invited from Academia to the following event:\n\n '
                            //     '🎉 ${state.event.eventName}\n\n'
                            //     '📍 Where: ${state.event.eventLocation}\n'
                            //     '⏰ When: ${ShereheUtils.formatDate(state.event.startDate)} at ${ShereheUtils.formatTime(state.event.startDate)}\n\n'
                            //     '🎟 Get your ticket here:\n$link';

                            await Share.share(
                              link,
                              sharePositionOrigin: box != null
                                  ? box.localToGlobal(Offset.zero) & box.size
                                  : null,
                            );
                          },
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share'),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isMaxUses;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isMaxUses = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 110,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isMaxUses ? 20 : null,
            ),
          ),
        ],
      ),
    );
  }
}
