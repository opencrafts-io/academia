import 'dart:async';

import 'package:academia/config/router/router.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:academia/gen/fonts.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:agenda/agenda.dart' as agenda;
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:permissions/permissions.dart';
import 'package:settings/settings.dart';
import 'package:courses/courses.dart' as courses;
import 'package:todos/todos.dart' as todos;
import 'package:pomodoro/pomodoro.dart' as pomodoro;

class Academia extends StatefulWidget {
  const Academia({super.key});

  @override
  State<Academia> createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> with WidgetsBindingObserver {
  bool _deferredServicesReady = false;
  SettingsCubit? _settingsCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setOptimalDisplayMode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_initializeDeferredServices());
    });
  }

  Future<void> _initializeDeferredServices() async {
    try {
      await initializeDeferredServices();
      if (!mounted) return;

      final settings = _settingsCubit;
      if (settings == null) return;
      _deferredServicesReady = true;
      sl<courses.CourseReminderRefresher>().updatePreferences(
        enabled: settings.state.courseRemindersEnabled,
        reminderMinutes: settings.state.courseReminderMinutes,
      );
    } catch (error, stackTrace) {
      debugPrint('Deferred startup initialization failed: $error\n$stackTrace');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _deferredServicesReady) {
      unawaited(sl<courses.CourseReminderRefresher>().refresh());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
          create: (context) =>
              sl<InAppUpdateBloc>()..add(CheckForInAppUpdateEvent()),
        ),
        BlocProvider(create: (context) => _settingsCubit = sl<SettingsCubit>()),
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider(create: (context) => sl<ShereheHomeBloc>()),
        BlocProvider(create: (context) => sl<CreateEventBloc>()),
        BlocProvider(create: (context) => sl<ScannerActionsBloc>()),

        BlocProvider(create: (context) => sl<FeedBloc>()),

        BlocProvider(create: (context) => sl<CommentBloc>()),
        BlocProvider(
          create: (context) => BlockBloc(
            blockUser: sl.get<BlockUser>(),
            blockCommunity: sl.get<BlockCommunity>(),
            unblockById: sl.get<UnblockById>(),
            getBlocks: sl.get<GetBlocks>(),
            checkBlockStatus: sl.get<CheckBlockStatus>(),
          ),
        ),
        BlocProvider(create: (context) => sl<ReportBloc>()),
        BlocProvider(create: (context) => sl<ExamTimetableBloc>()),
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(GetCachedProfileEvent()),
        ),
        BlocProvider(create: (context) => sl<todos.TodoListCubit>()),
        BlocProvider(create: (context) => sl<todos.TodoTagCubit>()),
        BlocProvider(create: (context) => sl<todos.TodoItemCubit>()),
        BlocProvider(create: (context) => sl<pomodoro.PomodoroCubit>()),
        BlocProvider(create: (context) => sl<CommunityListingCubit>()),
        BlocProvider(
          create: (context) => CreateCommunityBloc(
            createCommunityUseCase: sl<CreateCommunityUseCase>(),
          ),
        ),
        BlocProvider(create: (context) => sl<CommunityHomeBloc>()),
        BlocProvider(create: (context) => sl<CommunityUsersBloc>()),
        BlocProvider(create: (context) => sl<agenda.AgendaCubit>()),
        BlocProvider(create: (context) => sl<SemesterCubit>()),
        BlocProvider(create: (context) => sl<courses.CourseCubit>()),
        BlocProvider(create: (context) => sl<InstitutionBloc>()),
        BlocProvider(create: (context) => sl<PermissionCubit>()),
        BlocProvider(create: (context) => sl<LeaderboardBloc>()),
      ],
      child: DynamicColorBuilder(
        builder: (lightScheme, darkScheme) => MultiBlocListener(
          listeners: [
            BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (previous, current) =>
                  previous.courseRemindersEnabled !=
                      current.courseRemindersEnabled ||
                  !listEquals(
                    previous.courseReminderMinutes,
                    current.courseReminderMinutes,
                  ),
              listener: (context, state) {
                if (!_deferredServicesReady) return;
                sl<courses.CourseReminderRefresher>().updatePreferences(
                  enabled: state.courseRemindersEnabled,
                  reminderMinutes: state.courseReminderMinutes,
                );
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                AppRouter.router.refresh();
                if (state is AuthAuthenticated) {
                  context.read<FeedBloc>().add(CheckFeedLikeStatuses());
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
          ],
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final seedColor = Color(state.colorSeedValue);
              final surfaceColor = state.extraDarkMode
                  ? const Color(0xFF000000)
                  : null;

              ColorScheme buildColorScheme({
                required Brightness brightness,
                ColorScheme? preferredScheme,
              }) {
                final baseScheme =
                    preferredScheme ??
                    ColorScheme.fromSeed(
                      seedColor: seedColor,
                      brightness: brightness,
                    );

                return surfaceColor != null
                    ? baseScheme.copyWith(
                        surface: brightness == Brightness.light
                            ? null
                            : surfaceColor,
                      )
                    : baseScheme;
              }

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                showPerformanceOverlay: kProfileMode,
                themeMode: state.themeMode,
                theme: ThemeData(
                  fontFamily: FontFamily.productSans,
                  useMaterial3: state.enableMaterialYou,
                  brightness: Brightness.light,
                  colorScheme: buildColorScheme(
                    brightness: Brightness.light,
                    preferredScheme: state.automaticallyPickAccentColor
                        ? lightScheme
                        : null,
                  ),
                ),

                darkTheme: ThemeData(
                  fontFamily: FontFamily.productSans,
                  useMaterial3: state.enableMaterialYou,
                  brightness: Brightness.dark,
                  colorScheme: buildColorScheme(
                    brightness: Brightness.dark,
                    preferredScheme: state.automaticallyPickAccentColor
                        ? darkScheme
                        : null,
                  ),
                ),
                routerConfig: AppRouter.router,
                builder: (context, child) {
                  return BlocListener<InAppUpdateBloc, InAppUpdateState>(
                    listener: (context, state) {
                      final navigatorContext =
                          AppRouter.globalNavigatorKey.currentContext;
                      if (navigatorContext == null) return;

                      if (state is InAppUpdateRequired) {
                        unawaited(
                          AppUpdateRequiredRoute($extra: state.campaign)
                              .push(navigatorContext),
                        );
                      } else if (state is InAppUpdateOptional) {
                        unawaited(
                          AppUpdateOptionalRoute($extra: state.campaign)
                              .push(navigatorContext),
                        );
                      }
                    },
                    child: child ?? SizedBox.shrink(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
