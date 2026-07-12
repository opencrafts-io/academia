import 'dart:io' show Platform;
import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:vibration/vibration.dart';
import 'package:go_router/go_router.dart';

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
        return DefaultTabController(
          // Keyed on order (not just length) so that reordering a list to
          // the front - e.g. after adding a new item to it - resets the
          // controller and selects that list's tab.
          key: ValueKey(lists.map((l) => l.localId).join('-')),
          length: lists.length + 1,
          child: Scaffold(
            body: RefreshIndicator.adaptive(
              onRefresh: () async {
                await (
                  context.read<TodoItemCubit>().loadItems(),
                  Future.delayed(const Duration(seconds: 2)),
                ).wait;
              },
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
                              TodoItemsTab(taskListLocalId: list.localId),
                        ),

                        TodoItemsTab(taskListLocalId: null),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  final currentIndex = DefaultTabController.of(context).index;
                  final taskList = context
                      .read<TodoListCubit>()
                      .state
                      .whenOrNull(
                        success:
                            (todoLists, nextUrl, isPaginating, isSyncing) =>
                                todoLists.elementAtOrNull(currentIndex),
                      );
                  CreateTodoItemRoute(
                    taskListLocalID: taskList?.localId,
                  ).push(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
