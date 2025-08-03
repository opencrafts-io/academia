import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/data.dart';
import 'package:dartz/dartz.dart';

abstract class ChirpRemoteDataSource {
  Future<Either<Failure, List<PostModel>>> getFeedPosts();

  Future<Either<Failure, PostModel>> getPostById(String postId);
}

class ChirpRemoteDataSourceImpl implements ChirpRemoteDataSource {
  // Simulated in-memory post data (used by both getFeedPosts and getPostById)
  final List<PostModel> _mockPosts = [
    PostModel(
      id: "123",
      userId: 'alice123',
      content: "Exploring how Flutter handles custom render objects. It's wild!",
      createdAt: DateTime.parse('2024-11-01T10:00:00Z'),
      updatedAt: DateTime.parse('2024-11-01T10:00:00Z'),
      likeCount: 88,
      attachments: [
        AttachmentModel(
          attachmentType: 'image',
          file: 'https://strapi.dhiwise.com/uploads/mastering_flutter_release_on_android_ios_and_web_2_ffa2ce3b59.jpg',
          createdAt: DateTime.parse('2024-11-01T10:00:00Z'),
        ),
        AttachmentModel(
          attachmentType: 'image',
          file: 'https://strapi.dhiwise.com/uploads/mastering_flutter_release_on_android_ios_and_web_2_ffa2ce3b59.jpg',
          createdAt: DateTime.parse('2024-11-01T10:00:00Z'),
        ),
      ],
      replies: [
        ReplyModel(
          userId: 'dev_guy',
          content: 'Do you have a sample repo?',
          createdAt: DateTime.parse('2024-11-01T11:00:00Z'),
          updatedAt: DateTime.parse('2024-11-01T11:00:00Z'),
        ),
      ],
    ),
    PostModel(
      id: "125",
      userId: 'buildmaster',
      content: 'Check out my latest Flutter package that simplifies form validation 🔥',
      createdAt: DateTime.parse('2024-11-02T09:20:00Z'),
      updatedAt: DateTime.parse('2024-11-02T09:20:00Z'),
      likeCount: 121,
      attachments: [
        AttachmentModel(
          attachmentType: 'video',
          file: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          createdAt: DateTime.parse('2024-11-02T09:20:00Z'),
        ),
      ],
      replies: [],
    ),
  ];

  @override
  Future<Either<Failure, List<PostModel>>> getFeedPosts() async {
    await Future.delayed(Duration(milliseconds: 500));
    return Right(_mockPosts);
  }

  @override
  Future<Either<Failure, PostModel>> getPostById(String postId) async {
    await Future.delayed(Duration(milliseconds: 500));

    final post = _mockPosts.firstWhere((post) => post.id == postId);

    return Right(post);
  }
}
