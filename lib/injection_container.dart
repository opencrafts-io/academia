import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/core/network/chirp_dio_client.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/chirp/data/datasources/chirp_user_remote_datasource.dart';
import 'package:academia/features/chirp/data/datasources/chirp_user_local_datasource.dart';
import 'package:academia/features/chirp/data/datasources/user_search_remote_datasource.dart';
import 'package:academia/features/chirp/data/repositories/chirp_user_repository_impl.dart';
import 'package:academia/features/chirp/domain/usecases/chirp_users/get_chirp_users.dart';
import 'package:academia/features/chirp/domain/usecases/chirp_users/get_chirp_user_by_id.dart';
import 'package:academia/features/chirp/domain/usecases/chirp_users/search_chirp_users.dart';
import 'package:academia/features/chirp/domain/usecases/search_users_usecase.dart';

import 'package:academia/features/chirp/domain/usecases/conversations/mark_message_as_read.dart';
import 'package:academia/features/chirp/domain/usecases/conversations/delete_message.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:get_it/get_it.dart';
import 'features/sherehe/presentation/presentation.dart';

final sl = GetIt.instance;
Future<void> init(FlavorConfig flavor) async {
  // Register the flavor
  sl.registerSingleton<FlavorConfig>(flavor);

  final cacheDB = sl.registerSingleton<AppDataBase>(AppDataBase());

  sl.registerFactory<AuthLocalDatasource>(
    () => AuthLocalDatasource(localDB: cacheDB),
  );
  sl.registerFactory(() => AuthRemoteDatasource(flavorConfig: flavor));

  sl.registerFactory<DioClient>(
    () => DioClient(flavor, authLocalDatasource: sl.get<AuthLocalDatasource>()),
  );
  sl.registerFactory<ChirpDioClient>(
    () => ChirpDioClient(authLocalDatasource: sl.get<AuthLocalDatasource>()),
  );
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

  //sherehe
  sl.registerSingleton<ShereheRemoteDataSource>(ShereheRemoteDataSource());

  sl.registerSingleton<ShereheRepository>(
    ShereheRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerSingleton<GetEvent>(GetEvent(sl()));
  sl.registerLazySingleton(() => GetSpecificEvent(sl()));
  sl.registerLazySingleton(() => GetAttendee(sl()));

  sl.registerFactory(() => EventBloc(getEvent: sl(), getAttendee: sl()));

  sl.registerFactory(
    () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(),
      getAttendeesUseCase: sl(),
    ),
  );
  // Chirp
  sl.registerSingleton<ChirpRemoteDataSource>(ChirpRemoteDataSourceImpl());
  sl.registerSingleton<ChirpRepository>(ChirpRepositoryImpl(sl()));
  sl.registerSingleton(GetFeedPosts(sl()));
  sl.registerFactory(() => FeedBloc(sl()));
  sl.registerFactory<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasource(dioClient: sl.get<DioClient>()),
  );
  sl.registerFactory<ProfileLocalDatasource>(
    () => ProfileLocalDatasource(localDB: cacheDB),
  );

  sl.registerFactory<ProfileRepositoryImpl>(
    () => ProfileRepositoryImpl(
      profileLocalDatasource: sl.get<ProfileLocalDatasource>(),
      profileRemoteDatasource: sl.get<ProfileRemoteDatasource>(),
    ),
  );

  sl.registerFactory<RefreshCurrentUserProfileUsecase>(
    () => RefreshCurrentUserProfileUsecase(
      profileRepository: sl.get<ProfileRepositoryImpl>(),
    ),
  );

  sl.registerFactory<UpdateUserProfile>(
    () => UpdateUserProfile(profileRepository: sl.get<ProfileRepositoryImpl>()),
  );

  sl.registerFactory<UpdateUserPhone>(
    () => UpdateUserPhone(profileRepository: sl.get<ProfileRepositoryImpl>()),
  );

  sl.registerFactory<GetCachedProfileUsecase>(
    () => GetCachedProfileUsecase(
      profileRepository: sl.get<ProfileRepositoryImpl>(),
    ),
  );

  // Add Chirp dependencies
  sl.registerFactory<MessagingRemoteDatasourceImpl>(
    () => MessagingRemoteDatasourceImpl(dioClient: sl.get<ChirpDioClient>()),
  );
  sl.registerFactory<MessagingLocalDataSourceImpl>(
    () => MessagingLocalDataSourceImpl(localDB: cacheDB),
  );
  sl.registerFactory<ConversationRepositoryImpl>(
    () => ConversationRepositoryImpl(
      remoteDataSource: sl.get<MessagingRemoteDatasourceImpl>(),
      localDataSource: sl.get<MessagingLocalDataSourceImpl>(),
      chirpUserRemoteDataSource: sl.get<ChirpUserRemoteDatasourceImpl>(),
    ),
  );
  sl.registerFactory<MessageRepositoryImpl>(
    () => MessageRepositoryImpl(
      remoteDataSource: sl.get<MessagingRemoteDatasourceImpl>(),
      localDataSource: sl.get<MessagingLocalDataSourceImpl>(),
    ),
  );

  sl.registerFactory<GetConversations>(
    () => GetConversations(sl.get<ConversationRepositoryImpl>()),
  );
  sl.registerFactory<GetMessages>(
    () => GetMessages(sl.get<MessageRepositoryImpl>()),
  );
  sl.registerFactory<SendMessage>(
    () => SendMessage(sl.get<MessageRepositoryImpl>()),
  );
  sl.registerFactory<MarkMessageAsRead>(
    () => MarkMessageAsRead(sl.get<MessageRepositoryImpl>()),
  );
  sl.registerFactory<DeleteMessage>(
    () => DeleteMessage(sl.get<MessageRepositoryImpl>()),
  );

  // Chirp User dependencies
  sl.registerFactory<ChirpUserRemoteDatasourceImpl>(
    () => ChirpUserRemoteDatasourceImpl(dioClient: sl.get<ChirpDioClient>()),
  );
  sl.registerFactory<ChirpUserLocalDataSourceImpl>(
    () => ChirpUserLocalDataSourceImpl(localDB: cacheDB),
  );

  sl.registerFactory<ChirpUserRepositoryImpl>(
    () => ChirpUserRepositoryImpl(
      remoteDataSource: sl.get<ChirpUserRemoteDatasourceImpl>(),
      localDataSource: sl.get<ChirpUserLocalDataSourceImpl>(),
    ),
  );

  sl.registerFactory<GetChirpUsers>(
    () => GetChirpUsers(sl.get<ChirpUserRepositoryImpl>()),
  );
  sl.registerFactory<GetChirpUserById>(
    () => GetChirpUserById(sl.get<ChirpUserRepositoryImpl>()),
  );
  sl.registerFactory<SearchChirpUsers>(
    () => SearchChirpUsers(sl.get<ChirpUserRepositoryImpl>()),
  );

  // User Search dependencies - Updated to use ChirpUser
  // User Search dependencies
  sl.registerFactory<UserSearchRemoteDatasourceImpl>(
    () => UserSearchRemoteDatasourceImpl(dioClient: sl.get<ChirpDioClient>()),
  );
  sl.registerFactory<SearchUsersUseCase>(
    () => SearchUsersUseCase(sl.get<ChirpUserRepositoryImpl>()),
  );

  sl.registerFactory<MessagingBloc>(
    () => MessagingBloc(
      getConversations: sl.get<GetConversations>(),
      getMessages: sl.get<GetMessages>(),
      sendMessage: sl.get<SendMessage>(),
      searchUsers: sl.get<SearchUsersUseCase>(),
    ),
  );
}
