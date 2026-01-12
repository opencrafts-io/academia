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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ChirpUserCubit, ChirpUserState>(
              builder: (context, state) {
                String avatarUrl =
                    'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                String username = 'Unknown User';

                if (state is ChirpUserLoadedState) {
                  avatarUrl = state.user.avatarUrl ??
                      'https://i.pinimg.com/736x/18/b5/b5/18b5b599bb873285bd4def283c0d3c09.jpg';
                  username = state.user.username ?? 'Unknown User';
                }

                return Row(
                  children: [
                    ChirpUserAvatar(avatarUrl: avatarUrl, numberOfScallops: 6),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'a/${widget.post.community.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$username • ${timeSince(widget.post.createdAt)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
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
            const SizedBox(height: 8),
            Text(
              widget.post.title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.post.content),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double attachmentWidth = constraints.maxWidth;
                  final double attachmentHeight = attachmentWidth / (4 / 5);

                  return SizedBox(
                    height: attachmentHeight,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.post.attachments.length,
                      onPageChanged: (index) =>
                          setState(() => currentPage = index),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AttachmentWidget(
                              attachment: widget.post.attachments[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (widget.post.attachments.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.post.attachments.length, (
                      index,
                    ) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                      );
                    }),
                  ),
                ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(2),
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                  icon: const Icon(Icons.chat),
                  onPressed: widget.onTap,
                  label: Text('${widget.post.commentCount}'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  iconAlignment: IconAlignment.start,
                  onPressed: null,
                  label: Text(widget.post.viewsCount.toString()),
                  icon: const Icon(Icons.visibility),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
