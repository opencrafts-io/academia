import 'package:courses/src/domain/entities/lecturer_entity.dart';
import 'package:courses/src/domain/usecases/course_usecases.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material3_indicators/material3_indicators.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class LecturerEditorSheet extends StatefulWidget {
  const LecturerEditorSheet({
    super.key,
    required this.courseId,
    this.lecturerId,
  });

  final String courseId;
  final String? lecturerId;

  @override
  State<LecturerEditorSheet> createState() => _LecturerEditorSheetState();
}

class _LecturerEditorSheetState extends State<LecturerEditorSheet> {
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
      return const _LecturerEditorLoading();
    }
    if (course == null) {
      return _LecturerEditorFailure(
        message: state.error ?? 'This course could not be loaded.',
      );
    }

    final lecturer = switch (widget.lecturerId) {
      null => null,
      final id =>
        course.lecturers.where((lecturer) => lecturer.id == id).firstOrNull,
    };
    if (widget.lecturerId != null && lecturer == null) {
      return const _LecturerEditorFailure(
        message: 'This lecturer is no longer available for the course.',
      );
    }
    return _LecturerForm(courseId: course.id, lecturer: lecturer);
  }
}

class _LecturerForm extends StatefulWidget {
  const _LecturerForm({required this.courseId, this.lecturer});

  final String courseId;
  final LecturerEntity? lecturer;

  @override
  State<_LecturerForm> createState() => _LecturerFormState();
}

class _LecturerFormState extends State<_LecturerForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _office;

  @override
  void initState() {
    super.initState();
    final lecturer = widget.lecturer;
    _name = TextEditingController(text: lecturer?.name);
    _email = TextEditingController(text: lecturer?.email);
    _phone = TextEditingController(text: lecturer?.phone);
    _office = TextEditingController(text: lecturer?.office);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _office.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    final editing = widget.lecturer != null;
    final colors = Theme.of(context).colorScheme;

    return SheetContentScaffold(
      bottomBarVisibility: const BottomBarVisibility.always(
        ignoreBottomInset: true,
      ),
      topBar: AppBar(
        title: Text(editing ? 'Edit lecturer' : 'Add lecturer'),
        leading: IconButton(
          tooltip: 'Close',
          onPressed: state.isLoading ? null : () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Lecturer form help',
            onPressed: _showHelp,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          editing
                              ? 'Keep in touch'
                              : 'Who teaches this course?',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'A name is all that is required. Add contact details only when they are useful.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _name,
                          enabled: !state.isLoading,
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: _inputStyle.copyWith(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            fontWeight: FontWeight.w800,
                          ),
                          decoration: _inputDecoration(
                            labelText: 'Lecturer name',
                            hintText: 'e.g. Dr. Ada Lovelace',
                            prefixIcon: const Icon(Icons.person_rounded),
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? 'Lecturer name is required'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _email,
                          enabled: !state.isLoading,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: _inputStyle,
                          decoration: _inputDecoration(
                            labelText: 'Email',
                            hintText: 'Optional',
                            prefixIcon: const Icon(Icons.email_rounded),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ResponsiveContactFields(
                          first: TextFormField(
                            controller: _phone,
                            enabled: !state.isLoading,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            style: _inputStyle,
                            decoration: _inputDecoration(
                              labelText: 'Phone',
                              hintText: 'Optional',
                              prefixIcon: const Icon(Icons.phone_rounded),
                            ),
                          ),
                          second: TextFormField(
                            controller: _office,
                            enabled: !state.isLoading,
                            textInputAction: TextInputAction.done,
                            style: _inputStyle,
                            decoration: _inputDecoration(
                              labelText: 'Office',
                              hintText: 'Optional',
                              prefixIcon: const Icon(Icons.place_rounded),
                            ),
                          ),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 180),
                          child: state.error == null
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors.errorContainer,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.error_outline_rounded,
                                        color: colors.onErrorContainer,
                                      ),
                                      title: Text(
                                        state.error!,
                                        style: TextStyle(
                                          color: colors.onErrorContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 104),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomBar: Container(
        padding: .all(16),
        constraints: const BoxConstraints(maxWidth: 640),
        child: FilledButton.icon(
          onPressed: state.isLoading ? null : _save,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
          icon: state.isLoading
              ? const SizedBox.square(
                  dimension: 20,
                  child: WavyCircularProgressIndicator(
                    size: 20,
                    amplitude: 1.5,
                    frequency: 8,
                  ),
                )
              : Icon(editing ? Icons.check_rounded : Icons.person_add_rounded),
          label: Text(editing ? 'Save changes' : 'Add lecturer'),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<CourseCubit>();
    final lecturer = widget.lecturer;
    if (lecturer == null) {
      await cubit.addLecturer(
        AddLecturerParams(
          courseId: widget.courseId,
          name: _name.text.trim(),
          email: _value(_email),
          phone: _value(_phone),
          office: _value(_office),
        ),
      );
    } else {
      await cubit.updateLecturer(
        lecturer.copyWith(
          name: _name.text.trim(),
          email: _value(_email),
          phone: _value(_phone),
          office: _value(_office),
        ),
      );
    }
    if (mounted && cubit.state.error == null) Navigator.pop(context, true);
  }

  String? _value(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  TextStyle get _inputStyle =>
      TextStyle(color: Theme.of(context).colorScheme.onSurface);

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required Widget prefixIcon,
  }) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.outline),
    );
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      labelStyle: TextStyle(color: colors.onSurfaceVariant),
      hintStyle: TextStyle(color: colors.onSurfaceVariant),
      prefixIconColor: colors.onSurfaceVariant,
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
      title: const Text('Lecturer details'),
      content: const Text(
        'A lecturer name is required. Contact details are optional.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it'),
        ),
      ],
    ),
  );
}

class _ResponsiveContactFields extends StatelessWidget {
  const _ResponsiveContactFields({required this.first, required this.second});

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

class _LecturerEditorLoading extends StatelessWidget {
  const _LecturerEditorLoading();

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(title: const Text('Lecturer')),
      body: Center(
        child: Semantics(
          label: 'Loading lecturer',
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

class _LecturerEditorFailure extends StatelessWidget {
  const _LecturerEditorFailure({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SheetContentScaffold(
      topBar: AppBar(title: const Text('Lecturer unavailable')),
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
