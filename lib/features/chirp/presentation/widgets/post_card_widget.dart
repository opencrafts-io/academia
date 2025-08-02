import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});
  final Post post;

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
    return GestureDetector(
      onTap: () {},
      child: Container(
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
                  Text(
                    'c/${widget.post.userId}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Text(
                widget.post.content,
                
              ),

              if (widget.post.attachments.isNotEmpty) ...[
                SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.post.attachments.length,
                        onPageChanged: (index) =>
                            setState(() => currentPage = index),
                        itemBuilder: (context, index) => IntrinsicHeight(
                          child: AttachmentWidget(
                            attachment: widget.post.attachments[index],
                          ),
                        ),
                      ),
                  
                      if (widget.post.attachments.length > 1)
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.shadow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.post.attachments.length,
                                (index) {
                                  return AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: currentPage == index ? 6 : 4,
                                    height: currentPage == index ? 6 : 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPage == index
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.outline,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
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
                    onSelectionChanged: (vote) {},
                  ),
                  SizedBox(width: 16),

                  OutlinedButton.icon(
                    icon: Icon(Symbols.chat),
                    onPressed: () {},
                    label: Text('${widget.post.replies.length} comments'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
