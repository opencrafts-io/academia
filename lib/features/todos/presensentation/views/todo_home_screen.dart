import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../widgets/create_todo_bottom_sheet.dart';
import '../widgets/todo_card.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Todo> _todos = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // This function is the animation for removing an item
  Widget _removedItemBuilder(
    Todo todo,
    BuildContext context,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: TodoCard(todo: todo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          BlocProvider.of<TodoBloc>(
            context,
          ).add(FetchTodoEvent(page: 1, pageSize: 100));
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              pinned: true,
              floating: true,
              snap: true,
              title: TextField(
                controller: _searchController,
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
                  icon: const UserAvatar(scallopDepth: 2),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverFillRemaining(
                child: BlocConsumer<TodoBloc, TodoState>(
                  buildWhen: (previous, current) => current is TodoLoadedState,
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
                  builder: (context, state) {
                    if (state is TodoLoadedState) {
                      return StreamBuilder<List<Todo>>(
                        stream: state.todosStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lotties/google-calendar.json",
                                  width: 250,
                                ),
                                Text(
                                  "Your todos are just a sec away...",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ],
                            );
                          }

                          if (snapshot.hasError) {
                            return Column(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lotties/google-calendar.json",
                                  width: 250,
                                  repeat: false,
                                ),
                                Text(
                                  "Ooops, ${snapshot.error}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ],
                            );
                          }

                          final allTodos = snapshot.data ?? [];

                          // Filter the todos based on the search query
                          final filteredTodos = allTodos.where((todo) {
                            final lowerCaseQuery = _searchQuery.toLowerCase();
                            return todo.title.toLowerCase().contains(
                                  lowerCaseQuery,
                                ) ||
                                (todo.notes?.toLowerCase().contains(
                                      lowerCaseQuery,
                                    ) ??
                                    false);
                          }).toList();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            for (int i = _todos.length - 1; i >= 0; i--) {
                              final todo = _todos[i];
                              if (!filteredTodos.contains(todo)) {
                                _listKey.currentState?.removeItem(
                                  i,
                                  (context, animation) => _removedItemBuilder(
                                    todo,
                                    context,
                                    animation,
                                  ),
                                );
                                _todos.removeAt(i);
                              }
                            }
                          });

                          for (int i = 0; i < filteredTodos.length; i++) {
                            final todo = filteredTodos[i];
                            if (!_todos.contains(todo)) {
                              _todos.insert(i, todo);
                              _listKey.currentState?.insertItem(i);
                            }
                          }

                          // If there are no todos after filtering, show a message
                          if (filteredTodos.isEmpty &&
                              _searchQuery.isNotEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('We couldn\'t find that todo!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          }
                          // Now that the list is synchronized, build the animated list
                          return Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: ResponsiveBreakPoints.tablet,
                              ),
                              child: AnimatedList.separated(
                                key: _listKey,
                                shrinkWrap: true,
                                initialItemCount: _todos.length,
                                removedSeparatorBuilder:
                                    (context, index, animation) => SizedBox(),
                                separatorBuilder: (context, index, animation) =>
                                    Divider(height: 0.2),
                                itemBuilder: (context, index, animation) {
                                  final todo = _todos[index];
                                  BorderRadius borderRadius;
                                  if (_todos.length == 1) {
                                    borderRadius = BorderRadius.circular(18);
                                  } else if (index == 0) {
                                    borderRadius = BorderRadius.vertical(
                                      top: Radius.circular(18),
                                    );
                                  } else if (index == (_todos.length - 1)) {
                                    borderRadius = BorderRadius.vertical(
                                      bottom: Radius.circular(18),
                                    );
                                  } else {
                                    borderRadius = BorderRadius.zero;
                                  }

                                  return SlideTransition(
                                    position: animation.drive(
                                      Tween(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ),
                                    ),
                                    child: TodoCard(
                                      todo: todo,
                                      borderRadius: borderRadius,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Column(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lotties/google-calendar.json",
                          width: 250,
                        ),
                        Text(
                          "Your todos are just a sec away...",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const CreateTodoBottomSheet(),
          );
        },
      ),
    );
  }
}
