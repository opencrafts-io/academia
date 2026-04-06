import 'package:academia/features/sherehe/domain/entities/ticket_ui.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class AddedTicketsCard extends StatefulWidget {
  final TicketUI addedTicket;
  final VoidCallback onEditTicket;
  final VoidCallback onRemoveTicket;

  const AddedTicketsCard({
    super.key,
    required this.addedTicket,
    required this.onEditTicket,
    required this.onRemoveTicket,
  });

  @override
  State<AddedTicketsCard> createState() => _AddedTicketsCardState();
}

class _AddedTicketsCardState extends State<AddedTicketsCard> {
  @override
  Widget build(BuildContext context) {
    final isPublic = widget.addedTicket.isPublic;
    final institutions = widget.addedTicket.institutions;
    final selectedTicketGroupType = widget.addedTicket.selectedTicketGroupType;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1.2,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Ticket Name + Meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.addedTicket.ticket.ticketName,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 6),

                      if (selectedTicketGroupType != null)
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text(selectedTicketGroupType.label),
                          avatar: Icon(selectedTicketGroupType.icon, size: 16),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
                          ),
                        ),

                      const SizedBox(height: 8),

                      /// Price + Quantity
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _InfoPill(
                            label: "Price",
                            value: "${widget.addedTicket.ticket.ticketPrice}",
                            icon: Icons.payments_outlined,
                          ),
                          _InfoPill(
                            label: "Qty",
                            value:
                                "${widget.addedTicket.ticket.ticketQuantity}",
                            icon: Icons.confirmation_number_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Actions
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: widget.onEditTicket,
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: widget.onRemoveTicket,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Divider
            Divider(
              color: Theme.of(context).colorScheme.outlineVariant,
              height: 1,
            ),

            const SizedBox(height: 12),

            /// Visibility Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Visibility Chip
                Chip(
                  label: Text(isPublic ? "Public Event" : "Restricted"),
                  backgroundColor: isPublic
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.secondaryContainer,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isPublic
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),

                if (!isPublic && institutions.isNotEmpty) ...[
                  const SizedBox(height: 8),

                  /// Institutions
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: institutions.map((inst) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          inst.name,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onTertiaryContainer,
                              ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            "$label:",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
