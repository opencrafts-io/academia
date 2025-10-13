import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EditCommunityInformation extends StatefulWidget {
  const EditCommunityInformation({super.key, required this.communityID});
  final int communityID;

  @override
  State<EditCommunityInformation> createState() =>
      _EditCommunityInformationState();
}

class _EditCommunityInformationState extends State<EditCommunityInformation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Community? community;
  bool _isPrivate = false;
  bool _isNSFW = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<CommunityHomeBloc>().state;
    if (state is CommunityHomeLoaded) {
      community = state.community;
      _nameController.text = community!.name;
      _descriptionController.text = community!.description ?? '';
      _isPrivate = community!.private;
      _isNSFW = community!.nsfw;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(title: Text("Edit community information")),
          SliverPadding(
            padding: EdgeInsetsGeometry.all(16),
            sliver: BlocConsumer<CommunityHomeBloc, CommunityHomeState>(
              listener: (context, state) {
                if (state is CommunityHomeLoaded) {}
              },

              builder: (context, state) {
                if (state is CommunityHomeLoading) {
                  return SliverFillRemaining(
                    child: Center(child: SpinningScallopIndicator()),
                  );
                } else if (state is CommunityHomeLoaded) {
                  return MultiSliver(
                    children: [
                      CircleAvatar(radius: 60),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Card.outlined(
                          child: ListTile(
                            // onTap: () => _pickBannerImage(),
                            title: Text("Tap to upload banner image"),
                            trailing: Icon(Icons.image),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

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
                        child: state is CommunityHomeLoading
                            ? SpinningScallopIndicator()
                            : FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.all(22),
                                ),
                                onPressed: () async {
                                  final isAccepted = await showAdaptiveDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                      title: Text("Confirmation"),
                                      content: Text(
                                        "Are you sure you want to continue"
                                        ". This might affect how your community "
                                        "appears on the platform.",
                                      ),
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

                                  if (isAccepted && context.mounted) {}
                                },
                                icon: Icon(Icons.update),
                                label: const Text("Update community info"),
                              ),
                      ),
                      SizedBox(height: 12),
                    ],
                  );
                }
                return SliverFillRemaining(
                  child: Center(child: Text("Oops something went wrong")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
