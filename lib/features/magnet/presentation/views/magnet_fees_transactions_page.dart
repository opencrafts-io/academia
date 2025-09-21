import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MagnetFeesTransactionsPage extends StatefulWidget {
  const MagnetFeesTransactionsPage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<MagnetFeesTransactionsPage> createState() =>
      _MagnetFeesTransactionsPageState();
}

class _MagnetFeesTransactionsPageState
    extends State<MagnetFeesTransactionsPage> {
  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<MagnetBloc>().add(
        FetchMagnetFeeStatementTransactionsEvent(
          institutionID: widget.institutionID,
          userID: profileState.profile.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MagnetBloc, MagnetState>(
            listener: (context, state) {
              if (state is MagnetErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
            },
          ),
        ],
        child: BlocBuilder<MagnetBloc, MagnetState>(
          builder: (context, state) => RefreshIndicator.adaptive(
            onRefresh: () async {
              final profileState = context.read<ProfileBloc>().state;
              if (profileState is ProfileLoadedState) {
                context.read<MagnetBloc>().add(
                  FetchMagnetFeeStatementTransactionsEvent(
                    institutionID: widget.institutionID,
                    userID: profileState.profile.id,
                  ),
                );
              }

              await Future.delayed(Duration(seconds: 2));
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(title: Text('Fees transactions')),

                state is! MagnetFeesTransactionsLoadedState
                    ? SliverPadding(
                        padding: EdgeInsets.all(12),
                        sliver: SliverFillRemaining(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                state is MagnetLoadingState
                                    ? "assets/lotties/thinking-learning.json"
                                    : "assets/lotties/digital-marketing.json",
                                height: 240,
                              ),
                              Text(
                                state is MagnetLoadingState
                                    ? "Fetching your fees transactions. Hang on tight"
                                    : "We couldn't load your courses. Please pull to refresh.",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: EdgeInsetsGeometry.all(12),
                        sliver: state.transactions.isEmpty
                            ? SliverFillRemaining(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      "assets/lotties/thinking-learning.json",
                                      height: 240,
                                    ),
                                    Text(
                                      "No fees transactions loaded yet",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Please visit your insitution's finance department for clarification",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : SliverList.builder(
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction =
                                      state.transactions[state
                                              .transactions
                                              .length -
                                          index -
                                          1];
                                  return FinancialTransactionCard(
                                    transaction: transaction,
                                  );
                                },
                              ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

    return Card.filled(
      color: theme.colorScheme.secondaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      // shadowColor: Colors.black26,
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
                  '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(64),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    transaction.status.toUpperCase(),
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
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
                    'Ref: ${transaction.referenceNumber}',
                    style: theme.textTheme.bodySmall,
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
