import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PostContentWidget extends StatelessWidget {
  final Post post;
  final Function(Comment) onReplyTo;
  final Function(Comment, bool)? onVote;

  const PostContentWidget({
    super.key,
    required this.post,
    required this.onReplyTo,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              actions: [
                IconButton.filled(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Openning Community"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: Icon(Icons.groups, color: Colors.white),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  BlocProvider(
                    create: (context) =>
                        sl<ChirpUserCubit>()..getChirpUserByID(post.authorId),
                    child: PostCard(post: post),
                  ),
                  const SizedBox(height: 16),

                  // Comments header with loading indicator
                  Row(
                    children: [
                      Icon(Icons.comment_outlined, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "${post.commentCount} ${post.commentCount == 1 ? 'Comment' : 'Comments'}",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Comments section
                  if (state is CommentsLoading && post.comments.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: SpinningScallopIndicator(),
                      ),
                    ),

                  if (state is! CommentsLoading && post.comments.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Lottie.asset(
                              "assets/lotties/promotional-staff.json",
                              height: 240,
                            ),
                            Text(
                              "No comments yet",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Be the first to share your thoughts!",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withAlpha(100),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (post.comments.isNotEmpty)
                    CommentsListWidget(
                      comments: post.comments,
                      onReplyTo: onReplyTo,
                      onVote: onVote,
                    ),

                  const SizedBox(height: 120),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
