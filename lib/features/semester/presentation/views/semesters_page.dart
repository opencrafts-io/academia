import 'package:academia/config/config.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class SemestersPage extends StatefulWidget {
  const SemestersPage({super.key});

  @override
  State<SemestersPage> createState() => _SemestersPageState();
}

class _SemestersPageState extends State<SemestersPage> {
  @override
  void initState() {
    super.initState();
    context.read<SemesterCubit>().watchAllSemesters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SemesterCubit, SemesterState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar.large(title: Text("Semesters")),
              if (state is SemesterLoadingState ||
                  state is SemesterInitialState)
                const SliverFillRemaining(
                  child: Center(child: LoadingIndicatorM3E()),
                )
              else if (state is SemesterErrorState)
                SliverFillRemaining(
                  child: _ErrorStateView(errorMessage: state.error),
                )
              else if (state is SemesterLoadedState)
                state.semesters.isEmpty
                    ? const SliverFillRemaining(child: _EmptyStateView())
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final semester = state.semesters[index];
                            return ListTile(
                              leading: Icon(Icons.calendar_month_outlined),
                              title: Text(
                                semester.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${DateFormat('MMM dd, yyyy').format(semester.startDate)} - ${DateFormat('MMM dd, yyyy').format(semester.endDate)}",
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          }, childCount: state.semesters.length),
                        ),
                      ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => AddSemesterRoute().push(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ErrorStateView extends StatelessWidget {
  final String errorMessage;
  const _ErrorStateView({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            "Something went wrong",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(errorMessage, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: () => context.read<SemesterCubit>().watchAllSemesters(),
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 16),
        Text(
          "No Semesters Found",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text("Try adding a new semester to get started."),
      ],
    );
  }
}
