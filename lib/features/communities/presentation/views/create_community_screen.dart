import 'dart:io';
import 'package:academia/config/router/routes.dart';
import 'package:academia/features/communities/presentation/bloc/create_community_bloc.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
      setState(() {
        _bannerImage = File(picked.path);
      });
    }
  }

  Future<void> _pickLogoImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _logoImage = File(picked.path);
      });
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
            userName: profileState.profile.username ?? profileState.profile.name,
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
          CommunitiesRoute(communityId: '5').push(context);
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
              SliverAppBar(pinned: true, title: const Text("Create Community")),
              // Main form content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner upload
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Banner Image",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () => _pickBannerImage(),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(12),
                                  image: _bannerImage != null
                                      ? DecorationImage(
                                          image: FileImage(_bannerImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: const Center(
                                  child: Icon(Icons.image_outlined, size: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Logo image upload
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => _pickLogoImage(),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                backgroundImage: _logoImage != null
                                    ? FileImage(_logoImage!)
                                    : null,
                                child: _logoImage == null
                                    ? const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 30,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Logo Image",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Community name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Community Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter a name"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Privacy toggle
                        SwitchListTile(
                          title: const Text("Private Community"),
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
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => state is CreateCommunityLoading
                                ? null
                                : _onSubmit(context),
                            child: state is CreateCommunityLoading
                                ? const CircularProgressIndicator()
                                : const Text("Create Community"),
                          ),
                        ),
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
