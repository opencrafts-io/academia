import 'package:academia/config/config.dart';
import 'package:academia/features/profile/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:material_symbols_icons/symbols.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            spacing: 2,
            children: [
              SizedBox(height: 22),
              Image.asset(
                "assets/icons/academia-logo-variant-1.png",
                height: 62,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ListTile(
                  leading: Icon(Symbols.lightbulb),
                  title: Text("Todos"),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ListTile(
                  leading: Icon(Symbols.notifications),
                  title: Text("Reminders"),
                ),
              ),

              SizedBox(height: 12),
              Divider(),

              SizedBox(height: 12),
              Divider(),
              ListTile(leading: Icon(Symbols.archive), title: Text('Archive')),
              ListTile(leading: Icon(Symbols.delete), title: Text('Deleted')),
              ListTile(
                leading: Icon(Symbols.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            floating: true,
            snap: true,

            title: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                hintText: 'Search for something',
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ProfileRoute().push(context);
                },
                icon: UserAvatar(scallopDepth: 2),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.add),
          fabSize: ExpandableFabSize.regular,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.regular,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        children: [
          FloatingActionButton(onPressed: () {}, child: Icon(Symbols.upload)),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Symbols.notifications),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Symbols.lightbulb),
          ),
        ],
      ),
    );
  }
}
