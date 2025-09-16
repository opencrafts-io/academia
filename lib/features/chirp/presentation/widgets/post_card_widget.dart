import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post, this.onTap});
  final Post post;
  final VoidCallback? onTap;

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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                CircleAvatar(radius: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'c/${widget.post.group.name}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      'u/${widget.post.userName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

    
            SizedBox(height: 8),
    
            Text(widget.post.content),
            if (widget.post.attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
               LayoutBuilder(
                builder: (context, constraints) {
                  final double attachmentWidth = constraints.maxWidth;
                  final double attachmentHeight =
                      attachmentWidth /
                      (16 / 9);
    
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
                  segments: [
                    ButtonSegment(
                      value: Vote.up,
                      icon: Icon(Symbols.arrow_upward),
                      label: Text(widget.post.likeCount.toString()),
                    ),
                    ButtonSegment(
                      value: Vote.down,
                      icon: Icon(Symbols.arrow_upward),
                    ),
                  ],
                  selected: const <Vote>{Vote.up},
                  showSelectedIcon: true,
                  onSelectionChanged: (vote) {
                    context.read<FeedBloc>().add(
                      ToggleLikePost(
                        postId: widget.post.id,
                        isCurrentlyLiked: widget.post.isLiked,
                      ),
                    );
                  },
                ),
                SizedBox(width: 16),
    
                OutlinedButton.icon(
                  icon: Icon(Symbols.chat),
                  onPressed:  widget.onTap,
                  label: Text('${widget.post.commentCount} comments'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
