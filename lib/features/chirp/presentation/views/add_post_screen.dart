import 'package:academia/features/chirp/presentation/bloc/feed/feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _contentController = TextEditingController();
  final List<PlatformFile> _attachments = [];

  Future<void> _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        _attachments.addAll(result.files);
      });
    }
  }

  void _submitPost() {
    final content = _contentController.text.trim();

    if (content.isEmpty && _attachments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post must have content or an attachment."),
        ),
      );
      return;
    }

    context.read<FeedBloc>().add(
      CreatePostEvent(content: content, files: _attachments),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post")),
      body: BlocConsumer<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is PostCreated) {
            _contentController.clear();
            setState(() {
              _attachments.clear();
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Post created successfully!")),
            );
            Navigator.pop(context);
          } else if (state is PostCreateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isSubmitting = state is PostCreating;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                if (_attachments.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: _attachments.length,
                      itemBuilder: (context, index) {
                        final file = _attachments[index];
                        return ListTile(
                          title: Text(file.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _attachments.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: isSubmitting ? null : _pickAttachment,
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Add Attachment"),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: isSubmitting ? null : _submitPost,
                      child: isSubmitting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Post"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
