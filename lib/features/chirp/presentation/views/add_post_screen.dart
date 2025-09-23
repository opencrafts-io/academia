import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final picker = ImagePicker();
  XFile? file;
  final List<XFile> attachments = [];
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile == null) return;

      final imageData = await pickedFile.readAsBytes();
      if (!mounted) return;

      final editedImage = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageEditor(image: imageData)),
      );

      if (editedImage != null) {
        setState(() => attachments.add(XFile.fromData(editedImage)));
      }
    } catch (e) {
      _showSnackBar("Failed to pick or edit image: $e");
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile == null) return;

      if (!mounted) return;

      // final trimmedVideo = await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         VideoTrimmerPage(videoFile: File(pickedFile.path)),
      //   ),
      // );
      //
      // if (trimmedVideo != null) {
      //   setState(() => file = XFile(trimmedVideo.path));
      // }
    } catch (e) {
      _showSnackBar("Failed to pick or trim video: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(title: Text("Create Post")),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverPinnedHeader(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              LabeledIconButton(
                                onPressed: () async =>
                                    _pickImage(ImageSource.camera),

                                label: "Take photo",
                                icon: Icons.photo_camera_outlined,
                              ),
                            ],
                          ),
                          LabeledIconButton(
                            label: "Take Video",
                            onPressed: () async =>
                                _pickVideo(ImageSource.camera),
                            icon: Icons.video_camera_back_outlined,
                          ),

                          LabeledIconButton(
                            onPressed: () async =>
                                _pickImage(ImageSource.gallery),
                            label: "Photo Gallery",
                            icon: Icons.add_photo_alternate_outlined,
                          ),
                          LabeledIconButton(
                            label: "Video gallery",
                            onPressed: () async =>
                                _pickVideo(ImageSource.gallery),
                            icon: Icons.video_library_outlined,
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
            SliverVisibility(
              visible: attachments.isNotEmpty,
              maintainSize: false,
              maintainState: true,
              sliver: SliverPadding(
                padding: EdgeInsetsGeometry.all(12),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: CarouselView.weighted(
                      enableSplash: true,
                      onTap: (index) {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                // Card.filled(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadiusGeometry.vertical(
                                //       top: Radius.circular(22),
                                //     ),
                                //   ),
                                //   margin: EdgeInsets.all(0),
                                //   color: Theme.of(
                                //     context,
                                //   ).colorScheme.primaryContainer,
                                //   child: ListTile(
                                //     leading: Icon(Icons.save),
                                //     title: Text("Save to gallery"),
                                //     onTap: () async {
                                //       await attachments[index].saveTo(
                                //         "academia_img_${DateTime.now().toString()}",
                                //       );
                                //       if (!context.mounted) return;
                                //       context.pop();
                                //       _showSnackBar("Successfully saved!");
                                //     },
                                //   ),
                                // ),
                                Card.filled(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.vertical(
                                      top: Radius.circular(22),
                                      bottom: Radius.circular(22),
                                    ),
                                  ),

                                  margin: EdgeInsets.all(0),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.errorContainer,
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text("Remove selected attachment"),
                                    onTap: () {
                                      setState(() {
                                        attachments.removeAt(index);
                                      });
                                      if (!context.mounted) return;
                                      context.pop();
                                      _showSnackBar(
                                        "Item successfully removed!",
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      consumeMaxWeight: true,
                      itemSnapping: true,
                      shrinkExtent: 50,
                      flexWeights: [1, 5, 1],
                      children: attachments.map((attachment) {
                        return FutureBuilder(
                          future: attachment.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ClipRRect(
                                child: SizedBox(
                                  height: 230,
                                  width: double.infinity,
                                  child: Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error loading image.'),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsetsGeometry.all(12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 22),
                    Text("Configure your post"),
                    SizedBox(height: 8),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 250,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        prefixIcon: AnimatedEmoji(AnimatedEmojis.thinkingFace),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Whats on your mind",
                        hintStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      maxLines: null,
                      minLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        hintText: "Talk about the issue alittle more..",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.center,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text("Create post"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabeledIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const LabeledIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24.0),
            const SizedBox(height: 4.0),
            Text(label, style: TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}
