import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/auth/data/datasources/profile_local_datasource.dart';
import 'package:get_it/get_it.dart';

import 'features/sherehe/data/datasources/sherehe_remote_datasource.dart';
import 'features/sherehe/data/repository/sherehe_repository_impl.dart';
import 'features/sherehe/domain/repository/sherehe_repository.dart';
import 'features/sherehe/domain/usecases/get_all_attendees.dart';
import 'features/sherehe/domain/usecases/get_specific_event.dart';
import 'features/sherehe/presentation/bloc/sherehe_details_bloc.dart';

final sl = GetIt.instance;
Future<void> init(FlavorConfig flavor) async {
  // Register the flavor
  sl.registerSingleton<FlavorConfig>(flavor);

  final cacheDB = sl.registerSingleton<AppDataBase>(AppDataBase());
  sl.registerFactory<DioClient>(() => DioClient(flavor));

  sl.registerFactory(() => AuthLocalDatasource(localDB: cacheDB));
  sl.registerFactory(() => AuthRemoteDatasource(flavorConfig: flavor));
  sl.registerFactory(() => ProfileLocalDatasource(localDB: cacheDB));

  sl.registerFactory<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: sl.get<AuthRemoteDatasource>(),
      authLocalDatasource: sl.get<AuthLocalDatasource>(),
    ),
  );

  sl.registerFactory<SignInWithGoogleUsecase>(
    () => SignInWithGoogleUsecase(sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<SignInWithSpotifyUsecase>(
    () => SignInWithSpotifyUsecase(sl.get<AuthRepositoryImpl>()),
  );

  sl.registerFactory<GetPreviousAuthState>(
    () => GetPreviousAuthState(sl.get<AuthRepositoryImpl>()),
  );
  //Sherehe-details-config
  sl.registerLazySingleton<ShereheRemoteDataSource>(
        () => ShereheRemoteDataSource(),
  );
  sl.registerLazySingleton<ShereheRepository>(
        () => ShereheRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetSpecificEvent(sl())); // sl() resolves to ShereheRepository
  sl.registerLazySingleton(() => GetAttendee(sl()));
  sl.registerFactory(
        () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(), // sl() resolves to GetSpecificEvent
      getAttendeesUseCase: sl(),    // sl() resolves to GetAttendee
    ),
  );

}
