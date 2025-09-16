import 'package:academia/config/router/router.dart';
import 'package:academia/features/chirp/presentation/bloc/conversations/messaging_event.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:quick_actions/quick_actions.dart';

class Academia extends StatefulWidget {
  const Academia({super.key});

  @override
  State<Academia> createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {
  final QuickActions quickActions = QuickActions();

  @override
  void initState() {
    setOptimalDisplayMode();
    // setup quick actions
    quickActions.setShortcutItems([
      ShortcutItem(
        type: "action_view_todos",
        localizedTitle: "View your tasks",
        icon: "ic_view_tasks",
      ),
      ShortcutItem(
        type: "action_add_event",
        localizedTitle: "Create a sherehe",

        icon: "ic_create_event",
      ),
    ]);
    quickActions.initialize((shortcut) {
      if (shortcut == "action_view_todos") {
        TodosRoute().go(context);
      } else if (shortcut == "action_add_event") {
        CreateEventRoute().go(context);
      }
    });
    super.initState();
  }

  /// On Android phones with 120hz display by default is chosen the wrong
  /// display mode (e.g. 60hz instead 120hz).
  /// This can easily be corrected, then performance on phones like Oneplus 8T or
  /// Galaxy S20+ is great.
  Future<void> setOptimalDisplayMode() async {
    // Platform check since the package only works on android devices
    if (defaultTargetPlatform != TargetPlatform.android) return;
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution =
        supported
            .where(
              (DisplayMode m) =>
                  m.width == active.width && m.height == active.height,
            )
            .toList()
          ..sort(
            (DisplayMode a, DisplayMode b) =>
                b.refreshRate.compareTo(a.refreshRate),
          );

    final DisplayMode mostOptimalMode = sameResolution.isNotEmpty
        ? sameResolution.first
        : active;

    /// This setting is per session.
    /// Please ensure this was placed with `initState` of your root widget.
    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            refreshVerisafeTokenUsecase: sl(),
            signInWithSpotifyUsecase: sl.get<SignInWithSpotifyUsecase>(),
            getPreviousAuthState: sl.get<GetPreviousAuthState>(),
            signInWithGoogle: sl.get<SignInWithGoogleUsecase>(),
          )..add(AuthCheckStatusEvent()),
        ),
        BlocProvider(create: (context) => sl<ShereheHomeBloc>()),
        BlocProvider(create: (context) => sl<ShereheDetailsBloc>()),
        BlocProvider(
          create: (context) => FeedBloc(
            getFeedPosts: sl.get<GetFeedPosts>(),
            cachePosts: sl.get<CachePostsUsecase>(),
            likePost: sl.get<LikePostUsecase>(),
            createPost: sl.get<CreatePostUsecase>(),
            addComment: sl.get<CommentUsecase>(),
            cachePostReplies: sl.get<CachePostRepliesUsecase>(),
            getPostReplies: sl.get<GetPostRepliesUsecase>(),
          )..add(CacheFeedEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<MessagingBloc>()..add(LoadConversationsEvent()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            getCachedProfileUsecase: sl.get<GetCachedProfileUsecase>(),
            refreshCurrentUserProfileUsecase: sl
                .get<RefreshCurrentUserProfileUsecase>(),
            updateUserProfile: sl.get<UpdateUserProfile>(),
            updateUserPhone: sl.get<UpdateUserPhone>(),
          )..add(GetCachedProfileEvent()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(
            getCachedTodosUsecase: sl.get<GetCachedTodosUsecase>(),
            refreshTodosUsecase: sl<RefreshTodosUsecase>(),
            createTodoUsecase: sl<CreateTodoUsecase>(),
            updateTodoUsecase: sl<UpdateTodoUsecase>(),
            completeTodoUsecase: sl.get<CompleteTodoUsecase>(),
            deleteTodoUsecase: sl<DeleteTodoUsecase>(),
          )..add(FetchCachedTodosEvent()),
        ),
        BlocProvider(
          create: (context) => CreateCommunityBloc(
            createCommunityUseCase: sl<CreateCommunityUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => CommunityHomeBloc(
            getCommunityByIdUseCase: sl<GetCommunityByIdUseCase>(),
            moderateMembers: sl<ModerateMembersUseCase>(),
            joinCommunityUseCase: sl<JoinCommunityUseCase>(),
            leaveCommunityUseCase: sl<LeaveCommunityUseCase>(),
            deleteCommunityUseCase: sl<DeleteCommunityUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddMembersBloc(
            searchUsers: sl<SearchVerisafeUsersUseCase>(),
            moderateMembers: sl<ModerateMembersUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              sl<AgendaEventBloc>()..add(FetchCachedAgendaEventsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<NotificationBloc>()
            ..add(
              InitializeOneSignalEvent(
                appId: "88ca0bb7-c0d7-4e36-b9e6-ea0e29213593",
              ),
            )
            ..add(SetNotificationPermissionEvent(enabled: true)),
        ),
        BlocProvider(
          create: (context) =>
              sl<RemoteConfigBloc>()..add(InitializeRemoteConfigEvent()),
        ),

        BlocProvider(create: (context) => sl<InstitutionBloc>()),
      ],
      child: DynamicColorBuilder(
        builder: (lightScheme, darkScheme) => MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                AppRouter.router.refresh();
              },
            ),
            BlocListener<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationErrorState) {
                  debugPrint(
                    '❌ OneSignal initialization failed: ${state.message}',
                  );
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadedState) {
                  // Set user data in OneSignal when profile is loaded
                  context.read<NotificationBloc>().add(
                    SetUserDataEvent(
                      userId: state.profile.id,
                      name: state.profile.name,
                      email: state.profile.email,
                    ),
                  );
                }
              },
            ),
            BlocListener<RemoteConfigBloc, RemoteConfigState>(
              listener: (context, state) {
                if (state is RemoteConfigErrorState) {
                  debugPrint(
                    '❌ Firebase Remote Config failed: ${state.message}',
                  );
                }
              },
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            showPerformanceOverlay: kProfileMode,
            theme: ThemeData(
              fontFamily: 'ProductSans',
              useMaterial3: true,
              colorScheme: lightScheme,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              fontFamily: 'ProductSans',
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: darkScheme,
            ),
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}
