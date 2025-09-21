import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../bloc/conversations/messaging_event.dart';
import '../../bloc/conversations/messaging_state.dart';
import '../../widgets/conversations/chat_message_list_widget.dart';
import '../../widgets/conversations/profile_preview_modal.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';
import '../../../../profile/data/datasources/profile_local_datasource.dart';
import '../../../../../injection_container.dart';

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
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
    context.read<MessagingBloc>().add(LoadMessagesEvent(widget.conversationId));
  }

  Future<void> _initializeCurrentUser() async {
    try {
      final profileLocalDatasource = sl.get<ProfileLocalDatasource>();
      final result = await profileLocalDatasource.getCachedUserProfile();
      
      result.fold(
        (failure) {
          debugPrint('Failed to get current user: ${failure.message}');
          // Fallback to placeholder - should be handled properly in production
          _currentUserId = 'current_user';
        },
        (profile) {
          setState(() {
            _currentUserId = profile.id;
          });
        },
      );
    } catch (e) {
      debugPrint('Error getting current user: $e');
      _currentUserId = 'current_user'; // Fallback
    }
  }

  String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${lastSeen.day}/${lastSeen.month}/${lastSeen.year}';
    }
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
      debugPrint('Sending message: ${_messageController.text.trim()}');
      context.read<MessagingBloc>().add(
        SendMessageEvent(widget.conversationId, _messageController.text.trim()),
      );
      _messageController.clear();
      setState(() {}); // Trigger rebuild after clearing
    } else {
      debugPrint('Cannot send empty message');
    }
  }

  void _showProfilePreview(BuildContext context, ConversationParticipant participant) {
    // Convert ConversationParticipant to ChirpUser for the modal
    // This is a temporary solution - ideally ProfilePreviewModal should accept ConversationParticipant
    final chirpUser = ChirpUser(
      id: participant.userId,
      name: participant.name,
      email: participant.email,
      avatarUrl: participant.avatar,
      vibepoints: 0, // ConversationParticipant doesn't have vibepoints field
    );
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProfilePreviewModal(
        user: chirpUser,
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
      final imagePath = _selectedImagePath!;
      final caption = _imageCaptionController.text.trim();

      debugPrint('=== FILE UPLOAD DEBUG ===');
      debugPrint('Image path: $imagePath');
      debugPrint('Caption: "$caption"');
      debugPrint('File exists: ${File(imagePath).existsSync()}');
      debugPrint('File size: ${File(imagePath).lengthSync()} bytes');
      debugPrint('File extension: ${imagePath.split('.').last}');
      debugPrint('========================');

      context.read<MessagingBloc>().add(
        SendMessageEvent(widget.conversationId, caption, file: File(imagePath)),
      );

      // Clear the UI immediately
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
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: _pickImage,
              icon: Icon(
                Icons.attach_file,
                color: theme.colorScheme.onSecondaryContainer,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                maxLines: 4,
                minLines: 1,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<MessagingBloc, MessagingState>(
            builder: (context, state) {
              final isSending = state is MessageSendingState;
              final hasText = _messageController.text.trim().isNotEmpty;

              return Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: hasText || isSending 
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: hasText && !isSending ? _sendMessage : null,
                  icon: isSending
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.send,
                          color: hasText 
                              ? theme.colorScheme.onPrimary 
                              : theme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
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
            String userName = 'Loading...';
            String? userAvatar;
            bool isOnline = false;
            DateTime? lastSeen;
            
            if (state is MessagesLoaded) {
              final conversation = state.conversation;
              final otherParticipant = conversation.getOtherParticipant(_currentUserId);
              
              if (otherParticipant != null) {
                userName = otherParticipant.name.isNotEmpty ? otherParticipant.name : 'Unknown User';
                userAvatar = otherParticipant.avatar;
                isOnline = otherParticipant.isOnline;
                lastSeen = otherParticipant.lastSeen;
              }
            } else if (state is MessagesLoadingState) {
              userName = 'Loading...';
            } else {
              // For any other state, try to get user info from previous state or use fallback
              userName = 'Chat';
            }
              
            return GestureDetector(
              onTap: state is MessagesLoaded 
                  ? () {
                      final conversation = state.conversation;
                      final otherParticipant = conversation.getOtherParticipant(_currentUserId);
                      if (otherParticipant != null) {
                        _showProfilePreview(context, otherParticipant);
                      }
                    }
                  : null,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: userAvatar != null
                        ? NetworkImage(userAvatar)
                        : null,
                    backgroundColor: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                    child: userAvatar == null
                        ? Text(
                            userName.isNotEmpty
                                ? userName
                                    .split(' ')
                                    .map((n) => n.isNotEmpty ? n[0] : '')
                                    .join('')
                                    .toUpperCase()
                                : 'U',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isOnline)
                          Text(
                            'Online',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          )
                        else if (lastSeen != null)
                          Text(
                            'Last seen ${_formatLastSeen(lastSeen)}',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        elevation: 2,
      ),
      body: BlocListener<MessagingBloc, MessagingState>(
        listener: (context, state) {
          if (state is MessageSendErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Theme.of(context).colorScheme.onError,
                  onPressed: () {
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
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is MessagesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Theme.of(context).colorScheme.onError,
                  onPressed: () {
                    context.read<MessagingBloc>().add(
                      LoadMessagesEvent(widget.conversationId),
                    );
                  },
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessagingBloc, MessagingState>(
                builder: (context, state) {
                  if (state is MessagesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MessagesLoaded) {
                    final messages = state.messages;

                    return ChatMessageListWidget(
                      messages: messages,
                      scrollController: _scrollController,
                      currentUserId: _currentUserId ?? 'current_user',
                    );
                  }

                  // Show empty state for other states (errors are handled via snackbars)
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages to display',
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _selectedImagePath != null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    child: _buildImagePreview(),
                  )
                : _buildMessageInput(),
          ],
        ),
      ),
    );
  }
}
