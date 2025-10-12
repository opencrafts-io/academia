import 'package:academia/features/chirp/communities/presentation/bloc/community_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddCommunityGuidelinesScreen extends StatefulWidget {
  final String communityId;
  final String userId;

  const AddCommunityGuidelinesScreen({
    super.key,
    required this.communityId,
    required this.userId,
  });

  @override
  State<AddCommunityGuidelinesScreen> createState() =>
      _AddCommunityGuidelinesScreenState();
}

class _AddCommunityGuidelinesScreenState
    extends State<AddCommunityGuidelinesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ruleController = TextEditingController();
  final List<String> _rules = []; // stores the rules

  @override
  void dispose() {
    _ruleController.dispose();
    super.dispose();
  }

  void _addRule() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _rules.add(_ruleController.text.trim());
      _ruleController.clear();
    });
  }

  void _removeRule(int index) {
    setState(() {
      _rules.removeAt(index);
    });
  }

  void _submit() {
    if (_rules.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one rule")),
      );
      return;
    }

    context.read<CommunityHomeBloc>().add(
      AddCommunityGuidelines(
        communityId: widget.communityId,
        userId: widget.userId,
        rule: _rules,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityHomeBloc, CommunityHomeState>(
      listener: (context, state) {
        if (state is CommunityHomeLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Guidelines created successfully")),
          );
          context.pop();
        }
        if (state is CommunityHomeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to add guidelines")),
          );
        }
      },
      child: BlocBuilder<CommunityHomeBloc, CommunityHomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Add Guidelines")),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Community Guidelines",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Add rules one by one. Members will see these in the About tab.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input field with Add button
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ruleController,
                            decoration: InputDecoration(
                              hintText: "Enter a rule...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter a rule";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _addRule(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _addRule,
                          icon: const Icon(Icons.add_circle, size: 28),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // List of added rules
                    Expanded(
                      child: _rules.isEmpty
                          ? Center(
                              child: Text(
                                "No rules added yet.",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _rules.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text("${index + 1}"),
                                    ),
                                    title: Text(_rules[index]),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _removeRule(index),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    const SizedBox(height: 16),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: state is CommunityHomeLoading
                            ? null
                            : _submit,
                        icon: state is CommunityHomeLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          state is CommunityHomeLoading
                              ? "Saving..."
                              : "Save Guidelines",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
