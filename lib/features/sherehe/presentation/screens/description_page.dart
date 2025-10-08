import 'package:academia/features/sherehe/presentation/widgets/genre_selector_widget.dart';
import 'package:academia/features/sherehe/presentation/widgets/modern_input_decoration.dart';
import 'package:flutter/material.dart';

class EventDescriptionPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController aboutController;
  final List<String> selectedGenres;
  final VoidCallback onShowGenreSelectionDialog;
  final void Function(String genre) onGenreDeleted;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final BuildContext context;

  const EventDescriptionPage({
    super.key,
    required this.formKey,
    required this.aboutController,
    required this.selectedGenres,
    required this.onShowGenreSelectionDialog,
    required this.onGenreDeleted,
    required this.onPrevious,
    required this.onNext,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Description & Genre",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            GenreSelectorWidget(
              selectedGenres: selectedGenres,
              onSelectGenresPressed: onShowGenreSelectionDialog,
              onGenreDeleted: onGenreDeleted,
              screenContext: context,
            ),
            if (selectedGenres.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please select at least one genre *',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            TextFormField(
              controller: aboutController,
              maxLines: 4,
              minLines: 2,
              decoration: buildModernInputDecoration(
                context: context,
                labelText: 'About Event *',
                hintText: 'Tell us more about your event...',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please provide details about the event';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPrevious,
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onNext,
                    label: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
