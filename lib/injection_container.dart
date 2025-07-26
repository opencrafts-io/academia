import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/auth/data/datasources/profile_local_datasource.dart';
import 'package:get_it/get_it.dart';
//Sherehe Imports
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';

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
  sl.registerLazySingleton(() => GetSpecificEvent(sl()));
  sl.registerLazySingleton(() => GetAttendee(sl()));
  sl.registerFactory(
        () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(),
      getAttendeesUseCase: sl(),
    ),
  );

}
