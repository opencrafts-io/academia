import 'dart:io';
import 'dart:typed_data';
import 'package:academia/config/router/routes.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AddPostPage extends StatefulWidget {
  final Community? preselectedCommunity;

  const AddPostPage({super.key, this.preselectedCommunity});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final picker = ImagePicker();
  final List<XFile> attachments = [];
  Community? _selectedCommunity;
  String? authorId;
  bool _isSubmitting = false;

  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescriptionController =
      TextEditingController();
  final SearchController _searchController = SearchController();

  final formState = GlobalKey<FormState>();

  /// Compresses [imageData] and writes it to a fresh temp file, without
  /// forcing any crop - the original framing is preserved. Cropping is an
  /// optional, on-demand action from the attachment carousel.
  Future<XFile> _saveAttachment(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.jpg';

    final compressed = await FlutterImageCompress.compressWithList(
      imageData,
      quality: 80,
      minWidth: 1080,
      minHeight: 1080,
    );

    final file = File(filePath);
    await file.writeAsBytes(compressed);
    return XFile(file.path);
  }

  Future<void> _captureImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      final saved = await _saveAttachment(await pickedFile.readAsBytes());
      setState(() => attachments.add(saved));
    } catch (e) {
      _showSnackBar("Couldn't process that image. Please try again.");
    }
  }

  Future<void> _pickImagesFromGallery() async {
    try {
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isEmpty) return;

      final saved = await Future.wait(
        pickedFiles.map((f) async => _saveAttachment(await f.readAsBytes())),
      );
      setState(() => attachments.addAll(saved));
    } catch (e) {
      _showSnackBar("Couldn't process those images. Please try again.");
    }
  }

  Future<void> _cropAttachment(int index) async {
    try {
      final original = await attachments[index].readAsBytes();
      if (!mounted) return;

      final cropped = await Navigator.push<Uint8List>(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropScreen(image: original),
        ),
      );
      if (cropped == null) return;

      final saved = await _saveAttachment(cropped);
      setState(() => attachments[index] = saved);
    } catch (e) {
      _showSnackBar("Couldn't crop that image. Please try again.");
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile == null) return;

      if (!mounted) return;

      final trimmedVideoPath = await TrimVideoRoute(
        pickedFile.path,
      ).push<String>(context);

      if (trimmedVideoPath != null) {
        setState(() => attachments.add(XFile(trimmedVideoPath)));
      }
    } catch (e) {
      _showSnackBar("Couldn't process that video. Please try again.");
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _submitPost() async {
    if (_isSubmitting) return;
    if (!formState.currentState!.validate()) {
      _showSnackBar("Please fill in the required details");
      return;
    }
    if (_selectedCommunity == null) {
      _showSnackBar("Choose a community to post in");
      return;
    }
    if (!mounted) return;

    setState(() => _isSubmitting = true);

    final feedBloc = context.read<FeedBloc>();
    feedBloc.add(
      CreatePostEvent(
        title: _postTitleController.text.trim(),
        authorId: authorId ?? '',
        communityId: _selectedCommunity!.id,
        content: _postDescriptionController.text.trim(),
        attachments: List<XFile>.from(attachments),
      ),
    );

    final result = await feedBloc.stream
        .firstWhere((state) => state is PostCreated || state is PostCreateError)
        .timeout(
          const Duration(seconds: 120),
          onTimeout: () => const FeedState.postCreateError(
            "Post submission timed out. Please try again.",
          ),
        );

    if (!mounted) return;

    if (result is PostCreated) {
      setState(() {
        _isSubmitting = false;
        _postTitleController.clear();
        _postDescriptionController.clear();
        attachments.clear();
        _selectedCommunity = null;
      });
      _showSnackBar("Post created successfully!");
      context.pop(true);
    } else {
      setState(() => _isSubmitting = false);
      _showSnackBar("Failed to create post. Please try again.");
    }
  }

  @override
  void initState() {
    super.initState();

    final userState = context.read<ProfileBloc>().state;

    authorId = userState is ProfileLoadedState ? userState.profile.id : null;

    if (widget.preselectedCommunity != null) {
      _selectedCommunity = widget.preselectedCommunity;
      _searchController.text = widget.preselectedCommunity!.name;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _postTitleController.dispose();
    _postDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(padding: const EdgeInsets.all(22)),
            onPressed: _isSubmitting ? null : () => _submitPost(),
            label: Text(_isSubmitting ? "Creating post..." : "Create post"),
            icon: _isSubmitting
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.onPrimary,
                    ),
                  )
                : const Icon(Icons.add_rounded),
          ),
        ),
      ),
      body: Form(
        key: formState,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar.large(title: Text("Create post")),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommunitySearchField(
                      searchController: _searchController,
                      onCommunitySelected: (community) =>
                          setState(() => _selectedCommunity = community),
                    ),
                    const SizedBox(height: 22),
                    PostComposerSectionHeader(
                      title: "Post details",
                      icon: Assets.icons.pencil,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _postTitleController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 250,
                      minLines: 1,
                      maxLines: null,
                      style: textTheme.headlineSmall,
                      validator: (input) {
                        if (input!.length < 3) {
                          return "Please add a title";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "What's on your mind?",
                        hintStyle: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _postDescriptionController,
                      maxLines: null,
                      minLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (input) {
                        if (input!.length < 3) {
                          return "Add a bit more detail";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Add some details about your post",
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHigh,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverPinnedHeader(
                child: Container(
                  color: colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostComposerSectionHeader(title: "Add photos or videos"),
                      const SizedBox(height: 16),
                      AttachmentPickerRow(
                        onTakePhoto: _captureImage,
                        onTakeVideo: () => _pickVideo(ImageSource.camera),
                        onPickPhoto: _pickImagesFromGallery,
                        onPickVideo: () => _pickVideo(ImageSource.gallery),
                      ),
                      const Divider(),
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
                padding: const EdgeInsets.all(12),
                sliver: SliverToBoxAdapter(
                  child: AttachmentPreviewCarousel(
                    attachments: attachments,
                    onRemove: (index) =>
                        setState(() => attachments.removeAt(index)),
                    onCrop: _cropAttachment,
                    onMessage: _showSnackBar,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
          ],
        ),
      ),
    );
  }
}
