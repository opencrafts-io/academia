import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
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
                    title: const Text("Tasks"),
                    bottom: TodoListTabBar(
                      isLoading: state.maybeWhen(
                        loading: () => true,
                        success: (_, _, isPaginating, isSyncing) =>
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
                  SliverFillRemaining(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      children: [
                        // One tab per list
                        ...lists.map(
                          (list) =>
                              _TodoItemsTab(taskListLocalId: list.localId),
                        ),

                        _TodoItemsTab(taskListLocalId: null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => CreateTodoItemRoute().push(context),
          ),
        );
      },
    );
  }
}

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
    super.build(context);

    return BlocProvider(
      // Each tab gets its own cubit instance scoped to its list
      create: (_) => sl<TodoItemCubit>(param1: widget.taskListLocalId),
      child: BlocBuilder<TodoItemCubit, TodoItemState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _EmptyState(),
            loading: (items) => items.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      LoadingIndicatorM3E(),
                      Text("Your to-dos are just a sec away.."),
                    ],
                  )
                : _TodoItemsList(items: items),
            success: (items, nextUrl, isPaginating, isSyncing) => items.isEmpty
                ? const _EmptyState()
                : _TodoItemsList(items: items),
            failure: (failure, items) => items.isEmpty
                ? const _EmptyState()
                : _TodoItemsList(items: items),
          );
        },
      ),
    );
  }
}

class _TodoItemsList extends StatefulWidget {
  final List<TodoItemEntity> items;
  const _TodoItemsList({required this.items});

  @override
  State<_TodoItemsList> createState() => _TodoItemsListState();
}

class _TodoItemsListState extends State<_TodoItemsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    final nearBottom = position.pixels >= position.maxScrollExtent - 200;

    if (nearBottom) {
      context.read<TodoItemCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: widget.items.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return BlocBuilder<TodoItemCubit, TodoItemState>(
            builder: (context, state) {
              final isPaginating = state.maybeWhen(
                success: (_, _, isPaginating, _) => isPaginating,
                orElse: () => false,
              );
              final hasMore = state.maybeWhen(
                success: (_, nextUrl, _, _) => nextUrl != null,
                orElse: () => false,
              );

              if (isPaginating) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }

              if (!hasMore) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      "You're all caught up",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          );
        }

        final item = widget.items[index];
        return TodoCard(
          item: item,
          onTap: () =>
              UpdateTodoItemRoute(todoLocalID: item.localId).push(context),
          onComplete: () =>
              context.read<TodoItemCubit>().completeItem(item.localId),
          onReopen: () =>
              context.read<TodoItemCubit>().reopenItem(item.localId),
          onDelete: () =>
              context.read<TodoItemCubit>().deleteItem(item.localId),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.computer.image(height: 180, width: 180),
            const SizedBox(height: 16),
            Text("No tasks yet", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              "Add your to-dos and keep track of them across Academia "
              "and Google Workspace",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
