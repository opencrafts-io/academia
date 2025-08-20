import 'package:flutter/material.dart';

class GenreSelectorWidget extends StatelessWidget {
  final List<String> selectedGenres;
  final VoidCallback onSelectGenresPressed;
  final Function(String) onGenreDeleted;
  final BuildContext screenContext;

  const GenreSelectorWidget({
    super.key,
    required this.selectedGenres,
    required this.onSelectGenresPressed,
    required this.onGenreDeleted,
    required this.screenContext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genres', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.category_outlined),
          label: const Text('Select Genres'),
          onPressed: onSelectGenresPressed,
        ),
        const SizedBox(height: 10),
        if (selectedGenres.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: selectedGenres.map((genre) {
              return Chip(
                label: Text(genre),
                onDeleted: () => onGenreDeleted(genre),
                deleteIconColor: Theme.of(
                  screenContext,
                ).colorScheme.error.withValues(alpha: 0.7),
                backgroundColor: Theme.of(
                  screenContext,
                ).colorScheme.primaryContainer.withValues(alpha: 0.3),
              );
            }).toList(),
          )
        else
          Text(
            'No genres selected.',
            style: TextStyle(color: Theme.of(screenContext).hintColor),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
