import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:analytics/analytics.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/agenda_api_paths.dart';
import '../data/datasources/agenda_remote_datasource.dart';
import '../data/repositories/agenda_repository_impl.dart';
import '../domain/repositories/agenda_repository.dart';
import '../domain/usecases/create_agenda_event.dart';
import '../domain/usecases/delete_agenda_event.dart';
import '../domain/usecases/list_agenda_events.dart';
import '../domain/usecases/update_agenda_event.dart';
import '../presentation/cubit/agenda_cubit.dart';

void configureAgendaDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AgendaApiPaths>(
    () => AgendaApiPaths(getIt<FlavorConfig>()),
  );
  getIt.registerLazySingleton<AgendaRemoteDatasource>(
    () => AgendaRemoteDatasource(getIt<ApiClient>(), getIt<AgendaApiPaths>()),
  );
  getIt.registerLazySingleton<AgendaRepository>(
    () => AgendaRepositoryImpl(getIt<AgendaRemoteDatasource>()),
  );
  getIt.registerFactory<ListAgendaEvents>(
    () => ListAgendaEvents(getIt<AgendaRepository>()),
  );
  getIt.registerFactory<CreateAgendaEvent>(
    () => CreateAgendaEvent(getIt<AgendaRepository>()),
  );
  getIt.registerFactory<UpdateAgendaEvent>(
    () => UpdateAgendaEvent(getIt<AgendaRepository>()),
  );
  getIt.registerFactory<DeleteAgendaEvent>(
    () => DeleteAgendaEvent(getIt<AgendaRepository>()),
  );
  getIt.registerFactory<AgendaCubit>(
    () => AgendaCubit(
      listAgendaEvents: getIt<ListAgendaEvents>(),
      createAgendaEvent: getIt<CreateAgendaEvent>(),
      updateAgendaEvent: getIt<UpdateAgendaEvent>(),
      deleteAgendaEvent: getIt<DeleteAgendaEvent>(),
      analyticsTracker: getIt<AnalyticsTracker>(),
    ),
  );
}
