import 'package:academia/core/network/chirp_dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/features/chirp/data/data.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:dio/dio.dart';

class ChirpRemoteDataSource with DioErrorHandler {
  final ChirpDioClient chirpDio;

  ChirpRemoteDataSource({required this.chirpDio});

  Future<Either<Failure, List<Post>>> getPosts() async {
    //   // --- Dummy Data for Testing ---
    //   // Simulate a successful response after a short delay
    await Future.delayed(const Duration(seconds: 2));

    final List<Map<String, dynamic>> dummyJsonData = [
      {
        "id": 1,
        "user_id": "johndoe_123",
        "content": "Hello world from the dummy data! This is my first chirp.",
        "created_at": "2025-07-29T10:00:00Z",
        "updated_at": "2025-07-29T10:00:00Z",
        "like_count": 15,
        "attachments": [
          {
            "id": 105,
            "attachment_type": "image",
            "file": "https://picsum.photos/id/237/200/300",
            "created_at": "2025-07-29T10:05:00Z",
          },
          {
            "id": 106,
            "attachment_type": "image",
            "file": "https://picsum.photos/id/237/200/300",
            "created_at": "2025-07-29T10:05:00Z",
          },
        ],
        "replies": [
          {
            "id": 205,
            "user_id": "alice_456",
            "content": "Great first chirp, John!",
            "created_at": "2025-07-29T10:10:00Z",
            "updated_at": "2025-07-29T10:10:00Z",
          },
          {
            "id": 216,
            "user_id": "taylor_13",
            "content": "Dear John, I see it all now that you're gone",
            "created_at": "2025-07-29T10:10:00Z",
            "updated_at": "2025-07-29T10:10:00Z",
          },
          {
            "id": 207,
            "user_id": "swift_13",
            "content": "Don't you think I was too young to be messed with?",
            "created_at": "2025-07-29T10:10:00Z",
            "updated_at": "2025-07-29T10:10:00Z",
          },
        ],
      },
      {
        "id": 2,
        "user_id": "janedoe_456",
        "content": "Enjoying the beautiful Nairobi weather today!",
        "created_at": "2025-07-29T11:30:00Z",
        "updated_at": "2025-07-29T11:30:00Z",
        "like_count": 25,
        "attachments": [
          {
            "id": 110,
            "attachment_type": "video",
            "file": "https://www.w3schools.com/html/mov_bbb.mp4",
            "created_at": "2025-07-29T10:06:00Z",
          },
        ],
        "replies": [
          {
            "id": 202,
            "user_id": "charlie_789",
            "content": "Me too, Jane! Perfect day.",
            "created_at": "2025-07-29T11:40:00Z",
            "updated_at": "2025-07-29T11:40:00Z",
          },
          {
            "id": 213,
            "user_id": "johndoe_123",
            "content": "Wish I was there!",
            "created_at": "2025-07-29T11:45:00Z",
            "updated_at": "2025-07-29T11:45:00Z",
          },
          
          {
            "id": 206,
            "user_id": "taylor_13",
            "content": "Take me to the place where all the poets went to die",
            "created_at": "2025-07-31T10:10:00Z",
            "updated_at": "2025-07-31T10:10:00Z",
          },
          {
            "id": 204,
            "user_id": "janedoe_123",
            "content": "It was rare, I was there!",
            "created_at": "2025-08-02T11:45:00Z",
            "updated_at": "2025-08-02T11:45:00Z",
          },
        ],
      },
      {
        "id": 3,
        "user_id": "bob_987",
        "content": "Just finished reading a fantastic book. Highly recommend!",
        "created_at": "2025-07-29T14:00:00Z",
        "updated_at": "2025-07-29T14:00:00Z",
        "like_count": 8,
        "attachments": [
          
        ],
        "replies": [
          {
            "id": 201,
            "user_id": "charlie_789",
            "content": "Pardon me, are you Aaron Burr sir?",
            "created_at": "2025-07-30T11:40:00Z",
            "updated_at": "2025-07-30T11:40:00Z",
          },
          {
            "id": 203,
            "user_id": "johndoe_123",
            "content": "That depends, who's asking",
            "created_at": "2025-07-31T11:45:00Z",
            "updated_at": "2025-07-31T11:45:00Z",
          },
        ],
      },
    ];

    try {
      final posts = dummyJsonData.map<Post>((json) {

        final post = Post(
          id: json["id"].toString(),
          userId: json["user_id"],
          content: json["content"] ?? 'mama',
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          likeCount: json['like_count'],
          attachments: (json["attachments"] as List).isNotEmpty
              ? (json["attachments"])
                    .map(
                      (a) => Attachments(
                        id: a["id"]?.toString() ?? '',
                        postId: json["id"]?.toString() ?? '',
                        attachmentType: a["attachment_type"] ?? '',
                        file: a["file"] ?? '',
                        createdAt: DateTime.parse(a['created_at']),
                        updatedAt: a['updated_at'] != null
                            ? DateTime.parse(a['updated_at'])
                            : null,
                      ),
                    )
                    .toList()
                    .cast<Attachments>()
              : [],
          replies: (json["replies"] as List).isNotEmpty
              ? (json["replies"])
                    .map(
                      (r) => PostReply(
                        id: r["id"]?.toString() ?? '',
                        postId: json["id"]?.toString() ?? '',
                        userId: r["user_id"] ?? '',
                        content: r["content"] ?? '',
                        createdAt: DateTime.parse(r['created_at']),
                        updatedAt: r['updated_at'] != null
                            ? DateTime.parse(r['updated_at'])
                            : null,
                      ),
                    )
                    .toList()
                    .cast<PostReply>()
              : [],
        );

        return post;
      }).toList();

      return Right(posts);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "$e We couldn't fetch your feed please try again later",
        ),
      );
    }
  }

  // Future<Either<Failure, List<Post>>> getPosts() async {
  //   try {
  //     final res = await chirpDio.dio.get("/statuses/");

  //     if (res.statusCode == 200 && res.data is List) {
  //       final List<Post> posts = (res.data as List)
  //           .map((json) => PostHelper.fromJson(json))
  //           .toList();
  //       return Right(posts);
  //     } else {
  //       return Left(
  //         NetworkFailure(message: "Unexpected response", error: res.data),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return handleDioError(e);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString(), error: e));
  //   }
  // }
}
