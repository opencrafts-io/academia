import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:academia/gen/assets.gen.dart';
import '../widgets/todo_card.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;
  List<TodoListEntity> _previousLists = [];

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  void _syncTabController(List<TodoListEntity> lists) {
    final newLength = lists.length + 1; // +1 for "All" tab
    if (_tabController?.length == newLength) return;

    final previousIndex = _tabController?.index ?? 0;
    _tabController?.dispose();
    _tabController = TabController(
      length: newLength,
      vsync: this,
      initialIndex: previousIndex.clamp(0, newLength - 1),
    );
    _previousLists = lists;
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
              key: ValueKey(lists.length),
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
                      isLoading: state.maybeWhen(
                        loading: () => true,
                        success: (_, __, isPaginating, isSyncing) =>
                            isPaginating || isSyncing,
                        orElse: () => false,
                      ),
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
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverFillRemaining(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast,
                        ),
                        children: [
                          _TodoItemsTab(taskListLocalId: null),
                          // One tab per list
                          ...lists.map(
                            (list) =>
                                _TodoItemsTab(taskListLocalId: list.localId),
                          ),
                        ],
                      ),
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

/// A self-contained tab that owns its own [TodoItemCubit] scoped
/// to a specific task list (or all lists if [taskListLocalId] is null).
/// Using [AutomaticKeepAliveClientMixin] preserves scroll position and
/// cubit state when the user switches between tabs.
class _TodoItemsTab extends StatefulWidget {
  final int? taskListLocalId;

  const _TodoItemsTab({this.taskListLocalId});

  @override
  State<_TodoItemsTab> createState() => _TodoItemsTabState();
}

class _TodoItemsTabState extends State<_TodoItemsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin

    return BlocProvider(
      // Each tab gets its own cubit instance scoped to its list
      create: (_) => TodoItemCubit(
        getItemsUseCase: sl(),
        getItemByIdUseCase: sl(),
        createItemUseCase: sl(),
        updateItemUseCase: sl(),
        deleteItemUseCase: sl(),
        completeItemUseCase: sl(),
        reopenItemUseCase: sl(),
        moveItemUseCase: sl(),
        syncItemsUseCase: sl(),
        taskListLocalId: widget.taskListLocalId,
      ),
      child: BlocBuilder<TodoItemCubit, TodoItemState>(
        builder: (context, state) {
          return state.when(
            initial: () => Column(children: []),
            loading: (items) {
              if (items.isEmpty) {
                return _buildEmpty();
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return TodoCard(
                    item: item,
                    onComplete: () => context
                        .read<TodoItemCubit>()
                        .completeItem(item.localId),
                    onReopen: () =>
                        context.read<TodoItemCubit>().reopenItem(item.localId),
                    onDelete: () =>
                        context.read<TodoItemCubit>().deleteItem(item.localId),
                  );
                },
              );
            },
            success: (items, nextUrl, isPaginating, isSyncing) {
              if (items.isEmpty) {
                return _buildEmpty();
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return TodoCard(
                    item: item,
                    onComplete: () => context
                        .read<TodoItemCubit>()
                        .completeItem(item.localId),
                    onReopen: () =>
                        context.read<TodoItemCubit>().reopenItem(item.localId),
                    onDelete: () =>
                        context.read<TodoItemCubit>().deleteItem(item.localId),
                  );
                },
              );
            },
            failure: (failure, items) {
              if (items.isEmpty) {
                return _buildEmpty();
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return TodoCard(
                    item: item,
                    onComplete: () => context
                        .read<TodoItemCubit>()
                        .completeItem(item.localId),
                    onReopen: () =>
                        context.read<TodoItemCubit>().reopenItem(item.localId),
                    onDelete: () =>
                        context.read<TodoItemCubit>().deleteItem(item.localId),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.computer.image(height: 180, width: 180),
          SizedBox(height: 16),
          Text("No tasks yet", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Text(
            "Add your to-dos and keep track of them across Academia "
            "and Google Workspace",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
