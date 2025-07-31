import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
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
          SliverToBoxAdapter(
            child: BlocConsumer<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoadedState) {
                  return StreamBuilder(
                    stream:
                        (BlocProvider.of<TodoBloc>(context).state
                                as TodoLoadedState)
                            .todosStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.length.toString());
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Text("WTF");
                    },
                  );
                }
                return Center(child: Text("TF"));
              },
              listener: (context, state) {
                if (state is TodoErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,

            builder: (context) => Container(
              padding: EdgeInsets.all(12),
              child: Column(
                spacing: 12,
                children: [
                  SizedBox(height: 22),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "New task",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   child: TextFormField(
                  //     expands: true,
                  //     maxLines: null,
                  //     minLines: null,
                  //     decoration: InputDecoration(
                  //       label: Text("Description"),
                  //       floatingLabelBehavior: FloatingLabelBehavior.never,
                  //       floatingLabelAlignment: FloatingLabelAlignment.center,
                  //       hintText: "Don't forget to submit math assignment",
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //         borderRadius: BorderRadius.circular(22),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.lock_clock, size: 80),
                  //   ),
                  // ),
                  FilledButton(onPressed: () {}, child: Text("Create Todo")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
