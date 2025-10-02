import 'dart:io';
import 'package:academia/config/router/routes.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/communities/communities.dart';
import 'package:academia/features/communities/presentation/bloc/create_community_bloc.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  File? _bannerImage;
  File? _logoImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickBannerImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      // Get the original file path
      final File originalImage = File(picked.path);

      // Get the compressed file path
      final String targetPath =
          '${originalImage.parent.path}/compressed_banner.jpg';

      // Compress the image
      final XFile? compressedImage =
          await FlutterImageCompress.compressAndGetFile(
            originalImage.absolute.path,
            targetPath,
            quality: 70,
            minWidth: 1024,
            minHeight: 1024,
          );

      if (compressedImage != null) {
        setState(() {
          _bannerImage = File(compressedImage.path);
        });
      }
    }
  }

  Future<void> _pickLogoImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      // Get the original file path
      final File originalImage = File(picked.path);

      // Get the compressed file path
      final String targetPath =
          '${originalImage.parent.path}/compressed_logo.jpg';

      // Compress the image
      final XFile? compressedImage =
          await FlutterImageCompress.compressAndGetFile(
            originalImage.absolute.path,
            targetPath,
            quality: 70,
            minWidth: 512,
            minHeight: 512,
          );

      if (compressedImage != null) {
        setState(() {
          _logoImage = File(compressedImage.path);
        });
      }
    }
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final profileState = context.read<ProfileBloc>().state;

      if (profileState is ProfileLoadedState) {
        context.read<CreateCommunityBloc>().add(
          SubmitNewCommunity(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            isPublic: !_isPrivate, // true if not private
            userEmail: profileState.profile.email,
            userId: profileState.profile.id,
            userName: profileState.profile.name,
            logoPath: _logoImage?.path,
            bannerPath: _bannerImage?.path,
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
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
          CommunitiesRoute(
            communityId: state.community.id.toString(),
          ).pushReplacement(context);
        } else if (state is CreateCommunityFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      _nameController.text = "";
                      _descriptionController.text = "";
                      setState(() {
                        _bannerImage = null;
                        _logoImage = null;
                      });
                    },
                    tooltip: "Reset the form",
                    icon: Icon(Symbols.device_reset, color: Colors.white),
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
                                    ? Text("Hello")
                                    : null,
                              ),
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
                        const SizedBox(height: 24),

                        Align(
                          alignment: Alignment.center,
                          child: state is CreateCommunityLoading
                              ? SpinningScallopIndicator()
                              : FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.all(22),
                                  ),
                                  onPressed: () => _onSubmit(context),
                                  label: const Text("Create Community"),
                                ),
                        ),
                        SizedBox(width: 12),
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
