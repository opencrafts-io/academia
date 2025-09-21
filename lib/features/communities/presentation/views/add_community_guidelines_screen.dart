import 'package:flutter/material.dart';

class AddCommunityGuidelinesScreen extends StatefulWidget {
  final String communityId;

  const AddCommunityGuidelinesScreen({super.key, required this.communityId});

  @override
  State<AddCommunityGuidelinesScreen> createState() =>
      _AddCommunityGuidelinesScreenState();
}

class _AddCommunityGuidelinesScreenState
    extends State<AddCommunityGuidelinesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _guidelinesController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _guidelinesController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // TODO: Hook this into your bloc or API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Community guidelines updated")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                "Set rules or guidelines for this community. Members will see this in the About tab.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _guidelinesController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Write the community rules here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Guidelines cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(_isSubmitting ? "Saving..." : "Save Guidelines"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
