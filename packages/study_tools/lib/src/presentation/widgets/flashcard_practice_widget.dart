import 'package:flutter/material.dart';

import '../../domain/entities/study_entities.dart';

class FlashcardPracticeWidget extends StatefulWidget {
  const FlashcardPracticeWidget({required this.set, super.key});
  final QuestionSet set;

  @override
  State<FlashcardPracticeWidget> createState() =>
      _FlashcardPracticeWidgetState();
}

class _FlashcardPracticeWidgetState extends State<FlashcardPracticeWidget> {
  int _index = 0;
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final cards = widget.set.questions.cast<FlashcardQuestion>();
    final card = cards[_index];
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            title: const Text('Flashcards'),
            pinned: true,
            actions: [
              IconButton(
                tooltip: 'Restart cards',
                onPressed: _restart,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: (_index + 1) / cards.length,
                            minHeight: 8,
                            backgroundColor: colors.surfaceContainerHighest,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Chip(
                        avatar: const Icon(Icons.style_outlined, size: 16),
                        label: Text('${_index + 1} / ${cards.length}'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Semantics(
                      liveRegion: true,
                      label: _revealed ? 'Answer' : 'Question',
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 360),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0, .035),
                                end: Offset.zero,
                              ),
                            ),
                            child: child,
                          ),
                        ),
                        child: _FlashcardFace(
                          key: ValueKey('$_index-$_revealed'),
                          text: _revealed ? card.back : card.front,
                          revealed: _revealed,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: () => setState(() => _revealed = !_revealed),
                      icon: Icon(
                        _revealed
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      label: Text(_revealed ? 'Hide answer' : 'Reveal answer'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        tooltip: 'Previous card',
                        onPressed: _index == 0 ? null : () => _move(-1),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: _restart,
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text('Start over'),
                      ),
                      const Spacer(),
                      IconButton.filledTonal(
                        tooltip: 'Next card',
                        onPressed: _index == cards.length - 1
                            ? null
                            : () => _move(1),
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _move(int offset) => setState(() {
    _index += offset;
    _revealed = false;
  });

  void _restart() => setState(() {
    _index = 0;
    _revealed = false;
  });
}

class _FlashcardFace extends StatelessWidget {
  const _FlashcardFace({required this.text, required this.revealed, super.key});

  final String text;
  final bool revealed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final faceColor = revealed
        ? colors.tertiaryContainer
        : colors.primaryContainer;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: faceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: revealed
                  ? colors.onTertiaryContainer
                  : colors.onPrimaryContainer,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}
