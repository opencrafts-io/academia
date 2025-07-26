import 'package:academia/features/chirp/data/models/post_model.dart';

abstract class ChirpRemoteDataSource {
  Future<List<PostModel>> getFeedPosts();
}

class ChirpRemoteDataSourceImpl implements ChirpRemoteDataSource {
  @override
  Future<List<PostModel>> getFeedPosts() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      PostModel(
        id: '1',
        title: 'Welcome to c/flutter',
        content:
            'This is your first post! Feel free to ask questions, share your progress, or explore widgets and state management tips with others in the Flutter community.',
        communityName: 'flutter',
        upvotes: 123,
        comments: 4,
        imageUrl: null,
      ),
      PostModel(
        id: '2',
        title: 'Top 10 tips for learning Dart',
        content:
            'If you\'re new to Dart, start with understanding the type system, then focus on collections (List, Set, Map). Learn how async/await works—it’s crucial for Flutter apps.',
        communityName: 'dartlang',
        upvotes: 210,
        comments: 12,
        imageUrl: null,
      ),
      PostModel(
        id: '3',
        title: 'Showcase: My portfolio built in Flutter Web!',
        content:
            'Spent the last 3 weeks building my portfolio using Flutter Web. It’s hosted on Firebase, uses Riverpod for state management, and looks great on both desktop and mobile. Check it out!',
        communityName: 'flutterdev',
        upvotes: 430,
        comments: 38,
        imageUrl:
            'https://strapi.dhiwise.com/uploads/mastering_flutter_release_on_android_ios_and_web_2_ffa2ce3b59.jpg',
      ),
      PostModel(
        id: '4',
        title: 'Why I switched from React Native to Flutter',
        content:
            'After two years of RN, I tried Flutter for a side project. The setup was cleaner, hot reload was faster, and widget composition just made sense. Here’s my full story and benchmarks...',
        communityName: 'mobiledev',
        upvotes: 332,
        comments: 27,
        imageUrl: null,
      ),
      PostModel(
        id: '5',
        title: 'Can someone explain BLoC vs Riverpod?',
        content:
            'I\'m learning state management and got stuck between choosing BLoC and Riverpod. BLoC seems verbose but structured; Riverpod is more concise but has its own learning curve. Which one scales better?',
        communityName: 'flutterhelp',
        upvotes: 156,
        comments: 19,
        imageUrl: null,
      ),
      PostModel(
        id: '6',
        title: 'Building a social media app clone in Flutter',
        content:
            'Started working on a Twitter/Reddit hybrid using Flutter + Firebase. Using Cloud Firestore for posts, Firebase Auth for login, and Riverpod for state. Open-source repo coming soon!',
        communityName: 'devlogs',
        upvotes: 499,
        comments: 88,
        imageUrl:
            'https://strapi.dhiwise.com/uploads/mastering_flutter_release_on_android_ios_and_web_2_ffa2ce3b59.jpg',
      ),
    ];
  }
}
