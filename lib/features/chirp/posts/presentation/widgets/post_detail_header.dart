import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_since/time_since.dart';

const _defaultAvatarUrl =
    'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';

/// Author row, title, and body text at the top of the post detail screen.
class PostDetailHeader extends StatelessWidget {
  const PostDetailHeader({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ChirpUserCubit>()..getChirpUserByID(post.authorId),
      child: BlocBuilder<ChirpUserCubit, ChirpUserState>(
        builder: (context, state) {
          final username = state is ChirpUserLoadedState
              ? (state.user.username ?? 'Unknown User')
              : 'Unknown User';
          final avatarUrl = state is ChirpUserLoadedState
              ? (state.user.avatarUrl ?? _defaultAvatarUrl)
              : _defaultAvatarUrl;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ChirpUserAvatar(avatarUrl: avatarUrl, numberOfScallops: 6),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'a/${post.community.name}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$username • ${timeSince(post.createdAt)}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinkifiedText(
                text: post.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              LinkifiedText(text: post.content),
            ],
          );
        },
      ),
    );
  }
}
