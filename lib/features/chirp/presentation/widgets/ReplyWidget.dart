// lib/features/chirp/presentation/widgets/reply_widget.dart

import 'package:flutter/material.dart';

class ReplyWidget extends StatefulWidget {
  const ReplyWidget({super.key});

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  final _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.person,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _replyController,
              decoration: InputDecoration(
                hintText: 'Add a reply...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              minLines: 1,
              maxLines: 4,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                // TODO: Handle sending the reply
                // You can access the reply content via _replyController.text
                final replyContent = _replyController.text.trim();
                if (replyContent.isNotEmpty) {
                  // Add your logic to send the reply to the server or update the state
                  // For example, calling a bloc event:
                  // context.read<FeedBloc>().add(ReplyToPost(
                  //   postId: 'your_post_id',
                  //   content: replyContent,
                  // ));

                  // Clear the text field after sending
                  _replyController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}