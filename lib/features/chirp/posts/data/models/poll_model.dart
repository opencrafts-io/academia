import 'package:academia/features/chirp/posts/domain/domain.dart';

/// Wire model for a poll option, matching the chirp polls contract
/// (see docs/api/chirp-polls-contract.md).
class PollOptionData {
  final int id;
  final String text;
  final int position;
  final int voteCount;

  const PollOptionData({
    required this.id,
    required this.text,
    required this.position,
    this.voteCount = 0,
  });

  factory PollOptionData.fromJson(Map<String, dynamic> json) {
    return PollOptionData(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String? ?? '',
      position: (json['position'] as num?)?.toInt() ?? 0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'position': position,
    'vote_count': voteCount,
  };

  PollOption toEntity() =>
      PollOption(id: id, text: text, position: position, voteCount: voteCount);
}

/// Wire model for a poll. Never persisted on its own — it rides inside the
/// post JSON blob (`PostTable.poll`), the same way comments/attachments do.
class PollData {
  final int id;
  final int postId;
  final String question;
  final bool allowsMultiple;
  final bool isAnonymous;
  final DateTime? endsAt;
  final int totalVotes;
  final List<int> myVotes;
  final List<PollOptionData> options;

  const PollData({
    required this.id,
    required this.postId,
    required this.question,
    this.allowsMultiple = false,
    this.isAnonymous = false,
    this.endsAt,
    this.totalVotes = 0,
    this.myVotes = const [],
    this.options = const [],
  });

  factory PollData.fromJson(Map<String, dynamic> json) {
    return PollData(
      id: (json['id'] as num).toInt(),
      postId: (json['post'] as num?)?.toInt() ?? 0,
      question: json['question'] as String? ?? '',
      allowsMultiple: json['allows_multiple'] as bool? ?? false,
      isAnonymous: json['is_anonymous'] as bool? ?? false,
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.tryParse(json['ends_at'] as String)?.toLocal(),
      totalVotes: (json['total_votes'] as num?)?.toInt() ?? 0,
      myVotes:
          (json['my_votes'] as List?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      options:
          (json['options'] as List?)
              ?.map(
                (e) => PollOptionData.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'post': postId,
    'question': question,
    'allows_multiple': allowsMultiple,
    'is_anonymous': isAnonymous,
    'ends_at': endsAt?.toUtc().toIso8601String(),
    'total_votes': totalVotes,
    'my_votes': myVotes,
    'options': options.map((o) => o.toJson()).toList(),
  };

  Poll toEntity() => Poll(
    id: id,
    postId: postId,
    question: question,
    allowsMultiple: allowsMultiple,
    isAnonymous: isAnonymous,
    endsAt: endsAt,
    totalVotes: totalVotes,
    myVotes: myVotes,
    options: options.map((o) => o.toEntity()).toList(),
  );
}

/// Wire model for a single voter row from the voters endpoint.
class PollVoterData {
  final String userId;
  final List<int> optionIds;
  final DateTime votedAt;

  const PollVoterData({
    required this.userId,
    required this.optionIds,
    required this.votedAt,
  });

  factory PollVoterData.fromJson(Map<String, dynamic> json) {
    return PollVoterData(
      userId: json['user_id'].toString(),
      optionIds:
          (json['option_ids'] as List?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      votedAt:
          DateTime.tryParse(json['voted_at'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'option_ids': optionIds,
    'voted_at': votedAt.toUtc().toIso8601String(),
  };

  PollVoter toEntity() =>
      PollVoter(userId: userId, optionIds: optionIds, votedAt: votedAt);
}

extension PollEntityHelper on Poll {
  PollData toData() => PollData(
    id: id,
    postId: postId,
    question: question,
    allowsMultiple: allowsMultiple,
    isAnonymous: isAnonymous,
    endsAt: endsAt,
    totalVotes: totalVotes,
    myVotes: myVotes,
    options: options
        .map(
          (o) => PollOptionData(
            id: o.id,
            text: o.text,
            position: o.position,
            voteCount: o.voteCount,
          ),
        )
        .toList(),
  );
}
