import 'package:flutter/material.dart';

import '../../domain/entities/study_entities.dart';

class OpenEndedPracticeWidget extends StatefulWidget {
  const OpenEndedPracticeWidget({required this.set, super.key});
  final QuestionSet set;

  @override
  State<OpenEndedPracticeWidget> createState() =>
      _OpenEndedPracticeWidgetState();
}

class _OpenEndedPracticeWidgetState extends State<OpenEndedPracticeWidget> {
  int _index = 0;
  bool _revealed = false;
  final _drafts = <int, String>{};
  final _controllers = <int, TextEditingController>{};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.set.questions.cast<OpenEndedQuestion>();
    final question = questions[_index];
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar.large(
            title: Text('Open-ended practice'),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: (_index + 1) / questions.length,
                          minHeight: 8,
                          backgroundColor: colors.surfaceContainerHighest,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Chip(
                      avatar: const Icon(Icons.edit_note_rounded, size: 18),
                      label: Text('${_index + 1} / ${questions.length}'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Card.filled(
                  color: colors.tertiaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      question.question,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colors.onTertiaryContainer,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  key: ValueKey(_index),
                  minLines: 5,
                  maxLines: 12,
                  textInputAction: TextInputAction.newline,
                  controller: _controllers.putIfAbsent(
                    _index,
                    () => TextEditingController(text: _drafts[_index]),
                  ),
                  onChanged: (value) => _drafts[_index] = value,
                  decoration: InputDecoration(
                    labelText: 'Your thoughts',
                    hintText:
                        'Write a draft before you reveal the model answer…',
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: colors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your draft stays on this screen. It is not graded.',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => setState(() => _revealed = !_revealed),
                  icon: Icon(
                    _revealed
                        ? Icons.visibility_off_outlined
                        : Icons.lightbulb_outline_rounded,
                  ),
                  label: Text(
                    _revealed ? 'Hide model answer' : 'Reveal model answer',
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: _revealed
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Card.filled(
                            color: colors.secondaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.auto_awesome_outlined,
                                        color: colors.onSecondaryContainer,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Model answer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color:
                                                  colors.onSecondaryContainer,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    question.modelAnswer,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: colors.onSecondaryContainer,
                                          height: 1.45,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                if (_index < questions.length - 1) ...[
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () => setState(() {
                      _index++;
                      _revealed = false;
                    }),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Next question'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
