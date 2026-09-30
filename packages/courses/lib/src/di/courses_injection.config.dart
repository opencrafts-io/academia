// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core/config/flavor.dart' as _i666;
import 'package:core/core.dart' as _i494;
import 'package:database/database.dart' as _i252;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/datasources/course_api_paths.dart' as _i888;
import '../data/datasources/course_remote_datasource.dart' as _i33;
import '../data/repositories/course_repository_impl.dart' as _i1039;
import '../domain/domain.dart' as _i515;
import '../domain/repositories/course_repository.dart' as _i720;
import '../domain/usecases/course_usecases.dart' as _i433;
import '../presentation/bloc/course_cubit.dart' as _i939;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initCourses(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i888.CourseApiPaths>(
    () => _i888.CourseApiPaths(gh<_i666.FlavorConfig>()),
  );
  gh.lazySingleton<_i33.CourseRemoteDatasource>(
    () => _i33.CourseRemoteDatasourceImpl(
      gh<_i494.ApiClient>(),
      gh<_i888.CourseApiPaths>(),
    ),
  );
  gh.lazySingleton<_i515.CourseRepository>(
    () => _i1039.CourseRepositoryImpl(
      gh<_i33.CourseRemoteDatasource>(),
      gh<_i252.CourseDao>(),
    ),
  );
  gh.factory<_i433.CreateCourse>(
    () => _i433.CreateCourse(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.ListActiveCourses>(
    () => _i433.ListActiveCourses(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.ListArchivedCourses>(
    () => _i433.ListArchivedCourses(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.GetCourse>(
    () => _i433.GetCourse(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.UpdateCourse>(
    () => _i433.UpdateCourse(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.ArchiveCourse>(
    () => _i433.ArchiveCourse(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.DeleteCourse>(
    () => _i433.DeleteCourse(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.AddLecturer>(
    () => _i433.AddLecturer(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.UpdateLecturer>(
    () => _i433.UpdateLecturer(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i433.DeleteLecturer>(
    () => _i433.DeleteLecturer(gh<_i720.CourseRepository>()),
  );
  gh.factory<_i939.CourseCubit>(
    () => _i939.CourseCubit(
      gh<_i433.CreateCourse>(),
      gh<_i433.ListActiveCourses>(),
      gh<_i433.ListArchivedCourses>(),
      gh<_i433.GetCourse>(),
      gh<_i433.UpdateCourse>(),
      gh<_i433.ArchiveCourse>(),
      gh<_i433.DeleteCourse>(),
      gh<_i433.AddLecturer>(),
      gh<_i433.UpdateLecturer>(),
      gh<_i433.DeleteLecturer>(),
      gh<_i515.InstitutionLookup>(),
    ),
  );
  return getIt;
}
