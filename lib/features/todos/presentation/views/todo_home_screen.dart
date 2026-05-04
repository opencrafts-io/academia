import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../widgets/todo_card.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoListCubit, TodoListState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (todoLists, nexturl, isPaginating, isSyncing) {},
          failure: (failure) {},
        );
      },
      builder: (context, state) {
        final lists = state.mapOrNull(success: (s) => s.todoLists) ?? [];
        return Scaffold(
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              if (!context.mounted) return;
              context.read<TodoListCubit>().loadTodoLists();
            },
            child: DefaultTabController(
              length: lists.length + 1,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    centerTitle: true,
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: Text("Tasks"),
                    bottom: TodoListTabBar(
                      lists: lists,
                      onAddPressed: () {
                        CreateTodoListRoute().push(context);
                      },
                      onLongPressList: (list) {
                        ViewTaskListRoute(
                          taskListId: list.localId,
                        ).push(context);
                      },
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    sliver: MultiSliver(
                      children: [
                        ExpansionTile(
                          expansionAnimationStyle: AnimationStyle(
                            curve: Curves.bounceInOut,
                          ),
                          title: Text("Pending To-Dos"),
                          leading: Icon(Icons.pending_outlined),
                          tilePadding: EdgeInsets.zero,
                          maintainState: true,
                          initiallyExpanded: true,
                          children: [
                            BlocBuilder<TodoBloc, TodoState>(
                              buildWhen: (stateA, stateB) =>
                                  stateB is TodoLoadedState,
                              builder: (context, state) {
                                if (state is TodoLoadedState) {
                                  return StreamBuilder(
                                    stream: state.todosStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.active) {
                                        return Center(
                                          child:
                                              CircularProgressIndicator.adaptive(),
                                        );
                                      }
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        final activeTodos = snapshot.data!
                                            .where(
                                              (todo) =>
                                                  todo.status == "needsAction",
                                            )
                                            .toList();
                                        return ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          addAutomaticKeepAlives: true,
                                          itemCount: activeTodos.length,
                                          itemBuilder: (context, index) {
                                            return TodoCard(
                                              todo: activeTodos[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Divider(),
                                        );
                                      }
                                      return Text(
                                        snapshot.connectionState.toString(),
                                      );
                                    },
                                  );
                                }
                                return Center(child: Text("Whoops"));
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text("Completed"),
                          tilePadding: EdgeInsets.zero,
                          leading: Icon(Icons.check_box),
                          children: [
                            BlocBuilder<TodoBloc, TodoState>(
                              buildWhen: (stateA, stateB) =>
                                  stateB is TodoLoadedState,
                              builder: (context, state) {
                                if (state is TodoLoadedState) {
                                  return StreamBuilder(
                                    stream: state.todosStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState !=
                                          ConnectionState.active) {
                                        return Center(
                                          child:
                                              CircularProgressIndicator.adaptive(),
                                        );
                                      }
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        final activeTodos = snapshot.data!
                                            .where(
                                              (todo) =>
                                                  todo.status != "needsAction",
                                            )
                                            .toList();
                                        return ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          addAutomaticKeepAlives: true,
                                          itemCount: activeTodos.length,
                                          itemBuilder: (context, index) {
                                            return TodoCard(
                                              todo: activeTodos[index],
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              Divider(),
                                        );
                                      }
                                      return Text(
                                        snapshot.connectionState.toString(),
                                      );
                                    },
                                  );
                                }
                                return Center(
                                  child: Text(
                                    "You have no To-Dos at the moment",
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                enableDrag: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                isScrollControlled: true,
                context: context,
                sheetAnimationStyle: AnimationStyle(
                  curve: Curves.elasticInOut,
                  reverseCurve: Curves.elasticOut,
                ),
                builder: (context) => CreateTodoBottomSheet(),
              );
            },
          ),
        );
      },
    );
  }
}
