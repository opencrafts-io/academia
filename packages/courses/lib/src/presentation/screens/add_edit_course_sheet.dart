import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/domain/institution_lookup.dart';
import 'package:courses/src/domain/usecases/course_usecases.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material3_indicators/material3_indicators.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AddEditCourseSheet extends StatefulWidget {
  const AddEditCourseSheet({super.key, this.course});

  final CourseEntity? course;

  @override
  State<AddEditCourseSheet> createState() => _AddEditCourseSheetState();
}

class _AddEditCourseSheetState extends State<AddEditCourseSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _institutionController;
  late final TextEditingController _titleController;
  late final TextEditingController _codeController;
  late final TextEditingController _termLabelController;
  late final TextEditingController _academicYearController;
  DateTime? _termStartDate;
  DateTime? _termEndDate;
  List<InstitutionSummary> _institutions = [];
  InstitutionSummary? _institution;
  bool _searching = false;
  String? _institutionError;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    final course = widget.course;
    _institution = course == null
        ? null
        : InstitutionSummary(
            id: course.institutionId,
            name: 'Institution #${course.institutionId}',
          );
    _institutionController = TextEditingController(text: _institution?.name);
    _titleController = TextEditingController(text: course?.title);
    _codeController = TextEditingController(text: course?.code);
    _termLabelController = TextEditingController(text: course?.termLabel);
    _academicYearController = TextEditingController(text: course?.academicYear);
    _termStartDate = course?.termStartDate;
    _termEndDate = course?.termEndDate;
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _titleController.dispose();
    _codeController.dispose();
    _termLabelController.dispose();
    _academicYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.course != null;
    final state = context.watch<CourseCubit>().state;
    final colors = Theme.of(context).colorScheme;

    return SheetContentScaffold(
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      topBar: AppBar(
        title: Text(editing ? 'Edit course' : 'Add a course'),
        leading: IconButton(
          tooltip: 'Close',
          onPressed: state.isLoading ? null : () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Course form help',
            onPressed: _showHelp,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SizedBox(
              height: constraints.maxHeight,
              child: Form(
                key: _formKey,
                child: Stepper(
                  type: constraints.maxWidth < 600
                      ? StepperType.vertical
                      : StepperType.horizontal,
                  currentStep: _currentStep,
                  onStepTapped: _setStep,
                  controlsBuilder: (_, _) => const SizedBox.shrink(),
                  steps: [
                    Step(
                      title: const Text('Course'),
                      state: _currentStep == 0 ? .indexed : .complete,
                      content: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              editing
                                  ? 'The essentials'
                                  : 'What are you studying?',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Name the course and connect it to your institution.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _institutionController,
                              enabled: !editing && !state.isLoading,
                              textInputAction: TextInputAction.next,
                              style: _inputStyle,
                              decoration: _inputDecoration(
                                labelText: 'Institution',
                                hintText: 'Search your institution',
                                prefixIcon: const Icon(
                                  Icons.account_balance_rounded,
                                ),
                                suffixIcon: _searching
                                    ? const Padding(
                                        padding: EdgeInsets.all(14),
                                        child: SizedBox.square(
                                          dimension: 20,
                                          child: WavyCircularProgressIndicator(
                                            size: 20,
                                            amplitude: 1.5,
                                            frequency: 8,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              onChanged: _onInstitutionChanged,
                              validator: (_) => _institution == null
                                  ? 'Select an institution'
                                  : null,
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              child:
                                  _institutions.isEmpty &&
                                      _institutionError == null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors.secondaryContainer,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: _institutionError != null
                                            ? ListTile(
                                                leading: Icon(
                                                  Icons.search_off_rounded,
                                                  color: colors
                                                      .onSecondaryContainer,
                                                ),
                                                title: Text(
                                                  _institutionError!,
                                                  style: TextStyle(
                                                    color: colors
                                                        .onSecondaryContainer,
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  for (final institution
                                                      in _institutions)
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons
                                                            .account_balance_rounded,
                                                        color: colors
                                                            .onSecondaryContainer,
                                                      ),
                                                      title: Text(
                                                        institution.name,
                                                        style: TextStyle(
                                                          color: colors
                                                              .onSecondaryContainer,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          _selectInstitution(
                                                            institution,
                                                          ),
                                                    ),
                                                ],
                                              ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _titleController,
                              enabled: !state.isLoading,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: _inputStyle.copyWith(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.fontSize,
                                fontWeight: FontWeight.w800,
                              ),
                              decoration: _inputDecoration(
                                labelText: 'Course title',
                                hintText: 'e.g. Organic chemistry',
                                prefixIcon: const Icon(Icons.menu_book_rounded),
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Course title is required'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            _field(
                              controller: _codeController,
                              label: 'Course code',
                              hint: 'e.g. CHEM 204',
                              icon: Icons.tag_rounded,
                              enabled: !state.isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Step(
                      title: const Text('Term'),
                      isActive: _currentStep == 1,
                      content: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Make it useful later',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Term information is optional, but makes this course easier to find and understand.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 24),
                            _ResponsiveFields(
                              first: _field(
                                controller: _termLabelController,
                                label: 'Term label',
                                hint: 'e.g. Trimester 2',
                                icon: Icons.bookmark_added_rounded,
                                enabled: !state.isLoading,
                              ),
                              second: _field(
                                controller: _academicYearController,
                                label: 'Academic year',
                                hint: 'e.g. 2025/2026',
                                icon: Icons.date_range_rounded,
                                enabled: !state.isLoading,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _TermDatesField(
                              startDate: _termStartDate,
                              endDate: _termEndDate,
                              enabled: !state.isLoading,
                              onSelectStart: () => _pickDate(start: true),
                              onSelectEnd: () => _pickDate(start: false),
                              onClear:
                                  _termStartDate == null && _termEndDate == null
                                  ? null
                                  : _clearDates,
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              child: state.error == null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: _FormError(message: state.error!),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomBar: Container(
        padding: .all(16),
        constraints: const BoxConstraints(maxWidth: 640),
        child: Row(
          children: [
            if (_currentStep > 0)
              TextButton.icon(
                onPressed: state.isLoading ? null : () => _setStep(0),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back'),
              ),
            if (_currentStep > 0) const SizedBox(width: 8),
            Expanded(
              child: FilledButton.icon(
                onPressed: state.isLoading
                    ? null
                    : _currentStep == 0
                    ? _nextStep
                    : _submit,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                icon: state.isLoading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: WavyCircularProgressIndicator(
                          size: 20,
                          amplitude: 1.5,
                          frequency: 8,
                        ),
                      )
                    : Icon(
                        _currentStep == 0
                            ? Icons.arrow_forward_rounded
                            : editing
                            ? Icons.check_rounded
                            : Icons.add_rounded,
                      ),
                label: Text(
                  _currentStep == 0
                      ? 'Continue'
                      : editing
                      ? 'Save changes'
                      : 'Create course',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool enabled,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      style: _inputStyle,
      decoration: _inputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    );
  }

  TextStyle get _inputStyle =>
      TextStyle(color: Theme.of(context).colorScheme.onSurface);

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: .circular(12),
      borderSide: BorderSide(color: colors.outline),
    );
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(color: colors.onSurfaceVariant),
      hintStyle: TextStyle(color: colors.onSurfaceVariant),
      prefixIconColor: colors.onSurfaceVariant,
      suffixIconColor: colors.onSurfaceVariant,
      border: border,
      enabledBorder: border,
      disabledBorder: border.copyWith(
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
    );
  }

  Future<void> _showHelp() => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.info_outline_rounded),
      title: const Text('Course details'),
      content: const Text(
        'Choose an institution and add a course title. Everything else is optional.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it'),
        ),
      ],
    ),
  );

  void _setStep(int step) {
    if (step > _currentStep && !_formKey.currentState!.validate()) return;
    setState(() => _currentStep = step);
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) _setStep(1);
  }

  void _onInstitutionChanged(String query) {
    setState(() {
      _institution = null;
      _institutionError = null;
    });
    _searchInstitutions(query);
  }

  void _selectInstitution(InstitutionSummary institution) {
    setState(() {
      _institution = institution;
      _institutionController.text = institution.name;
      _institutions = [];
      _institutionError = null;
    });
  }

  Future<void> _searchInstitutions(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _institutions = []);
      return;
    }
    setState(() => _searching = true);
    try {
      final institutions = await context.read<CourseCubit>().searchInstitutions(
        query,
      );
      if (mounted) setState(() => _institutions = institutions);
    } on Object {
      if (mounted) {
        setState(
          () => _institutionError = 'Institution search is unavailable.',
        );
      }
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  Future<void> _pickDate({required bool start}) async {
    final firstDate = start ? DateTime(2000) : _termStartDate ?? DateTime(2000);
    final lastDate = start ? _termEndDate ?? DateTime(2100) : DateTime(2100);
    final selected = await showDatePicker(
      context: context,
      initialDate: _initialDate(
        start ? _termStartDate : _termEndDate,
        firstDate,
        lastDate,
      ),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (start) {
        _termStartDate = selected;
      } else {
        _termEndDate = selected;
      }
    });
  }

  DateTime _initialDate(
    DateTime? candidate,
    DateTime firstDate,
    DateTime lastDate,
  ) {
    final date = candidate ?? DateTime.now();
    if (date.isBefore(firstDate)) return firstDate;
    if (date.isAfter(lastDate)) return lastDate;
    return date;
  }

  void _clearDates() {
    setState(() {
      _termStartDate = null;
      _termEndDate = null;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<CourseCubit>();
    final course = widget.course;
    if (course == null) {
      await cubit.create(
        CreateCourseParams(
          institutionId: _institution!.id,
          title: _titleController.text.trim(),
          code: _optional(_codeController),
          termLabel: _optional(_termLabelController),
          academicYear: _optional(_academicYearController),
          termStartDate: _termStartDate,
          termEndDate: _termEndDate,
        ),
      );
    } else {
      await cubit.update(
        course.copyWith(
          title: _titleController.text.trim(),
          code: _optional(_codeController),
          termLabel: _optional(_termLabelController),
          academicYear: _optional(_academicYearController),
          termStartDate: _termStartDate,
          termEndDate: _termEndDate,
        ),
      );
    }
    if (mounted && cubit.state.error == null) Navigator.pop(context, true);
  }

  String? _optional(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }
}

class EditCourseSheet extends StatefulWidget {
  const EditCourseSheet({super.key, required this.courseId});

  final String courseId;

  @override
  State<EditCourseSheet> createState() => _EditCourseSheetState();
}

class _EditCourseSheetState extends State<EditCourseSheet> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    final course = state.selectedCourse;
    if (state.isLoading && course == null) {
      return const _EditorLoading(title: 'Edit course');
    }
    if (course == null) {
      return _EditorFailure(
        title: 'Course unavailable',
        message: state.error ?? 'This course could not be loaded.',
      );
    }
    return AddEditCourseSheet(course: course);
  }
}

class _ResponsiveFields extends StatelessWidget {
  const _ResponsiveFields({required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 560) {
          return Column(children: [first, const SizedBox(height: 12), second]);
        }
        return Row(
          children: [
            Expanded(child: first),
            const SizedBox(width: 12),
            Expanded(child: second),
          ],
        );
      },
    );
  }
}

class _TermDatesField extends StatelessWidget {
  const _TermDatesField({
    required this.startDate,
    required this.endDate,
    required this.enabled,
    required this.onSelectStart,
    required this.onSelectEnd,
    this.onClear,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final bool enabled;
  final VoidCallback onSelectStart;
  final VoidCallback onSelectEnd;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.event_available_rounded, color: colors.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Term dates',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (onClear != null)
              IconButton(
                tooltip: 'Clear term dates',
                onPressed: enabled ? onClear : null,
                icon: const Icon(Icons.close_rounded),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _ResponsiveFields(
          first: _DateSelectButton(
            label: 'Starts',
            date: startDate,
            enabled: enabled,
            onPressed: onSelectStart,
          ),
          second: _DateSelectButton(
            label: 'Ends',
            date: endDate,
            enabled: enabled,
            onPressed: onSelectEnd,
          ),
        ),
      ],
    );
  }
}

class _DateSelectButton extends StatelessWidget {
  const _DateSelectButton({
    required this.label,
    required this.date,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final DateTime? date;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final value = date == null
        ? 'Select date'
        : DateFormat.yMMMd(locale).format(date!);
    return SizedBox(
      height: 60,
      child: OutlinedButton.icon(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: colors.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        icon: const Icon(Icons.calendar_month_rounded),
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormError extends StatelessWidget {
  const _FormError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          Icons.error_outline_rounded,
          color: colors.onErrorContainer,
        ),
        title: Text(message, style: TextStyle(color: colors.onErrorContainer)),
      ),
    );
  }
}

class _EditorLoading extends StatelessWidget {
  const _EditorLoading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(title: Text(title)),
      body: Center(
        child: Semantics(
          label: 'Loading course',
          child: WavyCircularProgressIndicator(
            size: 56,
            amplitude: 3,
            frequency: 8,
          ),
        ),
      ),
    );
  }
}

class _EditorFailure extends StatelessWidget {
  const _EditorFailure({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SheetContentScaffold(
      topBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: colors.errorContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onErrorContainer),
            ),
          ),
        ),
      ),
    );
  }
}
