import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';

/// The comment/reply composer docked at the bottom of the post detail
/// screen.
///
/// Deliberately placed as the last child of the screen's body [Column]
/// rather than [Scaffold.bottomNavigationBar]: bottomNavigationBar sits in
/// its own slot outside the part of the tree Scaffold resizes for the
/// keyboard in every case we could reproduce, so it could end up sitting
/// behind the keyboard instead of docked above it. As the last item of a
/// body-level Column, it always occupies real, already keyboard-adjusted
/// space, so it can't be overlaid.
///
/// The text field grows with its content (up to [_maxLines], then scrolls
/// internally) and animates that growth via [AnimatedSize] instead of
/// snapping, and the send button morphs between disabled/enabled/sending
/// states.
class CommentComposer extends StatelessWidget {
  const CommentComposer({
    super.key,
    required this.controller,
    required this.replyingTo,
    required this.isSending,
    required this.onSend,
    required this.onCancelReply,
  });

  static const _maxLines = 6;

  final TextEditingController controller;
  final Comment? replyingTo;
  final bool isSending;
  final VoidCallback onSend;
  final VoidCallback onCancelReply;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final replying = replyingTo;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              alignment: Alignment.bottomCenter,
              child: replying == null
                  ? const SizedBox(width: double.infinity)
                  : ReplyPreviewBanner(
                      replyingTo: replying,
                      onCancel: onCancelReply,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 120),
                      curve: Curves.easeOut,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: _maxLines,
                        enabled: !isSending,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: replying != null
                              ? "Write your reply..."
                              : "Add a comment...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: colorScheme.surfaceContainerHigh,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      final canSend =
                          !isSending && value.text.trim().isNotEmpty;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        child: IconButton.filled(
                          key: ValueKey('send-$canSend-$isSending'),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                          ),
                          onPressed: canSend ? onSend : null,
                          icon: isSending
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colorScheme.onPrimary,
                                  ),
                                )
                              : const Icon(Icons.arrow_upward_rounded),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
