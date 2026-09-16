import 'package:billing/src/domain/domain.dart';
import 'package:flutter/material.dart';

/// A compact order preview designed to grow from plans into products later.
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.order,
    required this.items,
    this.plan,
    this.onEdit,
  });

  final Order order;
  final List<OrderItem> items;
  final Plan? plan;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final calculatedTotal = items.fold<int>(
      0,
      (total, item) => total + item.unitPrice * item.quantity,
    );
    final total = order.total > 0 ? order.total : calculatedTotal;

    return Card(
      color: colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long_rounded, color: colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Order summary',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (onEdit != null)
                  TextButton(onPressed: onEdit, child: const Text('Edit')),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in items) _OrderLineItem(item: item, plan: plan),
            const Divider(height: 24),
            Row(
              children: [
                Text('Amount due', style: theme.textTheme.titleSmall),
                const Spacer(),
                Text(
                  '${order.currency} ${(total / 100).toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Taxes and discounts are included when provided by the order.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderLineItem extends StatelessWidget {
  const _OrderLineItem({required this.item, this.plan});

  final OrderItem item;
  final Plan? plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = plan?.name ?? 'Plan ${item.planId}';
    final price = item.unitPrice * item.quantity;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: theme.textTheme.bodyLarge),
              Text(
                'Quantity ${item.quantity}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${plan?.currency ?? ''} ${(price / 100).toStringAsFixed(2)}',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
