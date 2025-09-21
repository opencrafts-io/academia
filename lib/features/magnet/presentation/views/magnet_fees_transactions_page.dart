import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import './widget/financial_transaction_card.dart';

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
