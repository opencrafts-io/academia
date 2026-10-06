import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../cubit/study_tools_cubit.dart';
import '../cubit/podcast_cubit.dart';
import '../screens/study_material_page.dart';
import '../screens/study_practice_page.dart';
import '../screens/study_podcast_player_page.dart';
import '../screens/study_tools_page.dart';

part 'study_tools_routes.g.dart';

@TypedGoRoute<StudyToolsRoute>(
  path: '/study-tools',
  routes: [TypedGoRoute<StudyMaterialRoute>(path: 'material/:materialId')],
)
class StudyToolsRoute extends GoRouteData with $StudyToolsRoute {
  const StudyToolsRoute({this.courseId, this.courseLabel, this.courseLocalId});

  final String? courseId;
  final String? courseLabel;
  final String? courseLocalId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => _studyPage(
    context,
    state,
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<StudyToolsCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PodcastCubit>()),
      ],
      child: StudyToolsPage(
        courseId: courseId,
        courseLabel: courseLabel,
        courseLocalId: courseLocalId,
      ),
    ),
  );
}

class StudyMaterialRoute extends GoRouteData with $StudyMaterialRoute {
  const StudyMaterialRoute({required this.materialId});
  final int materialId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => _studyPage(
    context,
    state,
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<StudyToolsCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PodcastCubit>()),
      ],
      child: StudyMaterialPage(materialId: materialId),
    ),
  );
}

@TypedGoRoute<StudyPodcastPlayerRoute>(path: '/study-tools/podcast/:materialId')
class StudyPodcastPlayerRoute extends GoRouteData
    with $StudyPodcastPlayerRoute {
  const StudyPodcastPlayerRoute({required this.materialId, this.episodeKey});
  final int materialId;
  final String? episodeKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => _studyPage(
    context,
    state,
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<StudyToolsCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PodcastCubit>()),
      ],
      child: StudyPodcastPlayerPage(
        materialId: materialId,
        episodeKey: episodeKey,
      ),
    ),
  );
}

@TypedGoRoute<StudyPracticeRoute>(
  path: '/study-tools/practice/:materialId/:setId/:format',
)
class StudyPracticeRoute extends GoRouteData with $StudyPracticeRoute {
  const StudyPracticeRoute({
    required this.materialId,
    required this.setId,
    required this.format,
  });
  final int materialId;
  final int setId;
  final String format;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => _studyPage(
    context,
    state,
    BlocProvider(
      create: (_) => GetIt.instance<StudyToolsCubit>(),
      child: StudyPracticePage(
        materialId: materialId,
        setId: setId,
        format: format,
      ),
    ),
  );
}

Page<void> _studyPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: const Duration(milliseconds: 360),
  reverseTransitionDuration: const Duration(milliseconds: 280),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.macOS) {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: false,
        child: child,
      );
    }

    final entering = animation.drive(
      Tween<Offset>(
        begin: const Offset(0.035, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: entering, child: child),
    );
  },
);
