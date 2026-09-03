import 'package:billing/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaywallPage extends StatefulWidget {
  const new({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              snap: false,
              pinned: false,
              actions: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: .min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Assets.illustrations.motarboard.image(
                        height: 160,
                        width: 160,
                      ),
                    ),
                    Text(
                      "Get the best of Academia",
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text("Choose the plan that's right for you."),
                    SizedBox(height: 12),
                    Spacer(),

                    FilledButton(
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Continue"),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.open_in_new, size: 12),
                      onPressed: () {},
                      label: Text(
                        "Terms and conditions apply",
                        style: theme.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
