import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../../domain/entities/study_entities.dart';
import '../cubit/study_tools_cubit.dart';
import '../widgets/flashcard_practice_widget.dart';
import '../widgets/mcq_practice_widget.dart';
import '../widgets/open_ended_practice_widget.dart';
import '../widgets/practice_completion_ad.dart';

class StudyPracticePage extends StatefulWidget {
  const StudyPracticePage({
    required this.materialId,
    required this.setId,
    required this.format,
    super.key,
  });
  final int materialId;
  final int setId;
  final String format;
  @override
  State<StudyPracticePage> createState() => _StudyPracticePageState();
}

class _StudyPracticePageState extends State<StudyPracticePage> {
  QuestionSet? _set;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final format = QuestionFormatApi.parse(widget.format);
    final cubit = context.read<StudyToolsCubit>();
    await cubit.loadMaterial(widget.materialId);
    await cubit.loadQuestions(format);
    if (!mounted) return;
    final sets = cubit.state.questionSets[format] ?? const [];
    QuestionSet? loadedSet;
    for (final set in sets) {
      if (set.id == widget.setId) {
        loadedSet = set;
        break;
      }
    }

    if (loadedSet != null && loadedSet.questions.isNotEmpty) {
      switch (format) {
        case QuestionFormat.mcq:
        case QuestionFormat.openEnded:
          await showPracticeInterstitialAd();
          break;
        case QuestionFormat.flashcard:
          break;
      }
    }
    if (!mounted) return;

    setState(() {
      _set = loadedSet;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WavyCircularProgressIndicator(
                size: 48,
                semanticsLabel: 'Loading practice questions',
              ),
              SizedBox(height: 16),
              Text('Opening your practice set…'),
            ],
          ),
        ),
      );
    }
    final set = _set;
    if (set == null) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar.large(title: Text('Practice'), pinned: true),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_off_outlined,
                        size: 44,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'This question set is not available offline yet.',
                        textAlign: TextAlign.center,
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
    if (set.questions.isEmpty) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(title: Text(set.format.label), pinned: true),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('This practice set has no questions.')),
            ),
          ],
        ),
      );
    }
    return switch (set.format) {
      QuestionFormat.flashcard => FlashcardPracticeWidget(
        key: ValueKey(set.id),
        set: set,
      ),
      QuestionFormat.mcq => McqPracticeWidget(set: set),
      QuestionFormat.openEnded => OpenEndedPracticeWidget(set: set),
    };
  }
}
