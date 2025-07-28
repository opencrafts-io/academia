import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/data.dart';
import 'package:dartz/dartz.dart';

abstract class ChirpRemoteDataSource {
  Future<Either<Failure, List<PostModel>>> getFeedPosts();
}

class ChirpRemoteDataSourceImpl implements ChirpRemoteDataSource {
  @override
  Future<Either<Failure, List<PostModel>>> getFeedPosts() async {
    await Future.delayed(Duration(milliseconds: 500));
    return Right([
      PostModel(
        id: "127",
        userId: 'harrystyles',
        content: "Do you think we have any major belting ballads to look forward to in the future? Harry's House did not have much of that kind of vocals. Do you still think he has it in him, or has that ship sailed away?They are my all time favorites. I love when he stretches his vocals, but ive seen later(2023) concert videos with sign of the times where he didn't even attempt to carry the ending. Even with his songs like Adore You, he would speak sing at concerts \"walk through fire for you, just let me adore you\", instead of belting it like he used to.Do you think it is inability to carry those vocals, or is it him preserving his vocals so he can perform longer?",
        createdAt: DateTime.parse('2024-11-02T09:20:00Z'),
        updatedAt: DateTime.parse('2024-11-02T09:20:00Z'),
        likeCount: 121,
        attachments: [
        ],
        replies: [],
      ),
      PostModel(
        id: "123",
        userId: 'alice123',
        content: "There are definitely aspects of Harry’s House with belting vocals. The adlibs in Cinema and Daydreaming are two coming to my head right now, so he definitely still has the ability!",
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
            file:
                'https://strapi.dhiwise.com/uploads/mastering_flutter_release_on_android_ios_and_web_2_ffa2ce3b59.jpg',
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
          )
        ],
        replies: [],
      )
    ]);
  }
}
