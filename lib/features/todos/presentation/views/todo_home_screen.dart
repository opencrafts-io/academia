import 'dart:io' show Platform;
import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vibration/vibration.dart';
import 'package:go_router/go_router.dart';

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
  void initState() {
    super.initState();
    final permissions = [AppPermission.notification];

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        permissions.add(AppPermission.preciseAlarm);
      }
    }
    context.read<PermissionCubit>().checkMultiplePermissions(permissions);
  }

  Future<void> _showHelpDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text("Stay organized"),
        content: const Text(
          "Create todos for assignments, exams, and deadlines. "
          "We'll automatically notify you minutes before each task is due "
          "and remind you when it's time to get started.",
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Got it"),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationRequestButton() {
    return BlocBuilder<PermissionCubit, PermissionState>(
      builder: (context, state) {
        if (state is PermissionPermanentlyDenied || state is PermissionDenied) {
          return IconButton(
                onPressed: () async {
                  if (await Vibration.hasVibrator()) {
                    Vibration.vibrate(duration: 128);
                  }

                  if (!context.mounted) return;

                  // Check both permissions
                  await context.read<PermissionCubit>().checkPermission(
                    AppPermission.notification,
                  );

                  if (!context.mounted) return;

                  if (context.read<PermissionCubit>().state
                      is PermissionPermanentlyDenied) {
                    return showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        title: const Text("Allow permission"),
                        content: const Text(
                          "You've previously denied permissions "
                          "to send you notifications. You may miss important updates "
                          "please re-enable them on the app's phone settings page.",
                        ),
                        actions: [
                          FilledButton.icon(
                            onPressed: () {
                              openAppSettings();
                              context.pop();
                            },
                            label: const Text("Enable"),
                            icon: const Icon(Icons.notifications),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    );
                  }

                  // Request Notification permission
                  await context.read<PermissionCubit>().requestPermission(
                    AppPermission.notification,
                  );

                  // Also request Precise Alarm permission for timing accuracy
                  if (Platform.isAndroid) {
                    if (context.mounted) {
                      await context.read<PermissionCubit>().requestPermission(
                        AppPermission.preciseAlarm,
                      );
                    }
                  }
                },
                icon: Icon(
                  Icons.notification_important_outlined,
                  color: Colors.redAccent,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shake(duration: const Duration(milliseconds: 500))
              .then();
        }
        return SizedBox.shrink();
      },
    );
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
              await (
                context.read<TodoListCubit>().loadTodoLists(),
                Future.delayed(const Duration(seconds: 2)),
              ).wait;
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
                    title: Text(
                      "Tasks",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
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
                      _buildNotificationRequestButton(),
                      IconButton(
                        onPressed: _showHelpDialog,
                        icon: Icon(Icons.lightbulb_outline),
                      ),
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
            onPressed: () async {
              final result = await CreateTodoItemRoute().push(context);
              if (result == true && context.mounted) {
                context.read<TodoListCubit>().loadTodoLists();
              }
            },
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

  List<TodoItemEntity> _filter(List<TodoItemEntity> items) {
    if (widget.taskListLocalId == null) return items;
    return items
        .where((i) => i.taskListLocalId == widget.taskListLocalId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<TodoItemCubit, TodoItemState>(
      builder: (context, state) {
        final items = _filter(state.currentItems);

        return state.when(
          initial: () => const _EmptyState(),
          loading: (_) => items.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    LoadingIndicatorM3E(),
                    Text("Your to-dos are just a sec away.."),
                  ],
                )
              : _TodoItemsList(items: items),
          success: (_, _, _, _) => items.isEmpty
              ? const _EmptyState()
              : _TodoItemsList(items: items),
          failure: (_, _) => items.isEmpty
              ? const _EmptyState()
              : _TodoItemsList(items: items),
        );
      },
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
