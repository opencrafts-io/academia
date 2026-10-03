import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/study_entities.dart';
import '../cubit/study_tools_cubit.dart';
import '../routes/study_tools_routes.dart';

class QuestionSetSection extends StatefulWidget {
  const QuestionSetSection({
    required this.noteId,
    required this.format,
    super.key,
  });
  final int noteId;
  final QuestionFormat format;
  @override
  State<QuestionSetSection> createState() => _QuestionSetSectionState();
}

class _QuestionSetSectionState extends State<QuestionSetSection> {
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await context.read<StudyToolsCubit>().loadQuestions(widget.format);
    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StudyToolsCubit, StudyToolsState>(
        builder: (context, state) {
          final sets = state.questionSets[widget.format] ?? const [];
          if (sets.isEmpty && !_loaded) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: LinearProgressIndicator(),
            );
          }
          if (sets.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(_icon, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    widget.format.label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    '${sets.length} ${sets.length == 1 ? 'set' : 'sets'}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (var index = 0; index < sets.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card.filled(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => StudyPracticeRoute(
                        materialId: widget.noteId,
                        setId: sets[index].id,
                        format: widget.format.apiValue,
                      ).push(context),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const SizedBox.square(
                                dimension: 44,
                                child: Icon(Icons.play_arrow_rounded),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${sets[index].questions.length} questions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat.yMMMd().format(
                                      sets[index].generatedAt,
                                    ),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (index == 0)
                              const Padding(
                                padding: EdgeInsetsDirectional.only(end: 8),
                                child: Chip(
                                  label: Text('Newest'),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );

  IconData get _icon => switch (widget.format) {
    QuestionFormat.flashcard => Icons.style_outlined,
    QuestionFormat.mcq => Icons.fact_check_outlined,
    QuestionFormat.openEnded => Icons.edit_note_rounded,
  };
}
