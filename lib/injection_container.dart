import 'package:academia/config/flavor.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:get_it/get_it.dart';

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
  sl.registerLazySingleton<ShereheRemoteDataSource>(
    () => ShereheRemoteDataSource(dioClient: sl.get<DioClient>()),
  );
  sl.registerLazySingleton(
    () => CreateEventUseCase(sl.get<ShereheRepository>()),
  );
  sl.registerLazySingleton<ShereheLocalDataSource>(
    () => ShereheLocalDataSource(localDB: cacheDB),
  );

  sl.registerSingleton<ShereheRepository>(
    ShereheRepositoryImpl(
      remoteDataSource: sl.get<ShereheRemoteDataSource>(),
      localDataSource: sl.get<ShereheLocalDataSource>(),
    ),
  );

  sl.registerSingleton<GetEvent>(GetEvent(sl()));
  sl.registerLazySingleton(() => GetSpecificEvent(sl()));
  sl.registerLazySingleton(() => GetAttendee(sl()));
  sl.registerLazySingleton(() => CacheEventsUseCase(sl()));

  sl.registerFactory(
    () => ShereheHomeBloc(
      getEvent: sl(),
      getAttendee: sl(),
      cacheEventsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ShereheDetailsBloc(
      getSpecificEventUseCase: sl(),
      getAttendeesUseCase: sl(),
    ),
  );
  // Chirp
  sl.registerFactory<ChirpRemoteDataSource>(
    () => ChirpRemoteDataSource(dioClient: sl.get<DioClient>()),
  );
  sl.registerFactory<ChirpLocalDataSource>(
    () => ChirpLocalDataSource(db: cacheDB),
  );
  sl.registerFactory<ChirpRepository>(
    () => ChirpRepositoryImpl(
      remoteDataSource: sl.get<ChirpRemoteDataSource>(),
      localDataSource: sl.get<ChirpLocalDataSource>(),
    ),
  );
  sl.registerFactory(() => GetFeedPosts(sl()));
  sl.registerFactory(
    () => CachePostsUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => FeedBloc(
      getFeedPosts: sl.get<GetFeedPosts>(),
      cachePosts: sl.get<CachePostsUsecase>(),
    ),
  );
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

  // Todos
  sl.registerFactory<TodoLocalDatasource>(
    () => TodoLocalDatasource(localDB: cacheDB),
  );
  sl.registerFactory<TodoRemoteDatasource>(
    () => TodoRemoteDatasource(dioClient: sl.get<DioClient>()),
  );

  sl.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      todoRemoteDatasource: sl.get<TodoRemoteDatasource>(),
      todoLocalDatasource: sl.get<TodoLocalDatasource>(),
    ),
  );

  sl.registerFactory<GetCachedTodosUsecase>(
    () => GetCachedTodosUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  sl.registerFactory<RefreshTodosUsecase>(
    () => RefreshTodosUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<CreateTodoUsecase>(
    () => CreateTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<UpdateTodoUsecase>(
    () => UpdateTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );
  sl.registerFactory<CompleteTodoUsecase>(
    () => CompleteTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  sl.registerFactory<DeleteTodoUsecase>(
    () => DeleteTodoUsecase(todoRepository: sl.get<TodoRepository>()),
  );

  // Agenda
  sl.registerFactory<AgendaEventLocalDataSource>(
    () => AgendaEventLocalDataSource(localDB: cacheDB),
  );
  sl.registerFactory<AgendaEventRemoteDatasource>(
    () => AgendaEventRemoteDatasource(dioClient: sl.get<DioClient>()),
  );

  sl.registerFactory<AgendaEventRepository>(
    () => AgendaEventRepositoryImpl(
      agendaEventRemoteDatasource: sl.get<AgendaEventRemoteDatasource>(),
      agendaEventLocalDataSource: sl.get<AgendaEventLocalDataSource>(),
    ),
  );

  sl.registerFactory<GetCachedAgendaEventsUsecase>(
    () => GetCachedAgendaEventsUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<RefreshAgendaEventsUsecase>(
    () => RefreshAgendaEventsUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<CreateAgendaEventUsecase>(
    () => CreateAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<UpdateAgendaEventUsecase>(
    () => UpdateAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<DeleteAgendaEventUsecase>(
    () => DeleteAgendaEventUsecase(
      agendaEventRepository: sl.get<AgendaEventRepository>(),
    ),
  );

  sl.registerFactory<AgendaEventBloc>(
    () => AgendaEventBloc(
      getCachedAgendaEventsUsecase: sl.get<GetCachedAgendaEventsUsecase>(),
      refreshAgendaEventsUsecase: sl.get<RefreshAgendaEventsUsecase>(),
      createAgendaEventUsecase: sl.get<CreateAgendaEventUsecase>(),
      updateAgendaEventUsecase: sl.get<UpdateAgendaEventUsecase>(),
      deleteAgendaEventUsecase: sl.get<DeleteAgendaEventUsecase>(),
    ),
  );

  // Add Chirp dependencies
  sl.registerFactory<MessagingRemoteDatasourceImpl>(
    () => MessagingRemoteDatasourceImpl(dioClient: sl.get<DioClient>()),
  );
  sl.registerFactory<MessagingLocalDataSourceImpl>(
    () => MessagingLocalDataSourceImpl(localDB: cacheDB),
  );

  sl.registerFactory<ConversationRepositoryImpl>(
    () => ConversationRepositoryImpl(
      remoteDataSource: sl.get<MessagingRemoteDatasourceImpl>(),
      localDataSource: sl.get<MessagingLocalDataSourceImpl>(),
      chirpUserRemoteDataSource: sl.get<ChirpUserRemoteDatasource>(),
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
  sl.registerFactory<GetCachedConversations>(
    () => GetCachedConversations(sl.get<ConversationRepositoryImpl>()),
  );
  sl.registerFactory<GetCachedMessages>(
    () => GetCachedMessages(sl.get<MessageRepositoryImpl>()),
  );
  sl.registerFactory<RefreshConversations>(
    () => RefreshConversations(sl.get<ConversationRepositoryImpl>()),
  );
  sl.registerFactory<RefreshMessages>(
    () => RefreshMessages(sl.get<MessageRepositoryImpl>()),
  );
  sl.registerFactory<CreateConversation>(
    () => CreateConversation(sl.get<ConversationRepositoryImpl>()),
  );

  // Chirp User dependencies
  sl.registerFactory<ChirpUserRemoteDatasource>(
    () => ChirpUserRemoteDatasourceImpl(dioClient: sl.get<DioClient>()),
  );
  sl.registerFactory<ChirpUserRepository>(
    () => ChirpUserRepositoryImpl(
      remoteDataSource: sl.get<ChirpUserRemoteDatasource>(),
      localDataSource: sl.get<MessagingLocalDataSourceImpl>(),
    ),
  );
  sl.registerFactory<SearchUsersUseCase>(
    () => SearchUsersUseCase(sl.get<ChirpUserRepository>()),
  );

  sl.registerFactory<MessagingBloc>(
    () => MessagingBloc(
      getConversations: sl.get<GetConversations>(),
      getMessages: sl.get<GetMessages>(),
      sendMessage: sl.get<SendMessage>(),
      searchUsers: sl.get<SearchUsersUseCase>(),
      getCachedConversations: sl.get<GetCachedConversations>(),
      getCachedMessages: sl.get<GetCachedMessages>(),
      refreshConversations: sl.get<RefreshConversations>(),
      refreshMessages: sl.get<RefreshMessages>(),
      createConversation: sl.get<CreateConversation>(),
    ),
  );
}
