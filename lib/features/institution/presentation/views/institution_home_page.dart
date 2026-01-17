import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionHomePage extends StatefulWidget {
  const InstitutionHomePage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<InstitutionHomePage> createState() => _InstitutionHomePageState();
}

class _InstitutionHomePageState extends State<InstitutionHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ScrappingCommandBloc, ScrappingCommandState>(
        listener: (context, state) {
          if (state is ScrappingCommandLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingIndicatorM3E(
                      constraints: BoxConstraints(maxHeight: 10, minWidth: 10),
                    ),
                    SizedBox(width: 18),
                    Text("Fetching institution configurations"),
                  ],
                ),
                duration: Duration(seconds: 10),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ScrappingCommandLoaded) {
            ScaffoldMessenger.of(context).clearSnackBars();
          } else if (state is ScrappingCommandError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 20),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },

        builder: (context, commandState) => RefreshIndicator.adaptive(
          onRefresh: () async {
            BlocProvider.of<ScrappingCommandBloc>(context).add(
              GetScrappingCommandEvent(institutionID: widget.institutionID),
            );
            await Future.delayed(Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              _InstitutionHomePageAppBar(institutionID: widget.institutionID),
              _InstitutionHomePageContent(institutionID: widget.institutionID),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstitutionHomePageContent extends StatelessWidget {
  final int institutionID;
  const _InstitutionHomePageContent({required int this.institutionID});

  Future<void> buildConfigSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),

                // Icon and Content
                Icon(
                  Icons.vpn_key_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  "Setup Required",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "You haven't added any institution keys yet. To access the dashboard and manage your data, you'll need to configure your security keys.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      context.pop();

                      // Close only when moving to setup
                      InstitutionKeysViewRoute(
                        institutionID: 5426,
                      ).push(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Keys Now"),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstitutionKeyBloc, InstitutionKeyState>(
      listener: (context, state) {
        if (state is InstitutionKeyLoaded && state.key == null) {
          buildConfigSheet(context);
        }
      },
      builder: (context, state) {
        if (state is InstitutionKeyLoading) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [LoadingIndicatorM3E(), Text("Retrieving cached keys")],
            ),
          );
        }
        if (state is InstitutionKeyError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pest_control_rodent_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sewer apples...",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.tonalIcon(
                    onPressed: () => context.read<InstitutionKeyBloc>().add(
                      GetInstitutionKeyEvent(institutionID: institutionID),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Try Again"),
                  ),
                ],
              ),
            ),
          );
        }
        return SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(child: InstitutionDashboard()),
        );
      },
    );
  }
}

class _InstitutionHomePageAppBar extends StatelessWidget {
  const _InstitutionHomePageAppBar({required this.institutionID});
  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) => SliverAppBar.large(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          state is InstitutionLoadedState
              ? state.institutions
                    .firstWhere((ins) => ins.institutionId == institutionID)
                    .name
              : "#Error",
        ),
        actions: [
          BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
            builder: (context, state) => state is ScrappingCommandLoaded
                ? IconButton(
                    onPressed: () {
                      InstitutionKeysViewRoute(
                        institutionID: institutionID,
                      ).push(context);
                    },
                    icon: Icon(Icons.key_outlined),
                  )
                : LoadingIndicatorM3E(),
          ),
        ],
      ),
    );
  }
}
