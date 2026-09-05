import 'package:billing/src/domain/domain.dart';
import 'package:billing/src/presentation/presentation.dart';
import 'package:billing/src/presentation/widgets/plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material3_indicators/material3_indicators.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  Plan? _selectedPlan;

  @override
  void initState() {
    super.initState();
    context.read<PlanCubit>().getPlans();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: RefreshIndicator.noSpinner(
          onRefresh: () async {
            await context.read<PlanCubit>().getPlans();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                automaticallyImplyLeading: false,
                floating: true,
                snap: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Get the best of Academia",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: MultiSliver(
                  children: [
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Choose the plan that's right for you",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 22)),

                    BlocBuilder<PlanCubit, PlanState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          plansLoaded: (plans) => MultiSliver(
                            children: [
                              SliverList.builder(
                                itemCount: plans.length,
                                itemBuilder: (context, index) => PlanWidget(
                                  plan: plans[index],
                                  isSelected:
                                      _selectedPlan?.code == plans[index].code,
                                  onTap: (plan) {
                                    setState(() {
                                      // Reset plan
                                      if (_selectedPlan?.code ==
                                          plans[index].code) {
                                        _selectedPlan = null;
                                        return;
                                      }
                                      _selectedPlan = plan;
                                    });
                                  },
                                ),
                              ),
                              SliverFillRemaining(
                                hasScrollBody: false,
                                fillOverscroll: true,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 320),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: .center,
                                        children: [
                                          Expanded(
                                            child: FilledButton.icon(
                                              style: FilledButton.styleFrom(
                                                padding: .all(18),
                                              ),
                                              onPressed: _selectedPlan == null
                                                  ? null
                                                  : () {},
                                              label: Text("Continue"),
                                              iconAlignment: .end,
                                              icon: Icon(Icons.arrow_forward),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.all(18),
                                              ),
                                              onPressed: () {},
                                              child: Text("Restore Plan"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton.icon(
                                        icon: Icon(Icons.open_in_new, size: 12),
                                        onPressed: () {},
                                        label: Text(
                                          "Terms and conditions apply",
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          loading: () => const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: .center,
                              children: [
                                WavyCircularProgressIndicator(
                                  size: 64,
                                  amplitude: 3.0,
                                  frequency: 8.0,
                                ),
                              ],
                            ),
                          ),
                          orElse: () => const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: _PlansUnavailableView()),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlansUnavailableView extends StatelessWidget {
  const _PlansUnavailableView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        mainAxisSize: .min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 64,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            "Couldn't load plans",
            textAlign: .center,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Pull down to refresh and make sure you're connected to "
            "the internet. If the problem persists, please try again "
            "later.",
            textAlign: .center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
