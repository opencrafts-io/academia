import 'package:flutter/material.dart';
import '../../../data/services/websocket_service.dart';

class ChatInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String draftText;
  final WebSocketConnectionState connectionState;
  final Function(String) onTextChanged;
  final Function(String) onSendMessage;
  final VoidCallback? onPickImage;
  final VoidCallback? onPickFile;

  const ChatInputWidget({
    super.key,
    required this.controller,
    required this.draftText,
    required this.connectionState,
    required this.onTextChanged,
    required this.onSendMessage,
    this.onPickImage,
    this.onPickFile,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  late FocusNode _focusNode;
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    
    // Initialize controller with draft text if different
    if (widget.controller.text != widget.draftText) {
      widget.controller.text = widget.draftText;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.draftText.length),
      );
    }
    
    widget.controller.addListener(_onTextChanged);
    _updateComposingState();
  }

  @override
  void didUpdateWidget(ChatInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update controller text if draft changed externally
    if (widget.draftText != oldWidget.draftText && 
        widget.controller.text != widget.draftText) {
      widget.controller.text = widget.draftText;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.draftText.length),
      );
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final currentText = widget.controller.text;
    widget.onTextChanged(currentText);
    _updateComposingState();
  }

  void _updateComposingState() {
    final newComposingState = widget.controller.text.trim().isNotEmpty;
    if (newComposingState != _isComposing) {
      setState(() {
        _isComposing = newComposingState;
      });
    }
  }

  void _sendMessage() {
    final message = widget.controller.text.trim();
    if (message.isNotEmpty && _canSendMessage()) {
      widget.onSendMessage(message);
    }
  }

  bool _canSendMessage() {
    return widget.connectionState == WebSocketConnectionState.connected;
  }

  void _showAttachmentOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Add Attachment',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Photo Library'),
            onTap: () {
              Navigator.pop(context);
              widget.onPickImage?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('File'),
            onTap: () {
              Navigator.pop(context);
              widget.onPickFile?.call();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attachment button
              IconButton(
                onPressed: _canSendMessage() ? _showAttachmentOptions : null,
                icon: Icon(
                  Icons.add_circle_outline,
                  color: _canSendMessage()
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                splashRadius: 24,
              ),

              const SizedBox(width: 8),

              // Text input field
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    maxHeight: 120,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    enabled: _canSendMessage(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: _canSendMessage() 
                          ? 'Type a message...' 
                          : 'Connecting...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Send button
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isComposing && _canSendMessage() ? _sendMessage : null,
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _isComposing && _canSendMessage()
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: _isComposing && _canSendMessage()
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        Icons.send,
                        color: _isComposing && _canSendMessage()
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}