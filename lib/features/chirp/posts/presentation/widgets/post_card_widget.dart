import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_since/time_since.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

enum Vote { up, down, none }

class _PostCardState extends State<PostCard> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChirpUserCubit>().getChirpUserByID(widget.post.authorId);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        padding: EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ChirpUserCubit, ChirpUserState>(
              builder: (context, state) {
                String avatarUrl =
                    'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                String username = 'Unknown User';

                if (state is ChirpUserLoadedState) {
                  avatarUrl =
                      state.user.avatarUrl ??
                      'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                  username = state.user.username ?? 'Unknown User';
                }

                return Row(
                  spacing: 8,
                  children: [
                    ChirpUserAvatar(avatarUrl: avatarUrl, numberOfScallops: 6),
                    Column(
                      spacing: 2,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'a/${widget.post.community.name}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$username • ${timeSince(widget.post.createdAt)}",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                overflow: TextOverflow.ellipsis,
                                // fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 8),

            Text(widget.post.content),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double attachmentWidth = constraints.maxWidth;
                  final double attachmentHeight = attachmentWidth / (16 / 9);

                  return SizedBox(
                    height: attachmentHeight,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.post.attachments.length,
                      onPageChanged: (index) =>
                          setState(() => currentPage = index),
                      itemBuilder: (context, index) {
                        return AttachmentWidget(
                          attachment: widget.post.attachments[index],
                        );
                      },
                    ),
                  );
                },
              ),

              if (widget.post.attachments.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.post.attachments.length, (
                      index,
                    ) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 6 : 4,
                        height: currentPage == index ? 6 : 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                      );
                    }),
                  ),
                ),
            ],

            SizedBox(height: 8),
            Row(
              children: [
                SegmentedButton<Vote>(
                  selected: {}, // TODO: To be Removed
                  segments: [
                    ButtonSegment(
                      value: Vote.up,
                      icon: Icon(Icons.thumb_up_outlined),
                      label: Text(widget.post.upvotes.toString()),
                    ),
                    ButtonSegment(
                      value: Vote.down,
                      icon: Icon(Icons.thumb_down_outlined),
                    ),
                  ],
                  style: SegmentedButton.styleFrom(padding: EdgeInsets.all(2)),
                  emptySelectionAllowed: true,
                  //TODO: implement like functionality and uncomment the below
                  // selected: widget.post.isLiked ? {Vote.up} : <Vote>{},
                  // selectedIcon: widget.post.isLiked
                  //     ? Icon(Icons.thumb_up)
                  //     : Icon(Icons.thumb_down),
                  onSelectionChanged: (vote) {
                    // final isTogglingOff = vote.isEmpty && widget.post.isLiked;
                    // context.read<FeedBloc>().add(
                    //   ToggleLikePost(
                    //     postId: widget.post.id.toString(),
                    //     isCurrentlyLiked: isTogglingOff
                    //         ? true
                    //         : widget.post.isLiked,
                    //   ),
                    // );
                  },
                ),
                SizedBox(width: 16),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.all(2),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.tertiaryContainer,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onTertiaryContainer,
                  ),
                  icon: Icon(Icons.chat),
                  onPressed: widget.onTap,
                  label: Text('${widget.post.commentCount}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
