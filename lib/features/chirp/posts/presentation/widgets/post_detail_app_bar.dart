import 'package:academia/config/config.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// The post detail screen's collapsing top bar: back (returning the
/// possibly-updated post so the feed can sync it), share, and jump-to-
/// community. Tonal filled icon buttons give the actions the same bold
/// shape/color language as the composer's send button instead of the
/// feed's plain icon buttons - this screen is a step deeper, so its
/// primary actions read as a little more emphasized.
class PostDetailAppBar extends StatelessWidget {
  const PostDetailAppBar({super.key, required this.post});

  final Post post;

  Future<XFile?> _downloadAttachment(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last.split('?').first;
      final filePath = '${tempDir.path}/$fileName';
      await Dio().download(
        url,
        filePath,
        options: Options(responseType: ResponseType.bytes),
      );
      return XFile(filePath);
    } catch (_) {
      return null;
    }
  }

  Future<void> _share(BuildContext context) async {
    final url =
        'https://academia.opencrafts.io${PostDetailRoute(postId: post.id).location}';
    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;
    final text =
        '${post.title}\n\n'
        'Join the discussion on Academia\n'
        '$url';

    final imageAttachment = post.attachments
        .where((a) => a.attachmentType.toLowerCase() == 'image')
        .firstOrNull;

    if (imageAttachment != null) {
      final xfile = await _downloadAttachment(imageAttachment.file);
      if (xfile != null) {
        await Share.shareXFiles(
          [xfile],
          text: text,
          sharePositionOrigin: sharePositionOrigin,
        );
        return;
      }
    }

    Share.share(text, sharePositionOrigin: sharePositionOrigin);
  }

  void _handleBack(BuildContext context) {
    final updatedPost = context.read<PostCubit>().state;
    if (context.canPop()) {
      Navigator.pop(context, updatedPost);
    } else {
      context.go(HomeRoute().location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton.filledTonal(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => _handleBack(context),
      ),
      actions: [
        // `context` here must resolve to a RenderBox for
        // `sharePositionOrigin` (the iOS share sheet's popover anchor).
        // SliverAppBar.actions sits inside the sliver's own subtree, so
        // PostDetailAppBar's own build context - whose nearest descendant
        // render object is the sliver header itself - won't do; wrap in a
        // Builder to get the icon button's own (box-based) context instead.
        Builder(
          builder: (context) => IconButton.filledTonal(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share post',
            onPressed: () => _share(context),
          ),
        ),
        const SizedBox(width: 4),
        IconButton.filledTonal(
          icon: const Icon(Icons.groups_rounded),
          tooltip: 'Open community',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Opening Community"),
                behavior: SnackBarBehavior.floating,
              ),
            );
            CommunitiesRoute(communityId: post.community.id).push(context);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
