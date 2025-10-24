import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class AgendaHomePage extends StatefulWidget {
  const AgendaHomePage({super.key});

  @override
  State<AgendaHomePage> createState() => _AgendaHomePageState();
}

class _AgendaHomePageState extends State<AgendaHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Fetch events from remote when pulled down
          context.read<AgendaEventBloc>().add(FetchAgendaEventsEvent());

          // Wait a bit to show the refresh indicator
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text("Today's Events"),
              pinned: true,
              snap: true,
              floating: true,
              actions: [
                // IconButton(
                //   onPressed: () {
                //     final token =
                //         (BlocProvider.of<AuthBloc>(context).state
                //                 as AuthAuthenticated)
                //             .token;
                //     Clipboard.setData(ClipboardData(text: token.accessToken));
                //   },
                //   icon: Icon(Symbols.content_paste),
                // ),
                Visibility(
                  visible: kIsWeb,
                  child: IconButton(
                    onPressed: () {
                      // Fetch events from remote when refresh button is tapped
                      context.read<AgendaEventBloc>().add(
                        FetchAgendaEventsEvent(),
                      );
                    },
                    icon: Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Wrap(children: [CalendarHomeWidget()]),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: BlocBuilder<AgendaEventBloc, AgendaEventState>(
                builder: (context, state) {
                  if (state is AgendaEventLoadedState) {
                    return SliverToBoxAdapter(
                      child: StreamBuilder(
                        stream: state.agendaEventsStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: SpinningScallopIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text("OOps! ${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            // Filter events for today only
                            final today = DateTime.now();
                            final todayEvents = snapshot.data!.where((event) {
                              if (event.startTime == null) return false;

                              final eventDate = DateTime(
                                event.startTime!.year,
                                event.startTime!.month,
                                event.startTime!.day,
                              );
                              final todayDate = DateTime(
                                today.year,
                                today.month,
                                today.day,
                              );

                              return eventDate.isAtSameMomentAs(todayDate);
                            }).toList();

                            if (todayEvents.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      "assets/lotties/organize.json",
                                      width: 300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Get your school life organized with calendar',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap the + button to create an event',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 8),
                              shrinkWrap: true,
                              itemCount: todayEvents.length,
                              itemBuilder: (context, index) {
                                final event = todayEvents[index];
                                return AgendaEventCard(
                                  event: event,
                                  onEdit: () {
                                    // Navigate to edit mode
                                    AgendaItemViewRoute(
                                      id: event.id,
                                    ).push(context);
                                  },
                                  onDelete: () async {
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate(
                                        preset: VibrationPreset.gentleReminder,
                                      );
                                    }
                                    if (!context.mounted) return;

                                    // Show delete confirmation
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Event'),
                                        content: const Text(
                                          'Are you sure you want to delete this event? This action cannot be undone.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Cancel'),
                                          ),
                                          FilledButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              context
                                                  .read<AgendaEventBloc>()
                                                  .add(
                                                    DeleteAgendaEventEvent(
                                                      agendaEvent: event,
                                                    ),
                                                  );
                                            },
                                            style: FilledButton.styleFrom(
                                              backgroundColor: Theme.of(
                                                context,
                                              ).colorScheme.error,
                                            ),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                          return Text("Agendas loaded");
                        },
                      ),
                    );
                  }
                  return SliverToBoxAdapter(child: Text("Bad state"));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Get organized"),
        icon: Icon(Icons.add),
        onPressed: () async {
          // Provide haptic feedback for FAB press
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(preset: VibrationPreset.gentleReminder);
          }

          if (!context.mounted) return;
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            enableDrag: true,
            constraints: BoxConstraints(
              minWidth: ResponsiveBreakPoints.tablet,
              maxWidth: ResponsiveBreakPoints.tablet,
            ),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "What do you want to do ...",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 22),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        // borderRadius: BorderRadius.circular(28),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          TodosRoute().push(context);
                        },
                        leading: CircleAvatar(child: Icon(Icons.task_alt)),
                        title: Text("Manage your todos"),
                        subtitle: Text(
                          "Keep track of your tasks and assignments",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Divider(height: 0.5),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(28),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          CreateAgendaEventRoute().push(context);
                        },
                        leading: CircleAvatar(child: Icon(Icons.event)),
                        title: Text("Create an agenda event"),
                        subtitle: Text(
                          "Schedule meetings, appointments, and events",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // child: Icon(Icons.menu),
      ),
    );
  }
}
