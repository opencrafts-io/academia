import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:academia/features/institution/institution.dart';

class InstitutionFeesTransactionPage extends StatelessWidget {
  const InstitutionFeesTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InstitutionFeesBloc, InstitutionFeesState>(
        builder: (context, state) {
          if (state.status == FeesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == FeesStatus.failure) {
            return Center(child: Text("Error: ${state.failure?.message}"));
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar.large(title: const Text('Statement of Account')),

              SliverToBoxAdapter(
                child: _FeesSummaryCard(
                  balance: state.currentBalance,
                  isInDebt: state.isInDebt,
                  currency: state.transactions.firstOrNull?.currency ?? "KES",
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    "All Postings",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              state.transactions.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(
                        child: Text("No transaction history found."),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.only(bottom: 40),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final tx = state.transactions[index];
                          return tx == null
                              ? SizedBox.shrink()
                              : _LedgerEntryTile(transaction: tx);
                        }, childCount: state.transactions.length),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class _FeesSummaryCard extends StatelessWidget {
  final double balance;
  final bool isInDebt;
  final String currency;

  const _FeesSummaryCard({
    required this.balance,
    required this.isInDebt,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Outstanding Balance",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$currency ${balance.abs().toStringAsFixed(2)}",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isInDebt ? colorScheme.error : colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isInDebt
                  ? Icons.pending_actions_rounded
                  : Icons.check_circle_rounded,
              size: 40,
              color: isInDebt ? colorScheme.error : colorScheme.primary,
            ),
          ],
        ),
      ),
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

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          title: Text(
            transaction.title ?? "General Transaction",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.postingDate != null
                    ? DateFormat(
                        'dd MMM yyyy • HH:mm',
                      ).format(transaction.postingDate!)
                    : "No Date",
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
                "${isCredit ? '+' : '-'}${isCredit ? transaction.credit : transaction.debit}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isCredit
                      ? Colors.green.shade700
                      : theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Bal: ${transaction.runningBalance}",
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
