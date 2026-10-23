import 'package:academia/features/chirp/posts/domain/domain.dart';

/// What a post card or detail header should render above the poll.
///
/// Poll-only posts are created with the poll question as their title (so
/// share text and notifications still read naturally); rendering that title
/// above the poll would just repeat the question, so it is hidden.
extension PostDisplay on Post {
  bool get showsTitle {
    final text = title.trim();
    if (text.isEmpty) return false;
    return poll == null || text != poll!.question.trim();
  }

  bool get showsContent => content.trim().isNotEmpty;
}
