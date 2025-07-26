import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                    'c/${widget.post.communityName}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                widget.post.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              Text(widget.post.content),

              // TODO: (Jess) Add support for multiple images
              if (widget.post.imageUrl != null) ...[
                SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: CachedNetworkImage(
                    imageUrl: widget.post.imageUrl!,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
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
                        label: Text(widget.post.upvotes.toString()),
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
                    label: Text('${widget.post.comments} comments'),
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
