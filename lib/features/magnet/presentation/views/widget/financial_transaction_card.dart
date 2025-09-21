import 'package:academia/features/magnet/domain/entities/magnet_financial_transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FinancialTransactionCard extends StatelessWidget {
  final MagnetFinancialTransaction transaction;

  const FinancialTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatted = DateFormat.yMMMd().add_jm().format(transaction.date);

    // Color coding
    final typeColor = transaction.type.toLowerCase() == 'credit'
        ? Colors.green
        : Colors.red;

    final statusColor = transaction.status.toLowerCase() == 'completed'
        ? Colors.green
        : transaction.status.toLowerCase() == 'pending'
        ? Colors.orange
        : Colors.red;

    return Card.outlined(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: amount and type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NumberFormat.currency(
                    locale: 'en_US',
                    symbol: transaction.currency,
                    decimalDigits: 2,
                  ).format(transaction.amount),
                  style: theme.textTheme.headlineSmall!.copyWith(
                    fontFamily: GoogleFonts.handjet().fontFamily,
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  transaction.status.toUpperCase(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontFamily: GoogleFonts.zcoolQingKeHuangYou().fontFamily,
                    color: statusColor,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Transaction type & payment method
            Row(
              children: [
                Icon(
                  transaction.type.toLowerCase() == 'credit'
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: typeColor,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  transaction.type,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  transaction.paymentMethod.toUpperCase(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Reference / student ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (transaction.referenceNumber != null)
                  Text(
                    'REF: ${transaction.referenceNumber}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      // fontFamily: GoogleFonts.jersey25().fontFamily,
                    ),
                  ),
                Text(
                  dateFormatted,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Optional description
            if (transaction.description != null)
              Text(transaction.description!, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            // Balance after transaction
            Text(
              'Balance: ${transaction.currency} ${transaction.balanceAfterTransaction.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
