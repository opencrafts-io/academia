import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
              title: Text("Your Calendar"),
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
                            return CircularProgressIndicator.adaptive();
                          }
                          if (snapshot.hasError) {
                            return Text("OOps! ${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 8),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final event = snapshot.data![index];
                                return Card.outlined(
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: () {
                                      AgendaItemViewRoute(
                                        id: event.id,
                                      ).push(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsGeometry.all(12),
                                      child: Column(
                                        spacing: 8,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.summary ??
                                                "Untitled Agenda Event",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                          Text(
                                            event.description ??
                                                "No description provided",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                          Text(
                                            DateFormat.yMMMMd().format(
                                              event.startTime!,
                                            ),
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            // spacing: 2,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Visibility(
                                                visible: !event.allDay,
                                                child: Text(
                                                  "Duration ${DateFormat("HH:mm").format(event.startTime!)} - ${DateFormat("HH:mm").format(event.endTime!)}",
                                                ),
                                              ),
                                              Visibility(
                                                visible: event.allDay,
                                                child: Text(
                                                  "Event lasts for entire day",
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton.outlined(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {},
                                              ),
                                              IconButton.filled(
                                                onPressed: () {},
                                                icon: Icon(Icons.edit),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            constraints: BoxConstraints(
              minWidth: ResponsiveBreakPoints.tablet,
              maxWidth: ResponsiveBreakPoints.tablet,
            ),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.all(12),
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Icon(Symbols.article_shortcut),
                        ),

                        title: Text("Import your classes information"),
                        subtitle: Text(
                          "May not work for all universities",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Divider(height: 0.5),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        // borderRadius: BorderRadius.circular(28),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          TodosRoute().push(context);
                        },
                        leading: CircleAvatar(child: Icon(Symbols.list)),
                        title: Text("Create a general todo"),
                        subtitle: Text(
                          "Keep track of your tasks",
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
        child: Icon(Icons.menu),
      ),
    );
  }
}
