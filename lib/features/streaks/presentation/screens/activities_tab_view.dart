import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/streaks/streaks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesTabView extends StatefulWidget {
  const ActivitiesTabView({super.key});

  @override
  State<ActivitiesTabView> createState() => _ActivitiesTabViewState();
}

class _ActivitiesTabViewState extends State<ActivitiesTabView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
      builder: (context, state) {
        if (state is ActivitiesLoading && state is! ActivitiesLoadingMore) {
          return const Center(child:SpinningScallopIndicator());
        } else if (state is ActivitiesError) {
          return Center(child: Text(state.message));
        } else if (state is ActivitiesLoaded) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.activities.length + (state.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.activities.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: SpinningScallopIndicator()),
                );
              }
              final activity = state.activities[index];
              return ListTile(
                title: Text(activity.name),
                subtitle: Text(activity.description ?? ''),
                onTap: () {
                  ActivitiesPageRoute(id:activity.id).push(context);
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
