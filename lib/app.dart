import 'package:academia/config/router/router.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:academia/injection_container.dart';
import 'package:academia/splash_remover.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:logger/logger.dart';

class Academia extends StatefulWidget {
  const Academia({super.key});

  @override
  State<Academia> createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {
  final Logger _logger = Logger();
  @override
  void initState() {
    setOptimalDisplayMode();
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
            signInAsReviewUsecase: sl(),
            refreshVerisafeTokenUsecase: sl(),
            signInWithSpotifyUsecase: sl.get<SignInWithSpotifyUsecase>(),
            getPreviousAuthState: sl.get<GetPreviousAuthState>(),
            signInWithGoogle: sl.get<SignInWithGoogleUsecase>(),
          )..add(AuthCheckStatusEvent()),
        ),
        BlocProvider(create: (context) => sl<ShereheHomeBloc>()),
        BlocProvider(create: (context) => sl<ShereheDetailsBloc>()),
        // BlocProvider(create: (context) => sl<CreateEventBloc>()),
        BlocProvider(create: (context) => sl<FeedBloc>()),
        BlocProvider(create: (context) => sl<CommentBloc>()),
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
          create: (context) => sl<TodoBloc>()
            ..add(FetchCachedTodosEvent())
            ..add(SyncTodosWithGoogleCalendar()),
        ),

        BlocProvider(create: (context) => sl<CommunityListingCubit>()),
        BlocProvider(
          create: (context) => CreateCommunityBloc(
            createCommunityUseCase: sl<CreateCommunityUseCase>(),
          ),
        ),
        BlocProvider(create: (context) => sl<CommunityHomeBloc>()),
        BlocProvider(create: (context) => sl<CommunityUsersBloc>()),
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
            ),
        ),
        BlocProvider(
          create: (context) => sl<AdBloc>()..add(InitializeAdMobEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<RemoteConfigBloc>()..add(InitializeRemoteConfigEvent()),
        ),

        BlocProvider(create: (context) => sl<InstitutionBloc>()),
        BlocProvider(
          create: (context) =>
              sl<MagnetBloc>()..add(InitializeMagnetInstancesEvent()),
        ),
        BlocProvider(create: (context) => sl<PermissionCubit>()),
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
                  _logger.e(
                    'OneSignal initialization failed: ${state.message}',
                    error: state.message,
                  );
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadedState) {
                  context.read<InstitutionBloc>().add(
                    GetCachedUserInstitutionsEvent(state.profile.id),
                  );
                }
              },
            ),
            BlocListener<RemoteConfigBloc, RemoteConfigState>(
              listener: (context, state) {
                if (state is RemoteConfigErrorState) {
                  _logger.e(
                    'Firebase Remote Config failed: ${state.message}',
                    error: state.message,
                  );
                }
              },
            ),
            BlocListener<AdBloc, AdState>(
              listener: (context, state) {
                if (state is AdInitializedState) {
                  _logger.i('AdMob initialized successfully!');
                } else if (state is AdErrorState) {
                  _logger.e(
                    'AdMob error: ${state.message}',
                    error: state.message,
                  );
                }
              },
            ),
          ],
          child: SplashRemover(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              showPerformanceOverlay: kProfileMode,
              theme: ThemeData(
                fontFamily: 'ProductSans',
                useMaterial3: true,
                colorScheme:
                    lightScheme ??
                    ColorScheme.fromSeed(
                      seedColor: Color(0xFF5865F2),
                      brightness: Brightness.light,
                    ),
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                fontFamily: 'ProductSans',
                useMaterial3: true,
                brightness: Brightness.dark,
                colorScheme:
                    darkScheme ??
                    ColorScheme.fromSeed(
                      seedColor: Color(0xFF5865F2),
                      brightness: Brightness.dark,
                    ),
              ),
              routerConfig: AppRouter.router,
            ),
          ),
        ),
      ),
    );
  }
}
