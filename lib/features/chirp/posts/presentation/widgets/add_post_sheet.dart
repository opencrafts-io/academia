import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:academia/config/router/routes.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// The post composer, shown as a tall modal sheet.
class AddPostSheet extends StatefulWidget {
  final Community? preselectedCommunity;

  const AddPostSheet({super.key, this.preselectedCommunity});

  @override
  State<AddPostSheet> createState() => _AddPostSheetState();
}

class _AddPostSheetState extends State<AddPostSheet>
    with PostCommunitySelection {
  final picker = ImagePicker();
  final List<XFile> attachments = [];
  String? authorId;
  PollDraft? _pollDraft;
  bool _isSubmitting = false;

  /// Set after a failed submit: from then on every field shows its errors.
  bool _showErrors = false;

  /// Inline status line. Snackbars would render behind the sheet.
  String? _notice;
  bool _noticeIsError = false;
  Timer? _noticeTimer;

  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescriptionController =
      TextEditingController();

  final formState = GlobalKey<FormState>();

  /// With a poll attached, the title is optional: the poll carries the post.
  bool get _hasPoll => _pollDraft != null;

  /// Anything the user would lose by leaving.
  bool get _isDirty =>
      _postTitleController.text.trim().isNotEmpty ||
      _postDescriptionController.text.trim().isNotEmpty ||
      attachments.isNotEmpty ||
      _hasPoll;

  /// Enough to try posting; [_submitPost] reports anything still missing.
  bool get _canPost =>
      !_isSubmitting &&
      (_postTitleController.text.trim().isNotEmpty || _hasPoll);

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
      _showNotice("Couldn't process that image. Please try again.");
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
      _showNotice("Couldn't process those images. Please try again.");
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
      _showNotice("Couldn't crop that image. Please try again.");
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final pickedFile = await picker.pickVideo(source: source);
      if (pickedFile == null) return;

      if (!mounted) return;

      final trimmedVideoPath = await TrimVideoRoute(pickedFile.path)
          .push<String>(context);

      if (trimmedVideoPath != null) {
        setState(() => attachments.add(XFile(trimmedVideoPath)));
      }
    } catch (e) {
      _showNotice("Couldn't process that video. Please try again.");
    }
  }

  Future<void> _openPollSheet() async {
    final draft = await showCreatePollSheet(context, initial: _pollDraft);
    if (draft == null || !mounted) return;
    setState(() => _pollDraft = draft);
  }

  void _showNotice(String message, {bool isError = true}) {
    if (!mounted) return;
    _noticeTimer?.cancel();
    setState(() {
      _notice = message;
      _noticeIsError = isError;
    });
    _noticeTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _notice = null);
    });
  }

  Future<void> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Discard post?"),
        content: const Text("You'll lose what you've written so far."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Keep editing"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Discard"),
          ),
        ],
      ),
    );
    if ((discard ?? false) && mounted) Navigator.of(context).pop();
  }

  Future<void> _submitPost() async {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();

    if (!formState.currentState!.validate()) {
      setState(() => _showErrors = true);
      return;
    }

    // Choosing where to post is part of posting, not a gate in front of it.
    if (selectedCommunity == null && await pickCommunity() == null) {
      if (mounted) setState(() => _showErrors = true);
      return;
    }
    if (!mounted) return;

    setState(() => _isSubmitting = true);

    final community = selectedCommunity!;
    final poll = _pollDraft;
    final title = _postTitleController.text.trim();

    final result = await submitPost(
      context.read<FeedBloc>(),
      CreatePostEvent(
        // A poll-only post is titled by its question so share text and
        // notifications still read naturally; cards hide the duplicate.
        title: title.isEmpty && poll != null ? poll.question : title,
        authorId: authorId ?? '',
        communityId: community.id,
        content: _postDescriptionController.text.trim(),
        attachments: List<XFile>.from(attachments),
        poll: poll,
      ),
    );

    if (!mounted) return;

    if (result is PostCreated) {
      LastPostCommunity.write(community.id);
      final messenger = ScaffoldMessenger.of(context);
      context.pop(true);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Posted to a/${community.name}"),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } else {
      setState(() => _isSubmitting = false);
      _showNotice("Couldn't create your post. Please try again.");
    }
  }

  void _rebuild() => setState(() {});

  @override
  void initState() {
    super.initState();

    final userState = context.read<ProfileBloc>().state;

    authorId = userState is ProfileLoadedState ? userState.profile.id : null;

    _postTitleController.addListener(_rebuild);
    _postDescriptionController.addListener(_rebuild);

    initCommunitySelection(widget.preselectedCommunity);
  }

  @override
  void dispose() {
    _noticeTimer?.cancel();
    _postTitleController.dispose();
    _postDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return PopScope(
      canPop: !_isDirty || _isSubmitting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmDiscard();
      },
      child: communityListener(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
              child: Row(
                children: [
                  CloseButton(onPressed: () => Navigator.maybePop(context)),
                  const SizedBox(width: 4),
                  Text("New post", style: textTheme.titleLarge),
                  const Spacer(),
                  FilledButton(
                    onPressed: _canPost ? _submitPost : null,
                    child: _isSubmitting
                        ? SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : const Text("Post"),
                  ),
                ],
              ),
            ),
            // The sheet has a fixed height; the toolbar stays at the bottom.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: formState,
                  autovalidateMode: _showErrors
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CommunityPickerButton(
                        community: selectedCommunity,
                        onPressed: _isSubmitting ? () {} : pickCommunity,
                        showError: _showErrors && selectedCommunity == null,
                      ),
                      if (_showErrors && selectedCommunity == null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 12),
                          child: Text(
                            "Choose a community to post in",
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.error,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _postTitleController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 250,
                        maxLines: null,
                        style: textTheme.titleLarge,
                        buildCounter: _nearLimitCounter,
                        validator: (input) {
                          final text = input?.trim() ?? '';
                          if (_hasPoll && text.isEmpty) return null;
                          if (text.isEmpty) return "Add a title";
                          if (text.length < 3) {
                            return "Titles need at least 3 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: _hasPoll ? "Title (optional)" : "Title",
                          hintStyle: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _postDescriptionController,
                        maxLines: null,
                        minLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        style: textTheme.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: "Body text (optional)",
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                      if (_pollDraft != null) ...[
                        const SizedBox(height: 8),
                        PollDraftPreview(
                          draft: _pollDraft!,
                          onEdit: _openPollSheet,
                          onRemove: () => setState(() => _pollDraft = null),
                        ),
                      ],
                      if (attachments.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        AttachmentPreviewCarousel(
                          attachments: attachments,
                          onRemove: (index) =>
                              setState(() => attachments.removeAt(index)),
                          onCrop: _cropAttachment,
                          onMessage: _showNotice,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (_notice != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  _notice!,
                  style: textTheme.bodySmall?.copyWith(
                    color: _noticeIsError
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ComposerToolbar(
              onTakePhoto: _captureImage,
              onPickPhoto: _pickImagesFromGallery,
              onTakeVideo: () => _pickVideo(ImageSource.camera),
              onPickVideo: () => _pickVideo(ImageSource.gallery),
              onPoll: _openPollSheet,
              hasPoll: _hasPoll,
            ),
          ],
        ),
      ),
    );
  }
}

/// Character counters are noise until the user gets close to the limit.
Widget? _nearLimitCounter(
  BuildContext context, {
  required int currentLength,
  required bool isFocused,
  required int? maxLength,
}) {
  if (maxLength == null || currentLength < maxLength * 0.8) return null;
  return Text('$currentLength/$maxLength');
}
