import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'c/${post.communityName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(post.title, style: TextStyle(fontSize: 18)),
              if (post.imageUrl != null) ...[
                SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl!,
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
                  Icon(Icons.arrow_upward),
                  SizedBox(width: 4),
                  Text(post.upvotes.toString()),
                  SizedBox(width: 16),
                  Icon(Icons.comment),
                  SizedBox(width: 4),
                  Text('${post.comments} comments'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
