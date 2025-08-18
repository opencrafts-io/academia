import 'package:academia/config/config.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Your Calendar"),
            pinned: true,
            snap: true,
            floating: true,
            actions: [
              IconButton(
                onPressed: () {
                  final token =
                      (BlocProvider.of<AuthBloc>(context).state
                              as AuthAuthenticated)
                          .token;
                  Clipboard.setData(ClipboardData(text: token.accessToken));
                },
                icon: Icon(Symbols.content_paste),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Wrap(children: [CalendarHomeWidget()]),
            ),
          ),
        ],
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
                  spacing: 4,
                  children: [
                    Text(
                      "What do you want to do ...",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 22),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(child: Icon(Symbols.reminder)),
                        title: Text("Create an assignment reminder"),
                        subtitle: Text(
                          "We'll notify you when they're due or close to due",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
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
