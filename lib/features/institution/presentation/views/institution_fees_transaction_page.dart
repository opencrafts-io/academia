import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:academia/features/institution/institution.dart';

final NumberFormat _amountFormat = NumberFormat("#,##0.00");

class InstitutionFeesTransactionPage extends StatelessWidget {
  const InstitutionFeesTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InstitutionFeesBloc, InstitutionFeesState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: LoadingIndicatorM3E()),
            loading: () => const Center(child: LoadingIndicatorM3E()),
            failure: (failure) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _ErrorBanner(message: failure.message),
              ),
            ),
            success: (transactions) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar.large(title: const Text('Statement of Account')),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: _FeesSummaryCard(
                        balance: state.currentBalance,
                        totalCredit: state.totalCredit,
                        totalDebit: state.totalDebit,
                        isInDebt: state.isInDebt,
                        currency: transactions.firstOrNull?.currency ?? "KES",
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                    sliver: SliverToBoxAdapter(
                      child: InstitutionSectionLabel(
                        icon: Icons.receipt_long_rounded,
                        title: "All fees transactions",
                      ),
                    ),
                  ),

                  transactions.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  size: 56,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.5),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "No transaction history found.",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.only(bottom: 40),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final tx = transactions[index];
                              return tx == null
                                  ? SizedBox.shrink()
                                  : _LedgerEntryTile(transaction: tx);
                            }, childCount: transactions.length),
                          ),
                        ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _FeesSummaryCard extends StatelessWidget {
  final double balance;
  final double totalCredit;
  final double totalDebit;
  final bool isInDebt;
  final String currency;

  const _FeesSummaryCard({
    required this.balance,
    required this.totalCredit,
    required this.totalDebit,
    required this.isInDebt,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onInverse = colorScheme.onInverseSurface;

    return Card(
      elevation: 0,
      color: colorScheme.inverseSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "OUTSTANDING BALANCE",
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: onInverse.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isInDebt ? colorScheme.error : colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isInDebt ? "BALANCE DUE" : "PAID UP",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isInDebt
                          ? colorScheme.onError
                          : colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "$currency ${_amountFormat.format(balance.abs())}",
              style: theme.textTheme.displaySmall?.copyWith(
                color: onInverse,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: onInverse.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                      label: "CREDITED",
                      value: totalCredit,
                      color: onInverse,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 28,
                    color: onInverse.withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: _MiniStat(
                      label: "DEBITED",
                      value: totalDebit,
                      color: onInverse,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color.withValues(alpha: 0.7),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _amountFormat.format(value),
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _LedgerEntryTile extends StatelessWidget {
  final InstitutionFeeTransaction transaction;

  const _LedgerEntryTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = (transaction.credit ?? 0) > 0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final amountColor = isCredit
        ? (isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32))
        : theme.colorScheme.error;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: CircleAvatar(
            backgroundColor: amountColor.withValues(alpha: 0.15),
            child: Icon(
              isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: amountColor,
              size: 20,
            ),
          ),
          title: Text(
            transaction.title ?? "General Transaction",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transaction.description != null &&
                  transaction.description!.isNotEmpty)
                Text(
                  transaction.description!,
                  style: theme.textTheme.bodySmall,
                ),
              Text(
                transaction.postingDate != null
                    ? DateFormat(
                        'dd MMM yyyy • HH:mm',
                      ).format(transaction.postingDate!)
                    : "No Date",
                style: theme.textTheme.bodySmall,
              ),
              if (transaction.referenceNumber != null)
                Text(
                  "Ref: ${transaction.referenceNumber}",
                  style: theme.textTheme.bodySmall,
                ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isCredit ? '+' : '-'} ${_amountFormat.format(isCredit ? transaction.credit : transaction.debit)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: amountColor,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Bal: ${_amountFormat.format(transaction.runningBalance ?? 0)}",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const Divider(indent: 20, endIndent: 20, height: 1),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;

  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
