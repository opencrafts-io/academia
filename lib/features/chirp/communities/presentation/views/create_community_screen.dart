import 'dart:io';
import 'dart:typed_data';
import 'package:academia/config/router/routes.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart' as image_editor_options;
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPrivate = false;
  bool _isNSFW = false;
  File? _bannerImage;
  File? _logoImage;

  final String policyText =
      "By creating this community, you agree to uphold our standards."
      "Remember, you are responsible for the content and conduct within your space. "
      "Please ensure all discussions remain respectful, inclusive, "
      "and free of hate speech or harassment. Failure to moderate or adhere "
      "to these guidelines may lead to the community's removal and account sanctions.";

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickBannerImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked == null) return;

      final File originalImage = File(picked.path);
      final imageData = await originalImage.readAsBytes();
      if (!mounted) return;

      // Crop the image, locked to 16:9
      final Uint8List? croppedBytes = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropper(
            image: imageData,
            availableRatios: [
              image_editor_options.AspectRatio(title: "16:9", ratio: 16 / 9),
            ],
          ),
        ),
      );

      if (croppedBytes == null) return;

      final String croppedPath =
          '${originalImage.parent.path}/cropped_banner.jpg';
      final File croppedFile = await File(
        croppedPath,
      ).writeAsBytes(croppedBytes);

      // Compress cropped file
      final String targetPath =
          '${originalImage.parent.path}/compressed_banner.jpg';
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            targetPath,
            quality: 70,
            minWidth: 1024,
            minHeight: 1024,
          );

      if (compressedFile != null && mounted) {
        setState(() {
          _bannerImage = File(compressedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking or cropping banner: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to process banner image")),
        );
      }
    }
  }

  Future<void> _pickLogoImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked == null) return;

      final File originalImage = File(picked.path);
      final imageData = await originalImage.readAsBytes();
      if (!mounted) return;

      final Uint8List? croppedBytes = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageCropper(
            image: imageData,
            availableRatios: [
              image_editor_options.AspectRatio(title: "1:1", ratio: 1 / 1),
            ],
          ),
        ),
      );

      if (croppedBytes == null) return;

      // Save cropped bytes to temporary file
      final String croppedPath =
          '${originalImage.parent.path}/cropped_logo.jpg';
      final File croppedFile = await File(
        croppedPath,
      ).writeAsBytes(croppedBytes);

      // Compress the cropped file
      final String targetPath =
          '${originalImage.parent.path}/compressed_logo.jpg';
      final XFile? compressedFile =
          await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            targetPath,
            quality: 70,
            minWidth: 512,
            minHeight: 512,
          );

      if (compressedFile != null && mounted) {
        setState(() {
          _logoImage = File(compressedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking or cropping logo: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to process logo image")),
        );
      }
    }
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final profileState = context.read<ProfileBloc>().state;

      if (profileState is ProfileLoadedState) {
        context.read<CreateCommunityBloc>().add(
          SubmitNewCommunity(
            community: Community(
              updatedAt: DateTime.now(),
              createdAt: DateTime.now(),
              creatorId: profileState.profile.id,
              guidelines: [],
              visibility: _isPrivate ? "private" : "public",
              private: _isPrivate,
              name: _nameController.text.trim(),
              description: _descriptionController.text.trim(),
              id: 0,
              profilePicture: _logoImage?.path,
              banner: _bannerImage?.path,
              nsfw: _isNSFW,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCommunityBloc, CreateCommunityState>(
      listener: (context, state) {
        if (state is CreateCommunitySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Community successfully created!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
          CommunitiesRoute(
            communityId: state.community.id.toString(),
          ).pushReplacement(context);
        } else if (state is CreateCommunityFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                floating: true,
                snap: true,
                pinned: true,
                title: const Text("Create Community"),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: _bannerImage == null
                          ? null
                          : DecorationImage(
                              image: FileImage(_bannerImage!),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  title: Text("Create Community"),
                ),
                actions: [
                  IconButton(
                    onPressed: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        title: Text("Clear form?"),
                        content: Text(
                          "Are you sure you want to reset the form?"
                          "\nChanges you made to this form might be lost!",
                        ),
                        actions: [
                          FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _nameController.text = "";
                              _descriptionController.text = "";
                              setState(() {
                                _bannerImage = null;
                                _logoImage = null;
                              });
                              Navigator.pop(context);
                            },
                            child: Text("Im sure"),
                          ),
                        ],
                      ),
                    ),
                    tooltip: "Reset the form",
                    icon: Icon(Symbols.ink_eraser),
                  ),
                ],
              ),
              // Main form content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _logoImage != null
                                ? FileImage(_logoImage!)
                                : null,

                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(60),
                              child: GestureDetector(
                                onTap: () => _pickLogoImage(),
                                child: _logoImage == null
                                    ? Text("Pick Profile")
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Card.outlined(
                            child: ListTile(
                              onTap: () => _pickBannerImage(),
                              title: Text("Tap to upload banner image"),
                              trailing: Icon(Icons.image),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        // Community name
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "A name for your community",
                            filled: true,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter a name"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText:
                                "Please describe what your community is all about",
                            filled: true,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Privacy toggle
                        Card.filled(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(22),
                          ),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: SwitchListTile(
                            title: Text(
                              _isPrivate
                                  ? "Private community"
                                  : "Public Community",
                            ),
                            subtitle: Text(
                              _isPrivate
                                  ? "Only invited members can join"
                                  : "Anyone can join",
                            ),
                            value: _isPrivate,
                            onChanged: (val) {
                              setState(() => _isPrivate = val);
                            },
                          ),
                        ),

                        const SizedBox(height: 16),
                        Card.filled(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(22),
                          ),

                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: CheckboxListTile(
                            title: Text("Add NSFW tag"),
                            subtitle: Text(
                              "Community may contain mature content",
                              // style: Theme.of(context).textTheme.bodySmall,
                            ),
                            value: _isNSFW,
                            onChanged: (val) {
                              setState(() {
                                _isNSFW = val!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        Align(
                          alignment: Alignment.center,
                          child: state is CreateCommunityLoading
                              ? SpinningScallopIndicator()
                              : FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.all(22),
                                  ),
                                  onPressed: () async {
                                    final isAccepted = await showAdaptiveDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog.adaptive(
                                            title: Text(
                                              "Community Creation Policy",
                                            ),
                                            content: Text(policyText),
                                            actions: [
                                              FilledButton(
                                                onPressed: () {
                                                  context.pop(true);
                                                },
                                                child: Text("I agree"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.pop(false);
                                                },
                                                child: Text("Never mind"),
                                              ),
                                            ],
                                          ),
                                    );

                                    if (isAccepted && context.mounted) {
                                      _onSubmit(context);
                                    }
                                  },
                                  icon: Icon(Icons.group_add),
                                  label: const Text("Create Community"),
                                ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
