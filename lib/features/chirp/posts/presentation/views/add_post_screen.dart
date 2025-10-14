import 'dart:io';
import 'dart:typed_data';
import 'package:academia/config/router/routes.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final picker = ImagePicker();
  XFile? file;
  final List<XFile> attachments = [];
  Community? _selectedCommunity;
  String? authorId;

  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescriptionController =
      TextEditingController();

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

      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      Uint8List finalImageBytes;

      if (editedImage != null) {
        finalImageBytes = await FlutterImageCompress.compressWithList(
          editedImage,
          quality: 75,
          minWidth: 1080,
          minHeight: 1080,
        );
        print(
          "Compressed user-edited image: ${finalImageBytes.lengthInBytes / 1024} KB",
        );
      } else {
        finalImageBytes = await FlutterImageCompress.compressWithList(
          imageData,
          quality: 70,
          minWidth: 1080,
          minHeight: 1080,
        );
        print(
          "Compressed original image: ${finalImageBytes.lengthInBytes / 1024} KB",
        );
      }

      final file = File(filePath);
      await file.writeAsBytes(finalImageBytes);

      setState(() {
        attachments.add(XFile(file.path));
      });

      print("Saved compressed image at: ${file.path}");
    } catch (e) {
      _showSnackBar("Failed to pick or edit image: $e");
      debugPrint("Error in _pickImage: $e");
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile == null) return;

      if (!mounted) return;

      final trimmedVideoPath = await TrimVideoRoute(
        videoPath: pickedFile.path,
      ).push(context);

      if (trimmedVideoPath != null) {
        setState(() => attachments.add(XFile(trimmedVideoPath)));
      }
    } catch (e) {
      _showSnackBar("Failed to pick or trim video: $e");
    }
  }

  Future<Uint8List?> _getAttachmentThumbnail(XFile attachment) async {
    try {
      if (attachment.path.contains('mp4')) {
        final thumbnailBytes = await VideoThumbnail.thumbnailData(
          video: attachment.path,
          imageFormat: ImageFormat.JPEG,
          quality: 25,
        );
        return thumbnailBytes;
      } else {
        return await attachment.readAsBytes();
      }
    } catch (e) {
      _showSnackBar("Failed to generate thumbnail for post attachment");
      return null;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _submitPost() async {
    final title = _postTitleController.text.trim();
    final content = _postDescriptionController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      _showSnackBar("Please enter both a title and content before posting.");
      Vibration.vibrate(duration: 80);
      return;
    }

    if (_selectedCommunity == null) {
      _showSnackBar("Please select a community to post in.");
      Vibration.vibrate(duration: 80);
      return;
    }

    print("Sending ${attachments.length} attachments to bloc");
    print('Attachments files: ${attachments.map((e) => e.path).toList()}');

    if (!mounted) return;

    context.read<FeedBloc>().add(
      CreatePostEvent(
        title: title,
        authorId: authorId ?? '',
        communityId: _selectedCommunity!.id,
        content: content,
        attachments: List<XFile>.from(attachments),
      ),
    );

    _showSnackBar("Submitting post...");
    Vibration.vibrate(duration: 50);

    setState(() {
      _postTitleController.clear();
      _postDescriptionController.clear();
      attachments.clear();
      _selectedCommunity = null;
    });

    context.pop();
  }

  @override
  void initState() {
    super.initState();

    final userState = context.read<ProfileBloc>().state;

    if (userState is ProfileLoadedState) {
      authorId = userState.profile.id;
    } else {
      authorId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding AddPostPage — attachments count: ${attachments.length}');
    print(
      'Rebuilding AddPostPage — attachments files: ${attachments.map((e) => e.path).toList()}',
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(title: Text("Create Post")),
            SliverPadding(
              padding: EdgeInsetsGeometry.all(12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchAnchor.bar(
                      barElevation: WidgetStateProperty.all(0),
                      barHintText: "Select community",
                      barHintStyle: WidgetStateProperty.all(
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      barBackgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.outlineVariant,
                      ),
                      barTextStyle: WidgetStatePropertyAll(
                        Theme.of(context).textTheme.headlineSmall,
                      ),

                      suggestionsBuilder: (context, controller) {
                        if (controller.text.trim().isNotEmpty) {
                          context
                              .read<CommunityListingCubit>()
                              .getPostableCommunities(
                                page: 1,

                                // searchTerm: controller.text.trim(),
                              );
                        }
                        return [
                          BlocBuilder<
                            CommunityListingCubit,
                            CommunityListingState
                          >(
                            builder: (context, state) {
                              if (state is CommunityListingLoadingState) {
                                return Column(
                                  children: [SpinningScallopIndicator()],
                                );
                              } else if (state is CommunityListingLoadedState) {
                                final communities = state.communities;
                                if (communities.isEmpty) {
                                  return const ListTile(
                                    leading: AnimatedEmoji(AnimatedEmojis.sad),
                                    title: Text(
                                      "No communities found try joining one",
                                    ),
                                  );
                                }
                                return Column(
                                  children: communities
                                      .map(
                                        (community) => ListTile(
                                          onTap: () {
                                            Vibration.vibrate(duration: 50);
                                            setState(() {
                                              _selectedCommunity = community;
                                              controller.closeView(
                                                community.name,
                                              );
                                            });
                                          },
                                          leading: CircleAvatar(
                                            backgroundImage:
                                                community.profilePictureUrl ==
                                                    null
                                                ? null
                                                : CachedNetworkImageProvider(
                                                    community
                                                        .profilePictureUrl!,
                                                    errorListener: (error) {},
                                                  ),
                                            child:
                                                community.profilePictureUrl ==
                                                    null
                                                ? Text(community.name[0])
                                                : null,
                                          ),
                                          title: Text(community.name),
                                          subtitle: Text(
                                            community.description ??
                                                'No description',
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }

                              return SizedBox.shrink();
                            },
                          ),
                        ];
                      },
                    ),
                    SizedBox(height: 22),
                    Text("Configure your post"),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _postTitleController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 250,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        prefixIcon: AnimatedEmoji(AnimatedEmojis.thinkingFace),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Whats on your mind",
                        hintStyle: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _postDescriptionController,
                      maxLines: null,
                      minLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Talk about the issue alittle more..",
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: SliverPinnedHeader(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Configure post attachments"),
                      SizedBox(height: 22),
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
                                        "Item successfully removed",
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
                          future: _getAttachmentThumbnail(
                            attachment,
                          ), // Use the helper function here
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  // Display the image or video thumbnail
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (attachment.path.endsWith('mp4'))
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: CircleAvatar(
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error loading attachment'),
                              );
                            } else {
                              // Show a loading indicator while the thumbnail is generated
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
              padding: EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.center,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(padding: EdgeInsets.all(22)),
                    onPressed: () => _submitPost(),
                    label: Text("Create post"),
                    icon: Icon(Icons.add),
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
