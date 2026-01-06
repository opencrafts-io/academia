import 'package:academia/core/core.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizedEventsScreen extends StatefulWidget {
  const OrganizedEventsScreen({super.key});

  @override
  State<OrganizedEventsScreen> createState() => _OrganizedEventsScreenState();
}

class _OrganizedEventsScreenState extends State<OrganizedEventsScreen> {
  String? userId;
  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      userId = profileState.profile.id;
    }

    context.read<OrganizedEventsBloc>().add(
      FetchOrganizedEvents(organizerId: userId ?? 'N/A'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: const Text('My Organized Events')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Here are all the events you've organized.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          BlocBuilder<OrganizedEventsBloc, OrganizedEventsState>(
            builder: (context, state) {
              if (state is OrganizedEventsLoading) {
                return const SliverFillRemaining(
                  child: Center(child: SpinningScallopIndicator()),
                );
              }

              if (state is OrganizedEventsError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      spacing: 12.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        FilledButton(
                          onPressed: () {
                            context.read<OrganizedEventsBloc>().add(
                              FetchOrganizedEvents(
                                organizerId: userId ?? 'N/A',
                              ),
                            );
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is OrganizedEventsLoaded) {
                if (state.events.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.celebration,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "No events organized yet",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Your created events will appear here.",
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ShereheUtils.getCrossAxisCount(context),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                      mainAxisExtent: ShereheUtils.getMainAxisExtent(context),
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return EventCardWrapper(event: state.events[index]);
                    }, childCount: state.events.length),
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}
