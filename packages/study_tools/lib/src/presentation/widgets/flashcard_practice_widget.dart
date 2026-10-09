import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/study_entities.dart';
import 'practice_completion_ad.dart';

class FlashcardPracticeWidget extends StatefulWidget {
  const FlashcardPracticeWidget({required this.set, super.key});

  final QuestionSet set;

  @override
  State<FlashcardPracticeWidget> createState() =>
      _FlashcardPracticeWidgetState();
}

class _FlashcardPracticeWidgetState extends State<FlashcardPracticeWidget> {
  final PageController _pageController = PageController();
  final Set<int> _revealedCards = {};
  int _index = 0;
  bool _isComplete = false;
  bool _isFinishing = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = widget.set.questions.cast<FlashcardQuestion>();
    if (_isComplete) return _completionScreen(context);
    final revealed = _revealedCards.contains(_index);
    final background = _flashcardColor(_index, revealed: revealed);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: cards.length,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) => _FlashcardPage(
                key: ValueKey('${widget.set.id}-$index'),
                card: cards[index],
                index: index,
                revealed: _revealedCards.contains(index),
                onFlip: () => _flip(index),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _controlButton(
                            tooltip: 'Close flashcards',
                            icon: Icons.close_rounded,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Spacer(),
                          Text(
                            'FLASHCARDS',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                ),
                          ),
                          const Spacer(),
                          _controlButton(
                            tooltip: 'Restart flashcards',
                            icon: Icons.restart_alt_rounded,
                            onPressed: _restart,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: (_index + 1) / cards.length,
                          minHeight: 4,
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_index + 1} / ${cards.length}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        revealed
                            ? 'Double tap to see the question'
                            : 'Double tap to reveal the answer',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _controlButton(
                            tooltip: 'Previous card',
                            icon: Icons.keyboard_arrow_down_rounded,
                            onPressed: _index == 0
                                ? null
                                : () => _moveTo(_index - 1),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => _flip(_index),
                              style: FilledButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                backgroundColor: Colors.black.withValues(
                                  alpha: 0.24,
                                ),
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.32),
                                ),
                              ),
                              child: Text(
                                revealed ? 'Show question' : 'Show answer',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _controlButton(
                            tooltip: 'Next card',
                            icon: Icons.keyboard_arrow_up_rounded,
                            onPressed: _index == cards.length - 1
                                ? null
                                : () => _moveTo(_index + 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (_index == cards.length - 1)
                        FilledButton.tonalIcon(
                          onPressed: _isFinishing ? null : _finishSet,
                          icon: const Icon(Icons.check_rounded),
                          label: Text(
                            _isFinishing ? 'Finishing set…' : 'Finish set',
                          ),
                        )
                      else
                        Text(
                          'Swipe up for the next card',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.82),
                              ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlButton({
    required String tooltip,
    required IconData icon,
    required VoidCallback? onPressed,
  }) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    style: IconButton.styleFrom(
      minimumSize: const Size.square(48),
      backgroundColor: Colors.black.withValues(alpha: 0.24),
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.white.withValues(alpha: 0.4),
    ),
    icon: Icon(icon),
  );

  void _flip(int index) => setState(() {
    if (!_revealedCards.add(index)) _revealedCards.remove(index);
  });

  void _moveTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _restart() {
    setState(() {
      _index = 0;
      _isComplete = false;
      _isFinishing = false;
      _revealedCards.clear();
    });
    _pageController.jumpToPage(0);
  }

  Future<void> _finishSet() async {
    if (_isFinishing) return;
    setState(() => _isFinishing = true);
    await showPracticeInterstitialAd();
    if (!mounted) return;
    setState(() => _isComplete = true);
  }

  Widget _completionScreen(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    appBar: AppBar(title: const Text('Practice complete')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Set complete',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You reviewed ${widget.set.questions.length} flashcards.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _restart,
              icon: const Icon(Icons.restart_alt_rounded),
              label: const Text('Review again'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _FlashcardPage extends StatefulWidget {
  const _FlashcardPage({
    required this.card,
    required this.index,
    required this.revealed,
    required this.onFlip,
    super.key,
  });

  final FlashcardQuestion card;
  final int index;
  final bool revealed;
  final VoidCallback onFlip;

  @override
  State<_FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<_FlashcardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 460),
    value: widget.revealed ? 1 : 0,
  );

  @override
  void didUpdateWidget(covariant _FlashcardPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.revealed == oldWidget.revealed) return;
    if (widget.revealed) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionColor = _flashcardColor(widget.index);
    final answerColor = _flashcardColor(widget.index, revealed: true);
    final faceColor = widget.revealed ? answerColor : questionColor;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: widget.onFlip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 460),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [faceColor, Color.lerp(faceColor, Colors.black, 0.24)!],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -100,
              right: -100,
              child: _AccentOrb(size: 320),
            ),
            const Positioned(
              bottom: -130,
              left: -100,
              child: _AccentOrb(size: 360),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 96, 28, 132),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, _) {
                        final angle =
                            math.pi *
                            Curves.easeInOutCubic.transform(
                              _flipController.value,
                            );
                        final showingAnswer = angle >= math.pi / 2;
                        return Semantics(
                          liveRegion: true,
                          label: showingAnswer
                              ? 'Answer: ${widget.card.back}'
                              : 'Question: ${widget.card.front}',
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(angle),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(
                                showingAnswer ? math.pi : 0,
                              ),
                              child: SingleChildScrollView(
                                key: ValueKey(showingAnswer),
                                child: ExcludeSemantics(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        showingAnswer ? 'ANSWER' : 'QUESTION',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.86,
                                              ),
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 3,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        showingAnswer
                                            ? widget.card.back
                                            : widget.card.front,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontSize: math.min(
                                                44,
                                                math.max(
                                                  30,
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.085,
                                                ),
                                              ),
                                              fontWeight: FontWeight.w800,
                                              height: 1.18,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentOrb extends StatelessWidget {
  const _AccentOrb({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white.withValues(alpha: 0.14),
              Colors.white.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    ),
  );
}

Color _flashcardColor(int index, {bool revealed = false}) {
  // Golden-angle spacing keeps neighbouring questions visually distinct.
  final hue = (250 + index * 137.508 + (revealed ? 25 : 0)) % 360;
  return HSLColor.fromAHSL(1, hue, 0.78, revealed ? 0.22 : 0.25).toColor();
}
