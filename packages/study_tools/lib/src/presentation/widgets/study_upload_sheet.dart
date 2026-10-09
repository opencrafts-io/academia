import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../../domain/entities/study_entities.dart';
import '../cubit/study_tools_cubit.dart';
import 'study_tools_feedback.dart';

class StudyUploadSheet extends StatefulWidget {
  const StudyUploadSheet({
    super.key,
    required this.file,
    required this.courses,
    required this.cubit,
    this.preselectedCourseId,
    this.preselectedCourseOptionId,
    this.preselectedCourseLabel,
  });
  final PlatformFile file;
  final List<StudyCourseOption> courses;
  final StudyToolsCubit cubit;
  final String? preselectedCourseId;
  final String? preselectedCourseOptionId;
  final String? preselectedCourseLabel;

  @override
  State<StudyUploadSheet> createState() => _StudyUploadSheetState();
}

class _StudyUploadSheetState extends State<StudyUploadSheet> {
  late String? _courseId =
      widget.preselectedCourseOptionId ?? widget.preselectedCourseId;
  late final _label = TextEditingController(
    text: widget.preselectedCourseLabel,
  );
  bool _submitting = false;

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<StudyToolsCubit, StudyToolsState>(
    bloc: widget.cubit,
    listenWhen: (previous, current) =>
        previous.error != current.error && current.error != null,
    listener: (context, state) =>
        showStudyToolsSnackBar(context, state.error!, isError: true),
    child: SheetContentScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.viewInsetsOf(context).bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload material',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.description_outlined),
                title: Text(widget.file.name),
                subtitle: Text(studyToolsFileSize(widget.file.size)),
              ),
              if (widget.courses.isNotEmpty)
                DropdownButtonFormField<String?>(
                  initialValue: _courseId,
                  decoration: const InputDecoration(
                    labelText: 'Link to a course (optional)',
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('No course'),
                    ),
                    for (final course in widget.courses)
                      DropdownMenuItem(
                        value: course.id,
                        child: Text(course.title),
                      ),
                  ],
                  onChanged: _submitting
                      ? null
                      : (value) => setState(() => _courseId = value),
                )
              else
                TextField(
                  controller: _label,
                  enabled: !_submitting,
                  decoration: const InputDecoration(
                    labelText: 'Course label (optional)',
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                'PDF, DOCX, PPTX, XLSX, or XLS · up to 20 MB',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 18),
              BlocBuilder<StudyToolsCubit, StudyToolsState>(
                bloc: widget.cubit,
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.error != null)
                      StudyToolsInlineError(
                        message: state.error!,
                        onUpgrade: state.errorCode == 'entitlement_required',
                      ),
                    FilledButton.icon(
                      onPressed: _submitting || state.isUploading
                          ? null
                          : _submit,
                      icon: _submitting || state.isUploading
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.upload_outlined),
                      label: const Text('Upload'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final selectedCourse = widget.courses
        .where((course) => course.id == _courseId)
        .firstOrNull;
    await widget.cubit.upload(
      file: widget.file,
      courseId: selectedCourse?.professorId,
      courseLabel:
          selectedCourse?.title ?? (_courseId == null ? _label.text : null),
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (widget.cubit.state.selectedMaterial != null &&
        widget.cubit.state.error == null) {
      Navigator.pop(context, true);
    }
  }
}
