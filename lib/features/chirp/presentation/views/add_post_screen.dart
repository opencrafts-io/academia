import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/chirp/domain/entities/group.dart';
import 'package:go_router/go_router.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _contentController = TextEditingController();
  final List<PlatformFile> _attachments = [];
  Group? _selectedGroup;

  // Dummy list of groups for demonstration
  //TODO: fetch from community bloc
  //TODO: fetch only communities user has joined. If none, join button??
  final List<Group> _dummyGroups = [
    Group(
      id: "1",
      name: "General",
      description: "General community for all posts",
    ),
    Group(id: "2", name: "Tech Enthusiasts", description: "For all things tech"),
    Group(
      id: "3",
      name: "Fech Enthusiasts",
      description: "A community for tech lovers",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Set a default group if available
    if (_dummyGroups.isNotEmpty) {
      _selectedGroup = _dummyGroups.first;
    }
  }

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

    if (_selectedGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a community to post in.")),
      );
      return;
    }

    if (content.isEmpty && _attachments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post must have content or an attachment."),
        ),
      );
      return;
    }

    final profileState = BlocProvider.of<ProfileBloc>(context).state;

    if (profileState is ProfileLoadedState) {
      final userName = profileState.profile.name;
      final email = profileState.profile.email;


      context.read<FeedBloc>().add(
        CreatePostEvent(
          content: content,
          files: _attachments,
          userName: userName,
          email: email,
          groupId: _selectedGroup!.id,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User profile not loaded. Please try again."),
        ),
      );
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
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
            context.pop();
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
                DropdownButtonFormField<Group>(
                  decoration: InputDecoration(
                    labelText: "Select Community",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  value: _selectedGroup,
                  items: _dummyGroups.map((group) {
                    return DropdownMenuItem<Group>(
                      value: group,
                      child: Text(group.name),
                    );
                  }).toList(),
                  onChanged: (Group? newValue) {
                    setState(() {
                      _selectedGroup = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a community' : null,
                ),
                const SizedBox(height: 12),
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
