import 'package:academia/features/chirp/chirp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedUserCard extends StatelessWidget {
  final Block block;
  final VoidCallback onUnblock;

  const BlockedUserCard({
    super.key,
    required this.block,
    required this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChirpUserCubit, ChirpUserState>(
      builder: (context, userState) {
        String? avatarUrl;
        String username = 'Loading...';

        if (userState is ChirpUserLoadedState) {
          avatarUrl = userState.user.avatarUrl;
          username = userState.user.username ?? 'Unknown User';
        } else if (userState is ChirpUserErrorState) {
          username = 'Unknown User';
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: avatarUrl != null
                  ? CachedNetworkImageProvider(avatarUrl)
                  : null,
              child: avatarUrl == null
                  ? Text(
                      username[0].toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  : null,
            ),
            title: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Blocked ${_formatDate(block.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: userState is ChirpUserLoadedState
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
