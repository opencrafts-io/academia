import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

/// Read-only summary of a saved [FeeStatementEntity]'s line items. Amounts
/// without a confirmed currency are shown with their raw text rather than
/// a guessed symbol, and never rendered as "0".
class InstitutionFeeSummary extends StatelessWidget {
  const InstitutionFeeSummary({required this.statement, super.key});

  final FeeStatementEntity? statement;

  static const Map<FeeLineKind, String> _labels = {
    FeeLineKind.debit: 'Debit',
    FeeLineKind.credit: 'Credit',
    FeeLineKind.runningBalance: 'Running balance',
    FeeLineKind.balanceDue: 'Balance due',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = statement?.lineItems ?? const <FeeLineItemEntity>[];
    if (items.isEmpty) {
      return Text(
        'No fee statement saved yet.',
        style: theme.textTheme.bodyMedium,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(item.description),
            subtitle: Text(_labels[item.kind] ?? item.kind.name),
            trailing: Text(
              item.amount.hasKnownCurrency
                  ? '${item.amount.currencyCode} ${item.amount.normalizedAmount ?? item.amount.rawAmount}'
                  : item.amount.normalizedAmount ?? item.amount.rawAmount,
              style: theme.textTheme.titleMedium,
            ),
          ),
      ],
    );
  }
}
