part of '../injection_container.dart';

void _registerChirp(GetIt sl, FlavorConfig flavor) {
  //                    --- Posts ----
  sl.registerFactory<ChirpPostLocalDataSource>(
    () => ChirpPostLocalDataSource(db: sl()),
  );
  sl.registerFactory<ChirpRemoteDataSource>(
    () => ChirpRemoteDataSource(dioClient: sl.get<DioClient>(), flavor: flavor),
  );
  // Polls
  sl.registerFactory<PollRemoteDataSource>(
    () => ChirpPollRemoteDataSource(
      dioClient: sl.get<DioClient>(),
      flavor: flavor,
    ),
  );
  sl.registerFactory<ChirpRepository>(
    () => ChirpRepositoryImpl(
      remoteDataSource: sl.get<ChirpRemoteDataSource>(),
      localDataSource: sl<ChirpPostLocalDataSource>(),
      pollRemoteDataSource: sl<PollRemoteDataSource>(),
    ),
  );
  sl.registerFactory(() => GetFeedPostsUsecase(sl()));
  sl.registerFactory<GetPostsFromCommunityUsecase>(
    () => GetPostsFromCommunityUsecase(repository: sl()),
  );
  sl.registerFactory(
    () => CreatePostUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => CreatePostAttachmentUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => GetPostDetailUseCase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => MarkPostAsViewedUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => GetPostCommentsUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => AddCommentUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => DeletePostUsecase(repository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => DeletePostCommentUsecase(repository: sl.get<ChirpRepository>()),
  );

  sl.registerFactory(
    () => LikePostUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => VoteOnPollUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => RetractPollVoteUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => GetPollVotersUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => CheckPostLikedUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => LikeCommentUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => CheckCommentLikedUsecase(chirpRepository: sl.get<ChirpRepository>()),
  );
  sl.registerFactory(
    () => FeedBloc(
      getPostsFromCommunityUsecase: sl<GetPostsFromCommunityUsecase>(),
      getFeedPosts: sl.get<GetFeedPostsUsecase>(),
      createPost: sl.get<CreatePostUsecase>(),
      getPostDetail: sl.get<GetPostDetailUseCase>(),
      markPostAsViewed: sl.get<MarkPostAsViewedUsecase>(),
      createPostAttachment: sl.get<CreatePostAttachmentUsecase>(),
      deletePost: sl.get<DeletePostUsecase>(),
      likePost: sl.get<LikePostUsecase>(),
      voteOnPoll: sl.get<VoteOnPollUsecase>(),
      retractPollVote: sl.get<RetractPollVoteUsecase>(),
      checkPostLiked: sl.get<CheckPostLikedUsecase>(),
      // addComment: sl.get<CommentUsecase>(),
      // getPostReplies: sl.get<GetPostRepliesUsecase>(),
    ),
  );
  sl.registerFactory(
    () => CommentBloc(
      addComment: sl.get<AddCommentUsecase>(),
      getPostComments: sl.get<GetPostCommentsUsecase>(),
      likeComment: sl.get<LikeCommentUsecase>(),
      checkCommentLiked: sl.get<CheckCommentLikedUsecase>(),
    ),
  );

  //     ---Block and Report----

  sl.registerFactory(
    () => BlockBloc(
      blockUser: sl(),
      blockCommunity: sl(),
      unblockById: sl(),
      getBlocks: sl(),
      checkBlockStatus: sl(),
    ),
  );

  sl.registerFactory(() => ReportBloc(reportContent: sl(), getReports: sl()));

  //Use Cases
  sl.registerFactory(() => BlockUser(sl()));
  sl.registerFactory(() => BlockCommunity(sl()));
  sl.registerFactory(() => UnblockById(sl()));
  sl.registerFactory(() => GetBlocks(sl()));
  sl.registerFactory(() => CheckBlockStatus(sl()));
  sl.registerFactory(() => ReportContent(sl()));
  sl.registerFactory(() => GetReports(sl()));

  // Repository
  sl.registerFactory<InteractionsRepository>(
    () => InteractionsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  //Data Sources
  sl.registerFactory<InteractionsRemoteDataSource>(
    () => InteractionsRemoteDataSource(dioClient: sl(), flavor: sl()),
  );

  sl.registerFactory<InteractionsLocalDataSource>(
    () => InteractionsLocalDataSource(db: sl()),
  );
}
