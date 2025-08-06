import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../bloc/conversations/messaging_event.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../widgets/conversations/chat_message_list_widget.dart';
import '../../widgets/conversations/profile_preview_modal.dart';
import '../../widgets/error_handling_widget.dart';

class ChatPage extends StatefulWidget {
  final String conversationId;

  const ChatPage({super.key, required this.conversationId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _imageCaptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  final FocusNode _imageCaptionFocusNode = FocusNode();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    context.read<MessagingBloc>().add(LoadMessagesEvent(widget.conversationId));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _imageCaptionController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    _imageCaptionFocusNode.dispose();
    super.dispose();
  }

  // TODO: Implement scroll to bottom when needed
  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //   }
  // }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<MessagingBloc>().add(
        SendMessageEvent(widget.conversationId, _messageController.text.trim()),
      );
      _messageController.clear();
    }
  }

  void _showProfilePreview(BuildContext context, ChirpUser user) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProfilePreviewModal(
        user: user,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          setState(() {
            _selectedImagePath = file.path!;
            _imageCaptionController.clear();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _sendImageMessage() {
    if (_selectedImagePath != null) {
      context.read<MessagingBloc>().add(
        SendMessageEvent(
          widget.conversationId,
          _imageCaptionController.text.trim(),
          file: File(_selectedImagePath!),
        ),
      );
      setState(() {
        _selectedImagePath = null;
        _imageCaptionController.clear();
      });
    }
  }

  void _cancelImageSelection() {
    setState(() {
      _selectedImagePath = null;
      _imageCaptionController.clear();
    });
  }

  Widget _buildImagePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: _cancelImageSelection,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Expanded(
              child: Text(
                'Image Preview',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              _selectedImagePath != null &&
                  File(_selectedImagePath!).existsSync()
              ? Image.file(
                  File(_selectedImagePath!),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Failed to load image',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image file not found',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _imageCaptionController,
                focusNode: _imageCaptionFocusNode,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Add a caption (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _sendImageMessage(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _sendImageMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        IconButton(
          onPressed: _pickImage,
          icon: Icon(
            Icons.attach_file,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _messageController,
            focusNode: _messageFocusNode,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.text,
            maxLines: null,
            minLines: 1,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onSubmitted: (_) => _sendMessage(),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _messageController.text.trim().isNotEmpty
              ? _sendMessage
              : null,
          icon: Icon(
            Icons.send,
            color: _messageController.text.trim().isNotEmpty
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Mark messages as read when leaving
            context.read<MessagingBloc>().add(
              MarkConversationAsReadEvent(widget.conversationId),
            );
            context.pop();
          },
        ),
        title: BlocBuilder<MessagingBloc, MessagingState>(
          builder: (context, state) {
            if (state is MessagesLoaded) {
              final conversation = state.conversation;
              return GestureDetector(
                onTap: () => _showProfilePreview(context, conversation.user),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: conversation.user.avatarUrl != null
                          ? NetworkImage(conversation.user.avatarUrl!)
                          : null,
                      child: conversation.user.avatarUrl == null
                          ? Text(
                              conversation.user.name
                                  .split(' ')
                                  .map((n) => n[0])
                                  .join(''),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            conversation.user.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${conversation.user.vibepoints} vibepoints',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('Chat');
          },
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagingBloc, MessagingState>(
              builder: (context, state) {
                if (state is MessagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MessagesErrorState) {
                  return LoadingErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<MessagingBloc>().add(
                        LoadMessagesEvent(widget.conversationId),
                      );
                    },
                    retryText: state.retryAction,
                  );
                }

                if (state is MessageSendingState) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Sending message...'),
                      ],
                    ),
                  );
                }

                if (state is MessageSendErrorState) {
                  return Center(
                    child: ErrorHandlingWidget(
                      message: state.message,
                      retryAction: state.retryAction,
                      onRetry: () {
                        // Retry sending the last message
                        if (_messageController.text.trim().isNotEmpty) {
                          context.read<MessagingBloc>().add(
                            SendMessageEvent(
                              widget.conversationId,
                              _messageController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }

                if (state is MessagesLoaded) {
                  final messages = state.messages;

                  return ChatMessageListWidget(
                    messages: messages,
                    scrollController: _scrollController,
                    currentUserId:
                        'current_user', // TODO: Get from auth service
                  );
                }

                return const Center(child: Text('No messages to display'));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: _selectedImagePath != null
                ? _buildImagePreview()
                : _buildMessageInput(),
          ),
        ],
      ),
    );
  }
}
