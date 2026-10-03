import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../../domain/entities/study_entities.dart';

class McqPracticeWidget extends StatefulWidget {
  const McqPracticeWidget({required this.set, super.key});
  final QuestionSet set;

  @override
  State<McqPracticeWidget> createState() => _McqPracticeWidgetState();
}

class _McqPracticeWidgetState extends State<McqPracticeWidget> {
  int _index = 0;
  final _selected = <int, int>{};
  final _checked = <int>{};

  @override
  Widget build(BuildContext context) {
    final questions = widget.set.questions.cast<MultipleChoiceQuestion>();
    if (_index >= questions.length) return _result(context, questions);
    final question = questions[_index];
    final isChecked = _checked.contains(_index);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar.large(
            title: Text('Multiple choice'),
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
                      avatar: const Icon(Icons.fact_check_outlined, size: 16),
                      label: Text('${_index + 1} / ${questions.length}'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card.filled(
                  color: colors.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      question.question,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colors.onSecondaryContainer,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                for (var index = 0; index < question.choices.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ChoiceTile(
                      index: index,
                      text: question.choices[index],
                      selected: _selected[_index] == index,
                      checked: isChecked,
                      correct: index == question.answerIndex,
                      onTap: () => setState(() => _selected[_index] = index),
                    ),
                  ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  child: isChecked
                      ? Card.filled(
                          color: _selected[_index] == question.answerIndex
                              ? colors.tertiaryContainer
                              : colors.errorContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  _selected[_index] == question.answerIndex
                                      ? Icons.check_circle_outline_rounded
                                      : Icons.info_outline_rounded,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _selected[_index] ==
                                                question.answerIndex
                                            ? 'That’s right'
                                            : 'Review this one',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      if (question.explanation.isNotEmpty) ...[
                                        const SizedBox(height: 6),
                                        Text(question.explanation),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _selected[_index] == null
                      ? null
                      : () => setState(() {
                          if (!isChecked) {
                            _checked.add(_index);
                          } else {
                            _index++;
                          }
                        }),
                  icon: Icon(
                    isChecked
                        ? Icons.arrow_forward_rounded
                        : Icons.check_rounded,
                  ),
                  label: Text(
                    isChecked
                        ? (_index == questions.length - 1
                              ? 'See result'
                              : 'Next question')
                        : 'Check answer',
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _result(BuildContext context, List<MultipleChoiceQuestion> questions) {
    final score = _checked
        .where((index) => _selected[index] == questions[index].answerIndex)
        .length;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Practice result'),
            pinned: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WavyCircularProgressIndicator(
                      value: questions.isEmpty ? 0 : score / questions.length,
                      size: 104,
                      semanticsLabel: '$score of ${questions.length} correct',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '$score of ${questions.length}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'answers correct',
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 22),
                    FilledButton.icon(
                      onPressed: () => setState(() {
                        _index = 0;
                        _selected.clear();
                        _checked.clear();
                      }),
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Practise again'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.index,
    required this.text,
    required this.selected,
    required this.checked,
    required this.correct,
    required this.onTap,
  });

  final int index;
  final String text;
  final bool selected;
  final bool checked;
  final bool correct;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = checked && correct
        ? colors.tertiaryContainer
        : checked && selected
        ? colors.errorContainer
        : selected
        ? colors.primaryContainer
        : colors.surfaceContainerLow;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: checked ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? colors.primary
                      : colors.surfaceContainerHighest,
                ),
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    color: selected
                        ? colors.onPrimary
                        : colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
              ),
              if (checked && correct)
                const Icon(Icons.check_circle_outline_rounded),
              if (checked && selected && !correct)
                const Icon(Icons.highlight_off_rounded),
              if (!checked && selected)
                const Icon(Icons.radio_button_checked_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
