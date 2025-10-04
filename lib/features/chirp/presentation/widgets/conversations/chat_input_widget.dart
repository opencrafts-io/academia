import 'package:flutter/material.dart';
import 'package:academia/features/chirp/data/services/file_picker_service.dart';
import 'package:academia/features/chirp/posts/domain/entities/attachments.dart';
import 'package:academia/features/chirp/posts/presentation/widgets/attachment_widget.dart';

class ChatInputWidget extends StatefulWidget {
  final Function(String message, List<Attachments> attachments) onSendMessage;
  final bool isLoading;

  const ChatInputWidget({
    super.key,
    required this.onSendMessage,
    this.isLoading = false,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  final TextEditingController _messageController = TextEditingController();
  final List<Attachments> _selectedAttachments = [];
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isComposing =
          _messageController.text.isNotEmpty || _selectedAttachments.isNotEmpty;
    });
  }

  Future<void> _pickFiles() async {
    final attachments = await FilePickerService.pickFiles();
    if (attachments.isNotEmpty) {
      setState(() {
        _selectedAttachments.addAll(attachments);
        _isComposing =
            _messageController.text.isNotEmpty ||
            _selectedAttachments.isNotEmpty;
      });
    }
  }

  Future<void> _pickImages() async {
    final attachments = await FilePickerService.pickImages();
    if (attachments.isNotEmpty) {
      setState(() {
        _selectedAttachments.addAll(attachments);
        _isComposing =
            _messageController.text.isNotEmpty ||
            _selectedAttachments.isNotEmpty;
      });
    }
  }

  Future<void> _pickVideos() async {
    final attachments = await FilePickerService.pickVideos();
    if (attachments.isNotEmpty) {
      setState(() {
        _selectedAttachments.addAll(attachments);
        _isComposing =
            _messageController.text.isNotEmpty ||
            _selectedAttachments.isNotEmpty;
      });
    }
  }

  Future<void> _pickDocuments() async {
    final attachments = await FilePickerService.pickDocuments();
    if (attachments.isNotEmpty) {
      setState(() {
        _selectedAttachments.addAll(attachments);
        _isComposing =
            _messageController.text.isNotEmpty ||
            _selectedAttachments.isNotEmpty;
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _selectedAttachments.removeAt(index);
      _isComposing =
          _messageController.text.isNotEmpty || _selectedAttachments.isNotEmpty;
    });
  }

  void _sendMessage() {
    if (_isComposing && !widget.isLoading) {
      final message = _messageController.text.trim();
      final attachments = List<Attachments>.from(_selectedAttachments);

      widget.onSendMessage(message, attachments);

      _messageController.clear();
      setState(() {
        _selectedAttachments.clear();
        _isComposing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Attachment previews
        if (_selectedAttachments.isNotEmpty)
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedAttachments.length,
              itemBuilder: (context, index) {
                final attachment = _selectedAttachments[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AttachmentWidget(attachment: attachment),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeAttachment(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        // Input area
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Attachment button
                GestureDetector(
                  onTap: _pickFiles,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.attach_file, size: 20),
                  ),
                ),

                const SizedBox(width: 8),

                // Text input
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),

                const SizedBox(width: 8),

                // Send button
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isComposing && !widget.isLoading
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: widget.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.send,
                            color: _isComposing && !widget.isLoading
                                ? Colors.white
                                : Colors.grey[600],
                            size: 20,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
