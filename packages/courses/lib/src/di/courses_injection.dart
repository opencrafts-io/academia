import 'package:courses/src/domain/institution_lookup.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'courses_injection.config.dart';

@InjectableInit(
  initializerName: 'initCourses',
  preferRelativeImports: true,
  asExtension: false,
)
void configureCoursesDependencies(
  GetIt getIt, {
  required InstitutionLookup institutionLookup,
}) {
  getIt.registerSingleton<InstitutionLookup>(institutionLookup);
  initCourses(getIt);
}
