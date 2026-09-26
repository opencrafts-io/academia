import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/screens/add_edit_course_sheet.dart';
import 'package:courses/src/presentation/screens/course_detail_page.dart';
import 'package:courses/src/presentation/screens/course_history_page.dart';
import 'package:courses/src/presentation/screens/course_list_page.dart';
import 'package:courses/src/presentation/screens/lecturer_editor_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

part 'course_routes.g.dart';

@TypedGoRoute<CourseListRoute>(
  path: '/courses',
  routes: [
    TypedGoRoute<CreateCourseRoute>(path: 'create'),
    TypedGoRoute<CourseHistoryRoute>(path: 'history'),
    TypedGoRoute<CourseDetailRoute>(
      path: ':courseId',
      routes: [
        TypedGoRoute<EditCourseRoute>(path: 'edit'),
        TypedGoRoute<CreateLecturerRoute>(path: 'lecturers/create'),
        TypedGoRoute<EditLecturerRoute>(path: 'lecturers/:lecturerId/edit'),
      ],
    ),
  ],
)
class CourseListRoute extends GoRouteData with $CourseListRoute {
  const CourseListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => GetIt.instance<CourseCubit>(),
      child: const CourseListPage(),
    );
  }
}

class CreateCourseRoute extends GoRouteData with $CreateCourseRoute {
  const CreateCourseRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _editorSheetPage(
      context,
      state,
      BlocProvider(
        create: (_) => GetIt.instance<CourseCubit>(),
        child: const AddEditCourseSheet(),
      ),
    );
  }
}

class CourseHistoryRoute extends GoRouteData with $CourseHistoryRoute {
  const CourseHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => GetIt.instance<CourseCubit>(),
      child: const CourseHistoryPage(),
    );
  }
}

class EditCourseRoute extends GoRouteData with $EditCourseRoute {
  const EditCourseRoute({required this.courseId});

  final String courseId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _editorSheetPage(
      context,
      state,
      BlocProvider(
        create: (_) => GetIt.instance<CourseCubit>(),
        child: EditCourseSheet(courseId: courseId),
      ),
    );
  }
}

class CreateLecturerRoute extends GoRouteData with $CreateLecturerRoute {
  const CreateLecturerRoute({required this.courseId});

  final String courseId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _editorSheetPage(
      context,
      state,
      BlocProvider(
        create: (_) => GetIt.instance<CourseCubit>(),
        child: LecturerEditorSheet(courseId: courseId),
      ),
    );
  }
}

class EditLecturerRoute extends GoRouteData with $EditLecturerRoute {
  const EditLecturerRoute({required this.courseId, required this.lecturerId});

  final String courseId;
  final String lecturerId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return _editorSheetPage(
      context,
      state,
      BlocProvider(
        create: (_) => GetIt.instance<CourseCubit>(),
        child: LecturerEditorSheet(courseId: courseId, lecturerId: lecturerId),
      ),
    );
  }
}

Page<void> _editorSheetPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return ModalSheetPage(
    key: state.pageKey,
    swipeDismissible: true,
    transitionCurve: Curves.easeOutCubic,
    viewportBuilder: (context, child) => SheetViewport(
      padding: EdgeInsets.only(
        top: MediaQuery.viewPaddingOf(context).top,
        bottom: MediaQuery.viewPaddingOf(context).bottom,
      ),
      child: child,
    ),
    child: SheetKeyboardDismissible(
      dismissBehavior: SheetKeyboardDismissBehavior.onDragDown(
        isContentScrollAware: true,
      ),
      child: Sheet(
        scrollConfiguration: const SheetScrollConfiguration(),
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        decoration: const MaterialSheetDecoration(
          size: SheetSize.fit,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
        physics: BouncingSheetPhysics(),
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.9),
            child: child,
          ),
        ),
      ),
    ),
  );
}

class CourseDetailRoute extends GoRouteData with $CourseDetailRoute {
  const CourseDetailRoute({required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => GetIt.instance<CourseCubit>(),
      child: CourseDetailPage(courseId: courseId),
    );
  }
}
