import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/domain/entities/schedule_entry_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/screens/course_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddEditScheduleEntrySheet extends StatefulWidget {
  const AddEditScheduleEntrySheet({
    super.key,
    required this.course,
    this.entry,
  });

  final CourseEntity course;
  final ScheduleEntryEntity? entry;

  @override
  State<AddEditScheduleEntrySheet> createState() =>
      _AddEditScheduleEntrySheetState();
}

class _AddEditScheduleEntrySheetState extends State<AddEditScheduleEntrySheet> {
  static const _days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _venue;
  late final TextEditingController _campus;
  late final TextEditingController _section;
  late final TextEditingController _label;
  late String _day;
  late TimeOfDay _start;
  late TimeOfDay _end;
  late String? _color;
  late bool _recurring;
  DateTime? _specificDate;

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    _venue = TextEditingController(text: entry?.venue);
    _campus = TextEditingController(text: entry?.campus);
    _section = TextEditingController(text: entry?.section);
    _label = TextEditingController(text: entry?.label);
    _day = entry?.dayOfWeek ?? 'monday';
    _start = _parseTime(entry?.startTime ?? '09:00');
    _end = _parseTime(entry?.endTime ?? '10:00');
    _color = entry?.color ?? widget.course.color;
    _recurring = entry?.isRecurring ?? true;
    _specificDate = entry?.specificDate;
  }

  @override
  void dispose() {
    _venue.dispose();
    _campus.dispose();
    _section.dispose();
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    final editing = widget.entry != null;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          12,
          24,
          MediaQuery.viewInsetsOf(context).bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  editing ? 'Edit schedule entry' : 'Add schedule entry',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _day,
                  decoration: const InputDecoration(
                    labelText: 'Day of the week',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final day in _days)
                      DropdownMenuItem(value: day, child: Text(_title(day))),
                  ],
                  onChanged: state.isScheduleLoading
                      ? null
                      : (value) => setState(() => _day = value ?? _day),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _TimeField(
                        label: 'Starts',
                        value: _start,
                        enabled: !state.isScheduleLoading,
                        onTap: () => _pickTime(start: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TimeField(
                        label: 'Ends',
                        value: _end,
                        enabled: !state.isScheduleLoading,
                        onTap: () => _pickTime(start: false),
                      ),
                    ),
                  ],
                ),
                if (_minutes(_start) >= _minutes(_end))
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'End time must be after start time.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                _textField(_label, 'Label', 'e.g. Lecture'),
                const SizedBox(height: 12),
                _textField(_venue, 'Venue', 'e.g. Science block, room 4'),
                const SizedBox(height: 12),
                _textField(_campus, 'Campus', 'Optional campus'),
                const SizedBox(height: 12),
                _textField(_section, 'Section', 'Optional section'),
                const SizedBox(height: 18),
                Text(
                  'Entry color',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                CourseColorPicker(
                  value: _color,
                  defaultLabel: 'Course color',
                  onChanged: (value) =>
                      setState(() => _color = value ?? widget.course.color),
                ),
                const SizedBox(height: 12),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Repeats every week'),
                  value: _recurring,
                  onChanged: state.isScheduleLoading
                      ? null
                      : (value) => setState(() => _recurring = value),
                ),
                if (!_recurring)
                  OutlinedButton.icon(
                    onPressed: state.isScheduleLoading ? null : _pickDate,
                    icon: const Icon(Icons.calendar_today_outlined),
                    label: Text(
                      _specificDate == null
                          ? 'Choose date'
                          : DateFormat.yMMMd().format(_specificDate!),
                    ),
                  ),
                if (!_recurring && _specificDate == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text('Choose a date for this one-time entry.'),
                  ),
                if (state.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    state.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: state.isScheduleLoading ? null : _save,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(editing ? 'Save changes' : 'Add to timetable'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label,
    String hint,
  ) => TextFormField(
    controller: controller,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    ),
  );

  Future<void> _pickTime({required bool start}) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: start ? _start : _end,
    );
    if (selected == null || !mounted) return;
    setState(() {
      if (start) {
        _start = selected;
      } else {
        _end = selected;
      }
    });
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _specificDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null && mounted) setState(() => _specificDate = selected);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_minutes(_start) >= _minutes(_end) ||
        (!_recurring && _specificDate == null)) {
      setState(() {});
      return;
    }
    final current = widget.entry;
    final now = DateTime.now();
    final entry = ScheduleEntryEntity(
      id: current?.id ?? '',
      serverId: current?.serverId,
      idempotencyKey: current?.idempotencyKey ?? '',
      syncStatus: current?.syncStatus ?? 'pending',
      lastSyncError: current?.lastSyncError,
      studentCourseId: widget.course.id,
      dayOfWeek: _day,
      startTime: _formatTime(_start),
      endTime: _formatTime(_end),
      venue: _optional(_venue),
      campus: _optional(_campus),
      section: _optional(_section),
      label: _optional(_label),
      color: _color,
      isRecurring: _recurring,
      specificDate: _recurring ? null : _specificDate,
      createdAt: current?.createdAt ?? now,
      updatedAt: now,
    );
    final cubit = context.read<CourseCubit>();
    if (current == null) {
      await cubit.createScheduleEntry(entry);
    } else {
      await cubit.updateScheduleEntry(entry);
    }
    if (mounted && cubit.state.error == null) Navigator.pop(context, true);
  }

  String? _optional(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  static TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.first) ?? 9,
      minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
    );
  }

  static int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

  static String _formatTime(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  static String _title(String day) =>
      '${day[0].toUpperCase()}${day.substring(1)}';
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final TimeOfDay value;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: const Icon(Icons.schedule_outlined),
      label: Text('$label  ${value.format(context)}'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
