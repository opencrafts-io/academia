import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/study_entities.dart';
import '../cubit/study_tools_cubit.dart';
import '../cubit/podcast_cubit.dart';
import '../routes/study_tools_routes.dart';
import '../study_tools_host.dart';
import '../widgets/study_course_filter_chips.dart';
import '../widgets/study_library_heading.dart';
import '../widgets/study_material_card.dart';
import '../widgets/study_progress_widgets.dart';
import '../widgets/study_tools_feedback.dart';
import '../widgets/study_tools_sheet.dart';
import '../widgets/study_upload_sheet.dart';
import '../widgets/podcast_download_card.dart';
import '../widgets/podcast_now_playing_bar.dart';

class StudyToolsPage extends StatefulWidget {
  const StudyToolsPage({
    this.courseId,
    this.courseLabel,
    this.courseLocalId,
    super.key,
  });

  final String? courseId;
  final String? courseLabel;
  final String? courseLocalId;

  @override
  State<StudyToolsPage> createState() => _StudyToolsPageState();
}

class _StudyToolsPageState extends State<StudyToolsPage> {
  List<StudyCourseOption> _courses = const [];
  String? _filter;
  bool _showDownloads = false;

  @override
  void initState() {
    super.initState();
    _filter =
        widget.courseId ??
        (widget.courseLocalId == null ? null : 'local:${widget.courseLocalId}');
    unawaited(_loadMaterials());
    unawaited(_loadCourses());
    unawaited(context.read<PodcastCubit>().loadDownloads());
  }

  Future<void> _loadMaterials({bool force = false}) =>
      context.read<StudyToolsCubit>().loadMaterials(force: force);

  Future<void> _loadCourses() async {
    final loader = StudyToolsHost.loadCourses;
    if (loader == null) return;
    final courses = await loader();
    if (mounted) setState(() => _courses = courses);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: BlocSelector<PodcastCubit, PodcastCubitState, bool>(
      selector: (state) => state.currentMediaItem?.extras?['noteId'] is int,
      builder: (context, hasPodcast) => Padding(
        padding: EdgeInsets.only(
          bottom: hasPodcast && MediaQuery.viewInsetsOf(context).bottom == 0
              ? 80
              : 0,
        ),
        child: FloatingActionButton.extended(
          onPressed: _pickMaterial,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Upload'),
        ),
      ),
    ),
    body: PodcastNowPlayingOverlay(
      handler: context.read<PodcastCubit>().audioHandler,
      bottomInset: MediaQuery.viewPaddingOf(context).bottom,
      child: BlocListener<StudyToolsCubit, StudyToolsState>(
        listenWhen: (previous, current) =>
            previous.error != current.error && current.error != null,
        listener: (context, state) {
          showStudyToolsSnackBar(
            context,
            state.error!,
            isError: state.status == StudyLoadStatus.failure,
          );
        },
        child: BlocBuilder<StudyToolsCubit, StudyToolsState>(
          builder: (context, state) => _buildLibrary(state),
        ),
      ),
    ),
  );

  Widget _buildLibrary(StudyToolsState state) {
    final podcastState = context.watch<PodcastCubit>().state;
    if (_showDownloads) return _buildDownloads(podcastState);
    if (state.status == StudyLoadStatus.loading && state.materials.isEmpty) {
      return CustomScrollView(
        slivers: [
          _appBar(),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: StudyToolsLoadingView(message: 'Finding your materials…'),
          ),
        ],
      );
    }
    if (state.status == StudyLoadStatus.failure && state.materials.isEmpty) {
      return CustomScrollView(
        slivers: [
          _appBar(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: StudyToolsFailureView(
              message: state.error ?? 'Your materials could not be loaded.',
              onRetry: () => _loadMaterials(force: true),
              onUpgrade: state.errorCode == 'entitlement_required',
            ),
          ),
        ],
      );
    }

