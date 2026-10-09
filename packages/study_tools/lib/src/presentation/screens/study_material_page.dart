import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/study_entities.dart';
import '../cubit/podcast_cubit.dart';
import '../cubit/study_tools_cubit.dart';
import '../cubit/study_load_state.dart';
import '../widgets/podcast_now_playing_bar.dart';
import '../widgets/question_set_section.dart';
import '../widgets/study_delete_confirmation_sheet.dart';
import '../widgets/study_progress_widgets.dart';
import '../widgets/study_material_sections.dart';
import '../widgets/study_podcast_section.dart';
import '../widgets/study_tools_feedback.dart';
import '../widgets/study_tools_sheet.dart';

class StudyMaterialPage extends StatefulWidget {
  const StudyMaterialPage({required this.materialId, super.key});
  final int materialId;

  @override
  State<StudyMaterialPage> createState() => _StudyMaterialPageState();
}

class _StudyMaterialPageState extends State<StudyMaterialPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<StudyToolsCubit>().loadMaterial(widget.materialId));
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<StudyToolsCubit, StudyToolsState>(
    listenWhen: (previous, current) =>
        previous.error != current.error && current.error != null,
    listener: (context, state) {
      showStudyToolsSnackBar(context, state.error!, isError: true);
    },
    child: BlocBuilder<StudyToolsCubit, StudyToolsState>(
      builder: (context, state) {
        final material = state.selectedMaterial;
        final isLoading = state.status.when(
          initial: () => false,
          loading: () => true,
          loaded: () => false,
          failure: (_, __) => false,
        );
        if (isLoading && material == null) {
          return Scaffold(
            body: _withPodcastBar(
              context,
              const StudyToolsLoadingView(message: 'Opening your material…'),
            ),
          );
        }
        if (material == null) {
          return Scaffold(
            body: _withPodcastBar(
              context,
              CustomScrollView(
                slivers: [
                  _appBar(),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: StudyToolsFailureView(
                      message: state.error ?? 'Material unavailable.',
                      onRetry: () => context
                          .read<StudyToolsCubit>()
                          .loadMaterial(widget.materialId),
                      onUpgrade: state.errorCode == 'entitlement_required',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final hasJob = state.jobs.containsKey(material.id);
        final hasPodcastJob =
            state.jobOutputs[material.id]?.contains('podcast') ??
            state.isGeneratingPodcast;
        final jobOutputs = state.jobOutputs[material.id];
        final progressTitle = jobOutputs == null || jobOutputs.isEmpty
            ? 'Generation is in progress'
            : jobOutputs.contains('podcast')
            ? 'Preparing your podcast'
            : 'Preparing your questions';
        final podcastProgressMessage = state.isLoadingPodcast
            ? 'Checking for an existing episode…'
            : !hasJob
            ? 'Creating your podcast…'
            : hasPodcastJob
            ? 'Creating your podcast…'
            : jobOutputs == null || jobOutputs.isEmpty
            ? 'Generation is in progress…'
            : 'Another study output is being generated for this material.';
        return Scaffold(
          body: _withPodcastBar(
            context,
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _appBar(),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  sliver: SliverList.list(
                    children: [
                      StudyMaterialHeaderCard(material: material),
                      const SizedBox(height: 28),
                      StudyPodcastSection(
                        material: material,
                        podcast: state.podcast,
                        isGenerating: state.isGeneratingPodcast,
                        isLoading: state.isLoadingPodcast,
                        hasJob: hasJob,
                        progressMessage: podcastProgressMessage,
                        onGenerate: () =>
                            context.read<StudyToolsCubit>().generatePodcast(),
                      ),
                      const SizedBox(height: 32),
                      const StudySectionHeading(
                        title: 'Make it stick',
                        subtitle:
                            'Choose a format to create a new practice set.',
                      ),
                      const SizedBox(height: 14),
                      StudyGenerationOptions(
                        busy:
                            state.loadingFormat != null ||
                            hasJob ||
                            state.generationBlocked,
                        loadingFormat: state.loadingFormat,
                        onGenerate: (format) =>
                            context.read<StudyToolsCubit>().generate(format),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutCubic,
                        child: hasJob
                            ? Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: StudyGenerationProgressCard(
                                  title: progressTitle,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (state.error != null) ...[
                        const SizedBox(height: 12),
                        StudyToolsInlineError(
                          message: state.error!,
                          onRetry: state.errorCode == 'entitlement_unavailable'
                              ? () => context
                                    .read<StudyToolsCubit>()
                                    .loadMaterial(material.id)
                              : null,
                          onUpgrade: state.errorCode == 'entitlement_required',
                        ),
                      ],
                      if (state.errorCode == 'job_already_running') ...[
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _refreshQuestions,
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Refresh question sets'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                      const StudySectionHeading(
                        title: 'Your question sets',
                        subtitle:
                            'Reopen any set whenever you want to practise.',
                      ),
                      const SizedBox(height: 8),
                      for (final format in QuestionFormat.values)
                        QuestionSetSection(noteId: material.id, format: format),
                      const SizedBox(height: 32),
                      OutlinedButton.icon(
                        onPressed: () => _delete(context, material.id),
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: const Text('Delete material and study content'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                          minimumSize: const Size.fromHeight(52),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _withPodcastBar(BuildContext context, Widget child) =>
      PodcastNowPlayingOverlay(
        handler: context.read<PodcastCubit>().audioHandler,
        bottomInset: MediaQuery.viewPaddingOf(context).bottom,
        child: child,
      );

  SliverAppBar _appBar() => SliverAppBar.large(
    title: const Text('Material'),
    pinned: true,
    actions: [
      IconButton(
        tooltip: 'Refresh material',
        onPressed: () =>
            context.read<StudyToolsCubit>().loadMaterial(widget.materialId),
        icon: const Icon(Icons.refresh_rounded),
      ),
      const SizedBox(width: 8),
    ],
  );

  Future<void> _refreshQuestions() async {
    final cubit = context.read<StudyToolsCubit>();
    await cubit.loadMaterial(widget.materialId);
    for (final format in QuestionFormat.values) {
      await cubit.loadQuestions(format);
    }
  }

  Future<void> _delete(BuildContext context, int id) async {
    final confirmed = await showStudyToolsSheet<bool>(
      context: context,
      child: const StudyDeleteConfirmationSheet(),
    );
    if (confirmed != true || !context.mounted) return;
    final deleted = await context.read<StudyToolsCubit>().deleteMaterial(id);
    if (deleted && context.mounted) Navigator.pop(context, true);
  }
}
