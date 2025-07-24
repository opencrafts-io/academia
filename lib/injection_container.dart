import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/auth/data/datasources/profile_local_datasource.dart';
import 'package:academia/features/chirp/data/datasources/chirp_remote_data_source.dart';
import 'package:academia/features/chirp/data/repositories/chirp_repository_impl.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_repository.dart';
import 'package:academia/features/chirp/domain/usecases/get_feed_posts.dart';
import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:get_it/get_it.dart';

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

  // Chirp
  sl.registerSingleton<ChirpRemoteDataSource>(ChirpRemoteDataSourceImpl());
  sl.registerSingleton<ChirpRepository>(ChirpRepositoryImpl(sl()));
  sl.registerSingleton(GetFeedPosts(sl()));
  sl.registerFactory(() => FeedBloc(sl()));
}