    final materials = state.materials.where(_matchesFilter).toList();
    return RefreshIndicator.adaptive(
      onRefresh: () => _loadMaterials(force: true),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _appBar(),
          SliverToBoxAdapter(
            child: _libraryModeSelector(podcastState.downloads.length),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverToBoxAdapter(
              child: StudyLibraryHeading(
                count: materials.length,
                courseLabel: widget.courseLabel,
              ),
            ),
          ),
          if (widget.courseId == null && _courses.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  bottom: 12,
                ),
                child: StudyCourseFilterChips(
                  courses: _courses,
                  selected: _filter,
                  onSelected: (value) => setState(() => _filter = value),
                ),
              ),
            ),
          if (state.error != null && state.materials.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: StudyToolsInlineError(
                  message: state.error!,
                  onRetry: state.errorCode == 'entitlement_unavailable'
                      ? () => _loadMaterials(force: true)
                      : null,
                  onUpgrade: state.errorCode == 'entitlement_required',
                ),
              ),
            ),
          if (materials.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOutCubic,
                child: StudyToolsEmptyState(
                  key: ValueKey(_filter),
                  courseId: _filter ?? widget.courseId,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 112),
              sliver: SliverLayoutBuilder(
                builder: (context, constraints) => SliverGrid.builder(
                  itemCount: materials.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 330,
                    mainAxisExtent: constraints.crossAxisExtent < 370
                        ? 222
                        : 230,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return TweenAnimationBuilder<double>(
                      key: ValueKey(material.id),
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 320 + (index % 5) * 35),
                      curve: Curves.easeOutCubic,
                      builder: (context, progress, child) => Opacity(
                        opacity: progress,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - progress)),
                          child: child,
                        ),
                      ),
                      child: StudyMaterialCard(
                        material: material,
                        onTap: () => _openMaterial(material.id),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _libraryModeSelector(int downloadCount) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
    child: SegmentedButton<bool>(
      segments: [
        const ButtonSegment(
          value: false,
          icon: Icon(Icons.folder_copy_outlined),
          label: Text('Materials'),
        ),
        ButtonSegment(
          value: true,
          icon: const Icon(Icons.download_for_offline_outlined),
          label: Text('Downloads · $downloadCount'),
        ),
      ],
      selected: {_showDownloads},
      onSelectionChanged: (selected) =>
          setState(() => _showDownloads = selected.single),
      showSelectedIcon: false,
    ),
  );

  Widget _buildDownloads(PodcastCubitState state) => CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: [
      _appBar(),
      SliverToBoxAdapter(child: _libraryModeSelector(state.downloads.length)),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
        sliver: SliverToBoxAdapter(
          child: StudyLibraryHeading(
            count: state.downloads.length,
            courseLabel: 'Offline episodes',
          ),
        ),
      ),
      if (state.isLoadingDownloads)
        const SliverFillRemaining(
          hasScrollBody: false,
          child: StudyToolsLoadingView(message: 'Finding saved episodes…'),
        )
      else if (state.downloads.isEmpty)
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.download_for_offline_outlined, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'No episodes saved yet',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Save a generated podcast while online to listen without a connection.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
      else
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) => SliverGrid.builder(
              itemCount: state.downloads.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 330,
                mainAxisExtent: 220,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final episode = state.downloads[index];
                return PodcastDownloadCard(
                  episode: episode,
                  onRemove: () =>
                      context.read<PodcastCubit>().removeDownload(episode),
                );
              },
            ),
          ),
        ),
    ],
  );

  SliverAppBar _appBar() => SliverAppBar.large(
    title: Text(widget.courseLabel == null ? 'Study Tools' : 'Materials'),
    pinned: true,
    actions: [
      IconButton(
        tooltip: 'Refresh materials',
        onPressed: () => _loadMaterials(force: true),
        icon: const Icon(Icons.refresh_rounded),
      ),
      const SizedBox(width: 8),
    ],
  );

  bool _matchesFilter(StudyMaterial material) {
    if (_filter == StudyCourseFilterChips.unassignedFilter) {
      return material.courseId == null && material.courseLabel.trim().isEmpty;
    }
    if (_filter == null) return true;
    if (_filter!.startsWith('local:')) {
      return material.courseId == null &&
          material.courseLabel == widget.courseLabel;
    }
    return material.courseId == _filter;
  }

  Future<void> _pickMaterial() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: studyUploadExtensions.toList(),
      withData: true,
    );
    if (result == null || result.files.isEmpty || !mounted) return;
    final file = result.files.single;
    final validation = validateStudyUpload(file.name, file.size);
    if (validation != null) {
      showStudyToolsSnackBar(context, validation, isError: true);
      return;
    }

    final cubit = context.read<StudyToolsCubit>();
    final uploaded = await showStudyToolsSheet<bool>(
      context: context,
      child: StudyUploadSheet(
        file: file,
        courses: _courses,
        cubit: cubit,
        preselectedCourseId: widget.courseId,
        preselectedCourseOptionId:
            widget.courseId ??
            (widget.courseLocalId == null
                ? null
                : 'local:${widget.courseLocalId}'),
        preselectedCourseLabel: widget.courseLabel,
      ),
    );
    if (uploaded == true && mounted) await _loadMaterials(force: true);
  }

  Future<void> _openMaterial(int id) async {
    final deleted = await StudyMaterialRoute(materialId: id)
        .push<bool>(context);
    if (deleted == true && mounted) await _loadMaterials(force: true);
  }
}
