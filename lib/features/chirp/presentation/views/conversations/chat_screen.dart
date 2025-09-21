import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/clippers/clippers.dart';
import '../../blocs/conversations/chat_bloc.dart';
import '../../entities/conversations/conversation.dart';
import '../../entities/conversations/message.dart';
import '../../../data/services/websocket_service.dart';
import '../../widgets/conversations/chat_message_widget.dart';
import '../../widgets/conversations/typing_indicator_widget.dart';
import '../../widgets/conversations/enhanced_chat_input_widget.dart';
import '../../../../profile/data/datasources/profile_local_datasource.dart';
import '../../usecases/conversations/enhanced_messaging_usecases.dart';
import '../../../../../injection_container.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final Conversation? conversation;

  const ChatScreen({
    super.key,
    required this.conversationId,
    this.conversation,
  });

  // Debug log in constructor
  static void _logConversationDebug(String conversationId, Conversation? conversation) {
    debugPrint('🎯 ChatScreen: Constructor called for conversation $conversationId');
    debugPrint('🎯 ChatScreen: Conversation object: ${conversation != null ? 'present with ${conversation.participants.length} participants' : 'null'}');
    if (conversation != null) {
      debugPrint('🎯 ChatScreen: Participants: ${conversation.participants.map((p) => '${p.name} (${p.userId})').join(', ')}');
    }
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  String? _currentUserId;
  String _appBarTitle = 'Chat';
  String? _otherUserName;
  Conversation? _loadedConversation;
  bool _isLoadingConversation = false;

  @override
  void initState() {
    super.initState();
    ChatScreen._logConversationDebug(widget.conversationId, widget.conversation);
    _initializeChat();
    _setupScrollListener();
  }

  void _initializeChat() {
    // Initialize chat with enhanced user fetching
    context.read<ChatBloc>().add(ChatInitialized(widget.conversationId));
    
    // Get current user ID from profile
    _initializeCurrentUser();
    
    // If conversation is null, try to fetch it as fallback
    if (widget.conversation == null) {
      debugPrint('⚠️ ChatScreen: No conversation passed, starting fallback fetch');
      setState(() {
        _isLoadingConversation = true;
      });
      _fetchConversationFallback();
    } else {
      debugPrint('✅ ChatScreen: Conversation passed successfully with ${widget.conversation!.participants.length} participants');
      _loadedConversation = widget.conversation;
    }
    
    // Trigger user data refresh for better display
    _ensureUserDataIsAvailable();
  }
  
  Future<void> _initializeCurrentUser() async {
    try {
      final profileLocalDatasource = sl.get<ProfileLocalDatasource>();
      final result = await profileLocalDatasource.getCachedUserProfile();
      
      result.fold(
        (failure) {
          debugPrint('❌ Failed to get current user: ${failure.message}');
          // Fallback to placeholder - should be handled properly in production
          _currentUserId = 'current_user';
          debugPrint('🔄 Using fallback current user ID: $_currentUserId');
        },
        (profile) {
          debugPrint('✅ Successfully got current user: ${profile.id} (${profile.name})');
          setState(() {
            _currentUserId = profile.id;
          });
          debugPrint('🔄 Set current user ID: $_currentUserId');
          _updateAppBarTitle();
        },
      );
    } catch (e) {
      debugPrint('Error getting current user: $e');
      _currentUserId = 'current_user'; // Fallback
    }
  }
  
  void _updateAppBarTitle() {
    // Set app bar title from conversation if available (either passed or loaded)
    final conversation = widget.conversation ?? _loadedConversation;
    if (conversation != null && _currentUserId != null) {
      debugPrint('🏷️ ChatScreen: Updating app bar title using conversation with ${conversation.participants.length} participants');
      
      final otherParticipant = conversation.participants
          .where((p) => p.userId != _currentUserId)
          .firstOrNull;
      
      if (otherParticipant != null) {
        debugPrint('🏷️ ChatScreen: Found other participant: ${otherParticipant.name} (${otherParticipant.userId})');
        setState(() {
          _appBarTitle = otherParticipant.name.isNotEmpty ? otherParticipant.name : otherParticipant.userId;
          _otherUserName = otherParticipant.name;
        });
        debugPrint('🏷️ ChatScreen: Updated app bar title to: $_appBarTitle');
      } else {
        debugPrint('⚠️ ChatScreen: No other participant found in conversation');
      }
    } else {
      debugPrint('⚠️ ChatScreen: Cannot update app bar title - conversation: ${conversation != null}, currentUserId: $_currentUserId');
    }
  }
  
  /// Fetch conversation as fallback if not passed through navigation
  Future<void> _fetchConversationFallback() async {
    debugPrint('🔍 ChatScreen: Fetching conversation fallback for ${widget.conversationId}');
    try {
      final getConversationsUseCase = sl<GetConversationsUseCase>();
      final result = await getConversationsUseCase(GetConversationsParams());
      
      result.fold(
        (failure) {
          debugPrint('❌ ChatScreen: Failed to fetch conversations: ${failure.message}');
          setState(() {
            _isLoadingConversation = false;
          });
        },
        (conversations) {
          debugPrint('🔍 ChatScreen: Found ${conversations.length} conversations');
          final foundConversation = conversations
              .where((conv) => conv.id == widget.conversationId)
              .firstOrNull;
          
          if (foundConversation != null) {
            debugPrint('✅ ChatScreen: Found conversation ${widget.conversationId} with ${foundConversation.participants.length} participants');
            debugPrint('🔍 ChatScreen: Participants: ${foundConversation.participants.map((p) => '${p.name} (${p.userId})').join(', ')}');
            setState(() {
              _loadedConversation = foundConversation;
              _isLoadingConversation = false;
            });
            _updateAppBarTitle();
          } else {
            debugPrint('❌ ChatScreen: Conversation ${widget.conversationId} not found in fetched conversations');
            debugPrint('🔍 ChatScreen: Available conversations: ${conversations.map((c) => c.id).join(', ')}');
            setState(() {
              _isLoadingConversation = false;
            });
          }
        },
      );
    } catch (e) {
      debugPrint('❌ ChatScreen: Error fetching conversation: $e');
      setState(() {
        _isLoadingConversation = false;
      });
    }
  }
  
  /// Ensures other user data is available for proper display
  void _ensureUserDataIsAvailable() {
    // The enhanced message enrichment system will handle user data fetching
    // This will be called automatically when messages are loaded
    // The API fallback in EnhancedConversationRepositoryImpl will ensure
    // user data is fetched and cached if not available
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // Load more messages when reaching the top
      if (_scrollController.position.pixels >= 
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ChatBloc>().add(const ChatLoadMoreMessages());
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            String displayName = 'Loading...';
            String? avatarUrl;
            String? otherUserId;
            
            final currentConversation = widget.conversation ?? _loadedConversation;
            debugPrint('💬 Building chat header - Current user ID: $_currentUserId');
            debugPrint('💬 Conversation participants: ${currentConversation?.participants.map((p) => '${p.name} (${p.userId})').join(', ') ?? 'No conversation'}');
            debugPrint('💬 Chat state: ${state.runtimeType}');
            
            // Try to get other user info from various sources
            if (currentConversation != null && _currentUserId != null) {
              // Use the conversation's getOtherParticipant method if available
              try {
                final otherParticipant = currentConversation.getOtherParticipant(_currentUserId);
                if (otherParticipant != null) {
                  displayName = otherParticipant.name.isNotEmpty ? otherParticipant.name : otherParticipant.userId;
                  avatarUrl = otherParticipant.avatar;
                  otherUserId = otherParticipant.userId;
                  debugPrint('🎯 Found other participant via getOtherParticipant: $displayName (${otherParticipant.userId})');
                } else {
                  debugPrint('⚠️ getOtherParticipant returned null');
                }
              } catch (e) {
                debugPrint('⚠️ getOtherParticipant method not available, using manual filtering: $e');
                // Fallback to manual filtering if getOtherParticipant doesn't exist
                final otherParticipant = currentConversation.participants
                    .where((p) => p.userId != _currentUserId)
                    .firstOrNull;
                
                if (otherParticipant != null) {
                  displayName = otherParticipant.name.isNotEmpty ? otherParticipant.name : otherParticipant.userId;
                  avatarUrl = otherParticipant.avatar;
                  otherUserId = otherParticipant.userId;
                  debugPrint('🎯 Found other participant via manual filtering: $displayName (${otherParticipant.userId})');
                } else {
                  debugPrint('❌ No other participant found in conversation');
                }
              }
            }
            
            if (state is ChatLoaded && state.messages.isNotEmpty && _currentUserId != null) {
              debugPrint('💬 Trying to extract user info from ${state.messages.length} messages');
              // Try to get from messages if conversation data is not sufficient
              // Only use messages from OTHER users, not the current user
              final otherMessages = state.messages
                  .where((msg) => msg.sender.userId != _currentUserId && msg.sender.userId.isNotEmpty)
                  .toList();
              
              debugPrint('💬 Found ${otherMessages.length} messages from other users');
              
              if (otherMessages.isNotEmpty) {
                final otherMessage = otherMessages.first;
                debugPrint('💬 Message sender: ${otherMessage.sender.name} (${otherMessage.sender.userId})');
                
                // Use message sender info if it's more complete than what we already have
                if (displayName == 'Loading...' || displayName == 'Chat' || displayName.isEmpty) {
                  displayName = otherMessage.sender.name.isNotEmpty ? otherMessage.sender.name : otherMessage.sender.userId;
                  avatarUrl = otherMessage.sender.avatar ?? avatarUrl;
                  otherUserId = otherMessage.sender.userId;
                  debugPrint('🎯 Using message sender for display: $displayName');
                } else if (otherMessage.sender.name.isNotEmpty && (displayName == otherMessage.sender.userId || displayName == 'User')) {
                  // Update if we have a better name (actual name vs user ID)
                  displayName = otherMessage.sender.name;
                  avatarUrl = otherMessage.sender.avatar ?? avatarUrl;
                  debugPrint('🎯 Updated display name from message: $displayName');
                }
              } else {
                debugPrint('⚠️ No messages from other users found');
              }
            }
            
            // Fallback to conversation ID if we still don't have user info
            if (displayName == 'Loading...' && widget.conversationId.isNotEmpty) {
              displayName = 'Chat';
            }
            
            debugPrint('💬 Final display name for chat header: $displayName');
            
            return Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl)
                      : null,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2),
                  child: avatarUrl == null
                      ? Text(
                          displayName.isNotEmpty
                              ? displayName.split(' ').map((n) => n.isNotEmpty ? n[0] : '').join('').toUpperCase()
                              : 'U',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
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
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (state is ChatLoaded)
                        _ConnectionStatusText(
                          connectionState: state.connectionState,
                          typingUsers: state.typingUsers,
                          otherUserName: displayName,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              _showMessageOptions();
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }

          if (state is ChatLoaded && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(
                      child: SpinningScallopIndicator(),
                    );
                  }

                  if (state is ChatError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Failed to load messages',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<ChatBloc>().add(
                                const ChatMessagesLoaded(),
                              );
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ChatLoaded) {
                    if (state.messages.isEmpty) {
                      return _EmptyMessagesWidget(
                        otherUserName: _otherUserName ?? 'User',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ChatBloc>().add(const ChatMessagesLoaded());
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.messages.length + 
                                  (state.isLoadingMore ? 1 : 0) +
                                  (state.typingUsers.isNotEmpty ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Show typing indicator at bottom
                          if (index == 0 && state.typingUsers.isNotEmpty) {
                            return TypingIndicatorWidget(
                              typingUsers: state.typingUsers,
                              otherUserName: _otherUserName,
                            );
                          }

                          // Adjust index for typing indicator
                          final adjustedIndex = state.typingUsers.isNotEmpty 
                              ? index - 1 
                              : index;

                          // Show loading indicator at top
                          if (state.isLoadingMore && adjustedIndex == state.messages.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            );
                          }

                          // Show message
                          final messageIndex = state.messages.length - 1 - adjustedIndex;
                          final message = state.messages[messageIndex];
                          
                          // Determine if this is the user's own message
                          final isOwnMessage = message.sender.userId == _currentUserId;

                          // Group messages by sender for better UI
                          final isFirstInGroup = _isFirstMessageInGroup(
                            state.messages, messageIndex
                          );
                          final isLastInGroup = _isLastMessageInGroup(
                            state.messages, messageIndex
                          );

                          return ChatMessageWidget(
                            message: message,
                            isOwnMessage: isOwnMessage,
                            isFirstInGroup: isFirstInGroup,
                            isLastInGroup: isLastInGroup,
                            onTap: () => _showMessageActions(message),
                          );
                        },
                      ),
                    );
                  }

                  return const Center(
                    child: Text('Start your conversation'),
                  );
                },
              ),
            ),

            // Input area
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return ChatInputWidget(
                    controller: _messageController,
                    draftText: state.draftText,
                    connectionState: state.connectionState,
                    onTextChanged: (text) {
                      context.read<ChatBloc>().add(ChatDraftChanged(text));
                    },
                    onSendMessage: (content) {
                      _sendMessage(content);
                    },
                    onPickImage: _pickImage,
                    onPickFile: _pickFile,
                  );
                }
                return const SizedBox(height: 80);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isFirstMessageInGroup(List<Message> messages, int index) {
    if (index == 0) return true;
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    return currentMessage.sender.userId != previousMessage.sender.userId;
  }

  bool _isLastMessageInGroup(List<Message> messages, int index) {
    if (index == messages.length - 1) return true;
    final currentMessage = messages[index];
    final nextMessage = messages[index + 1];
    return currentMessage.sender.userId != nextMessage.sender.userId;
  }

  void _sendMessage(String content) {
    if (content.trim().isEmpty) return;

    context.read<ChatBloc>().add(
      ChatMessageSent(content: content.trim()),
    );

    _messageController.clear();
    _scrollToBottom();
  }

  void _sendMessageWithFile(String content, File file) {
    context.read<ChatBloc>().add(
      ChatMessageSent(content: content, file: file),
    );

    _messageController.clear();
    _scrollToBottom();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final file = File(image.path);
        _sendMessageWithFile(_messageController.text.trim(), file);
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _pickFile() async {
    // File picker functionality would go here
    _showError('File picker not implemented yet');
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showMessageActions(Message message) {
    final isOwnMessage = message.sender.userId == _currentUserId;
    
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: message.content));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Message copied'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          if (isOwnMessage) ...[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showEditMessageDialog(message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(message);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showEditMessageDialog(Message message) {
    final controller = TextEditingController(text: message.content);
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Message'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Enter your message...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newContent = controller.text.trim();
              if (newContent.isNotEmpty && newContent != message.content) {
                context.read<ChatBloc>().add(
                  ChatMessageEdited(
                    messageId: message.id,
                    newContent: newContent,
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Message message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ChatBloc>().add(
                ChatMessageDeleted(message.id),
              );
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showMessageOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Refresh Messages'),
            onTap: () {
              Navigator.pop(context);
              context.read<ChatBloc>().add(const ChatMessagesLoaded());
            },
          ),
          ListTile(
            leading: const Icon(Icons.mark_email_read),
            title: const Text('Mark All as Read'),
            onTap: () {
              Navigator.pop(context);
              final state = context.read<ChatBloc>().state;
              if (state is ChatLoaded) {
                final unreadMessageIds = state.messages
                    .where((msg) => msg.sender.userId != _currentUserId && !msg.isRead)
                    .map((msg) => msg.id)
                    .toList();
                if (unreadMessageIds.isNotEmpty) {
                  context.read<ChatBloc>().add(
                    ChatMessagesMarkedAsRead(unreadMessageIds),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}

class _ConnectionStatusText extends StatelessWidget {
  final WebSocketConnectionState connectionState;
  final List<String> typingUsers;
  final String? otherUserName;

  const _ConnectionStatusText({
    required this.connectionState,
    required this.typingUsers,
    this.otherUserName,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color? color;

    if (typingUsers.isNotEmpty) {
      text = '${otherUserName ?? 'User'} is typing...';
      color = Theme.of(context).colorScheme.primary;
    } else {
      switch (connectionState) {
        case WebSocketConnectionState.connected:
          text = 'Online';
          color = Colors.green;
          break;
        case WebSocketConnectionState.connecting:
          text = 'Connecting...';
          color = Colors.orange;
          break;
        case WebSocketConnectionState.reconnecting:
          text = 'Reconnecting...';
          color = Colors.orange;
          break;
        case WebSocketConnectionState.disconnected:
          text = 'Offline';
          color = Colors.red;
          break;
        case WebSocketConnectionState.error:
          text = 'Connection Error';
          color = Colors.red;
          break;
      }
    }

    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _EmptyMessagesWidget extends StatelessWidget {
  final String otherUserName;

  const _EmptyMessagesWidget({required this.otherUserName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              size: 96,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              'Start the conversation',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Send a message to $otherUserName to get the conversation started',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}