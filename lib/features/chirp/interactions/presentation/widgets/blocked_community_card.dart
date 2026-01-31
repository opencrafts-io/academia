import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedCommunityCard extends StatelessWidget {
  final Block block;
  final VoidCallback onUnblock;

  const BlockedCommunityCard({
    super.key,
    required this.block,
    required this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityHomeBloc, CommunityHomeState>(
      builder: (context, communityState) {
        String? communityImage;
        String communityName = 'Loading...';

        if (communityState is CommunityHomeLoaded) {
          communityImage = communityState.community.profilePictureUrl;
          communityName = communityState.community.name;
        } else if (communityState is CommunityHomeFailure) {
          communityName = 'Unknown Community';
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: communityImage != null
                  ? CachedNetworkImageProvider(communityImage)
                  : null,
              child: communityImage == null
                  ? Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    )
                  : null,
            ),
            title: Text(
              communityName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Blocked ${_formatDate(block.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: communityState is CommunityHomeLoaded
                ? OutlinedButton(
                    onPressed: onUnblock,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: const Text('Unblock'),
                  )
                : const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
