import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../../domain/entities/agenda_event.dart';
import '../cubit/agenda_cubit.dart';

class CreateAgendaEventPage extends StatefulWidget {
  const CreateAgendaEventPage({super.key, this.event, this.initialDate});

  final AgendaEvent? event;
  final DateTime? initialDate;

  @override
  State<CreateAgendaEventPage> createState() => _CreateAgendaEventPageState();
}

class _CreateAgendaEventPageState extends State<CreateAgendaEventPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _summaryController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _attendeesController;
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late bool _allDay;
  late String _timezone;
  late String _status;
  late String _transparency;
  late String _recurrence;
  bool _recurrenceChanged = false;
  late bool _useDefaultReminders;
  late int _reminderMinutes;
  bool _remindersChanged = false;
  bool _showMoreOptions = false;
  String? _attendeesError;
  bool _isSaving = false;
  String? _formError;

  bool get _isEditing => widget.event != null;

  @override
  void initState() {
    super.initState();
    final event = widget.event;
    final start =
        event?.startTime?.toLocal() ?? widget.initialDate ?? DateTime.now();
    final end =
        event?.endTime?.toLocal() ?? start.add(const Duration(hours: 1));
    _summaryController = TextEditingController(text: event?.summary ?? '');
    _descriptionController = TextEditingController(
      text: event?.description ?? '',
    );
    _locationController = TextEditingController(text: event?.location ?? '');
    _attendeesController = TextEditingController(
      text:
          event?.attendees
              .map((attendee) => attendee.email)
              .whereType<String>()
              .join(', ') ??
          '',
    );
    _startDate = _dateOnly(start);
    _endDate = _dateOnly(end);
    _startTime = TimeOfDay.fromDateTime(start);
    _endTime = TimeOfDay.fromDateTime(end);
    _allDay = event?.allDay ?? false;
    _timezone = event?.timezone ?? 'Africa/Nairobi';
    _status = event?.status ?? 'confirmed';
    _transparency = event?.transparency ?? 'opaque';
    _recurrence = _recurrenceOption(event?.recurrence ?? const []);
    _useDefaultReminders = event?.reminders['useDefault'] != false;
    _reminderMinutes = _reminderValue(event?.reminders) ?? 30;
    _showMoreOptions =
        event != null &&
        (event.attendees.isNotEmpty ||
            event.recurrence.isNotEmpty ||
            _status != 'confirmed' ||
            _transparency != 'opaque' ||
            !_useDefaultReminders ||
            _timezone != 'Africa/Nairobi');
  }

  @override
  void dispose() {
    _summaryController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _attendeesController.dispose();
    super.dispose();
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? _startDate : _endDate;
    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected == null || !mounted) return;
    final previousDate = isStart ? _startDate : _endDate;
    if (selected.year == previousDate.year &&
        selected.month == previousDate.month &&
        selected.day == previousDate.day) {
      return;
    }
    HapticFeedback.selectionClick();
    setState(() {
      if (isStart) {
        _startDate = selected;
      } else {
        _endDate = selected;
      }
      _formError = null;
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (selected == null || !mounted) return;
    final previousTime = isStart ? _startTime : _endTime;
    if (selected.hour == previousTime.hour &&
        selected.minute == previousTime.minute) {
      return;
    }
    HapticFeedback.selectionClick();
    setState(() {
      if (isStart) {
        _startTime = selected;
      } else {
        _endTime = selected;
      }
      _formError = null;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final attendeeError = _validateAttendeeText(_attendeesController.text);
    if (attendeeError != null) {
      setState(() {
        _showMoreOptions = true;
        _attendeesError = attendeeError;
      });
      return;
    }
    final start = _combine(_startDate, _startTime);
    final end = _combine(_endDate, _endTime);
    if (!end.isAfter(start)) {
      setState(() => _formError = 'End time must be after start time.');
      return;
    }

    setState(() {
      _isSaving = true;
      _formError = null;
    });

    final event = widget.event;
    final attendees = _attendeeValues(_attendeesController.text, event);
    final draft = AgendaEventDraft(
      summary: _summaryController.text.trim(),
      description: _nullableText(_descriptionController.text),
      location: _nullableText(_locationController.text),
      startTime: start,
      endTime: end,
      allDay: _allDay,
      timezone: _timezone,
      status: _status,
      transparency: _transparency,
      attendees: attendees,
      reminders: _remindersValue(event),
      recurrence: _recurrenceValue(event),
    );

    final cubit = context.read<AgendaCubit>();
    final saved = event == null
        ? await cubit.create(draft)
        : await cubit.update(event.id, draft);
    if (!mounted) return;

    if (saved) {
      HapticFeedback.lightImpact();
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isSaving = false;
        _formError = cubit.state.error ?? 'Could not save this agenda event.';
      });
    }
  }

  String? _nullableText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String? _validateAttendeeText(String value) {
    final emails = value
        .split(',')
        .map((email) => email.trim())
        .where((email) => email.isNotEmpty);
    return emails.any(
          (email) => !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email),
        )
        ? 'Enter valid email addresses.'
        : null;
  }

  String _recurrenceOption(List<String> recurrence) {
    if (recurrence.isEmpty) return 'none';
    final rule = recurrence.first.toUpperCase();
    for (final frequency in const ['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY']) {
      if (rule.contains('FREQ=$frequency')) return frequency.toLowerCase();
    }
    return 'custom';
  }

  List<String> _recurrenceValue(AgendaEvent? event) {
    if (event != null && !_recurrenceChanged) return event.recurrence;
    if (_recurrence == 'none') return const [];
    if (_recurrence == 'custom') return event?.recurrence ?? const [];
    return ['RRULE:FREQ=${_recurrence.toUpperCase()}'];
  }

  List<AgendaAttendee> _attendeeValues(String rawValue, AgendaEvent? event) {
    final existingByEmail = {
      for (final attendee in event?.attendees ?? const <AgendaAttendee>[])
        if (attendee.email != null) attendee.email!.toLowerCase(): attendee,
    };
    return rawValue
        .split(',')
        .map((email) => email.trim())
        .where((email) => email.isNotEmpty)
        .map((email) {
          final existing = existingByEmail[email.toLowerCase()];
          return AgendaAttendee(
            email: email,
            displayName: existing?.displayName,
          );
        })
        .toList();
  }

  Map<String, dynamic> _remindersValue(AgendaEvent? event) {
    if (event != null && !_remindersChanged) return event.reminders;
    if (_useDefaultReminders) return const {'useDefault': true};
    return {
      'useDefault': false,
      'overrides': [
        {'method': 'popup', 'minutes': _reminderMinutes},
      ],
    };
  }

  int? _reminderValue(Map<String, dynamic>? reminders) {
    final overrides = reminders?['overrides'];
    if (overrides is! List || overrides.isEmpty || overrides.first is! Map) {
      return null;
    }
    final minutes = (overrides.first as Map)['minutes'];
    return minutes is num ? minutes.toInt() : null;
  }

  String _displayDate(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  String _displayTime(TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SheetContentScaffold(
      topBar: AppBar(
        title: Text(_isEditing ? 'Edit event' : 'New event'),
        leading: IconButton(
          tooltip: 'Close',
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          IconButton.filledTonal(
            tooltip: _isEditing ? 'Save changes' : 'Create event',
            onPressed: _isSaving ? null : _save,
            icon: _isSaving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_rounded),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox.square(
                            dimension: 44,
                            child: Icon(
                              Icons.event_available_rounded,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isEditing ? 'Make it yours' : 'Make a plan',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              Text(
                                'Add the details and choose a time.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _summaryController,
                      enabled: !_isSaving,
                      maxLength: 1024,
                      textCapitalization: TextCapitalization.sentences,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: _fieldDecoration(
                        context,
                        'Event title',
                        hintText: 'What are you planning?',
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter a title.';
                        }
                        if (value.trim().length > 1024) {
                          return 'Title must be 1024 characters or fewer.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      enabled: !_isSaving,
                      minLines: 2,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: _fieldDecoration(context, 'Description'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _locationController,
                      enabled: !_isSaving,
                      decoration: _fieldDecoration(context, 'Location'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'When',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          'Local time · $_timezone',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Material(
                      color: theme.colorScheme.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          SwitchListTile.adaptive(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            title: const Text('All day'),
                            subtitle: const Text('Hide the time of day'),
                            value: _allDay,
                            onChanged: _isSaving
                                ? null
                                : (value) {
                                    HapticFeedback.selectionClick();
                                    setState(() => _allDay = value);
                                  },
                          ),
                          Divider(
                            height: 1,
                            color: theme.colorScheme.outlineVariant,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _DateTimeChoiceCard(
                                    title: 'Starts',
                                    dateLabel: _displayDate(_startDate),
                                    timeLabel: _displayTime(_startTime),
                                    showTime: !_allDay,
                                    onPickDate: _isSaving
                                        ? null
                                        : () => _pickDate(isStart: true),
                                    onPickTime: _isSaving || _allDay
                                        ? null
                                        : () => _pickTime(isStart: true),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _DateTimeChoiceCard(
                                    title: 'Ends',
                                    dateLabel: _displayDate(_endDate),
                                    timeLabel: _displayTime(_endTime),
                                    showTime: !_allDay,
                                    onPickDate: _isSaving
                                        ? null
                                        : () => _pickDate(isStart: false),
                                    onPickTime: _isSaving || _allDay
                                        ? null
                                        : () => _pickTime(isStart: false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Material(
                      color: theme.colorScheme.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ExpansionTile(
                        initiallyExpanded: _showMoreOptions,
                        enabled: !_isSaving,
                        leading: const Icon(Icons.tune_rounded),
                        title: const Text('More options'),
                        subtitle: const Text('Attendees, repeat and reminders'),
                        onExpansionChanged: (expanded) {
                          setState(() => _showMoreOptions = expanded);
                        },
                        childrenPadding: const EdgeInsets.fromLTRB(
                          16,
                          0,
                          16,
                          16,
                        ),
                        children: [
                          TextFormField(
                            controller: _attendeesController,
                            enabled: !_isSaving,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _fieldDecoration(
                              context,
                              'Attendee emails',
                              helperText: 'Separate multiple email addresses with commas.',
                            ),
                            validator: (value) =>
                                _attendeesError ??
                                _validateAttendeeText(value ?? ''),
                            onChanged: (_) {
                              if (_attendeesError != null) {
                                setState(() => _attendeesError = null);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            initialValue: _recurrence,
                            decoration: _fieldDecoration(context, 'Repeat'),
                            items: const [
                              DropdownMenuItem(
                                value: 'none',
                                child: Text('Does not repeat'),
                              ),
                              DropdownMenuItem(
                                value: 'daily',
                                child: Text('Daily'),
                              ),
                              DropdownMenuItem(
                                value: 'weekly',
                                child: Text('Weekly'),
                              ),
                              DropdownMenuItem(
                                value: 'monthly',
                                child: Text('Monthly'),
                              ),
                              DropdownMenuItem(
                                value: 'yearly',
                                child: Text('Yearly'),
                              ),
                              DropdownMenuItem(
                                value: 'custom',
                                child: Text('Keep custom rule'),
                              ),
                            ],
                            onChanged: _isSaving
                                ? null
                                : (value) => setState(() {
                                    _recurrence = value ?? 'none';
                                    _recurrenceChanged = true;
                                  }),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _status,
                            decoration: _fieldDecoration(context, 'Status'),
                            items: const [
                              DropdownMenuItem(
                                value: 'confirmed',
                                child: Text('Confirmed'),
                              ),
                              DropdownMenuItem(
                                value: 'tentative',
                                child: Text('Tentative'),
                              ),
                              DropdownMenuItem(
                                value: 'cancelled',
                                child: Text('Cancelled'),
                              ),
                            ],
                            onChanged: _isSaving
                                ? null
                                : (value) => setState(
                                    () => _status = value ?? 'confirmed',
                                  ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _transparency,
                            decoration: _fieldDecoration(
                              context,
                              'Availability',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'opaque',
                                child: Text('Busy'),
                              ),
                              DropdownMenuItem(
                                value: 'transparent',
                                child: Text('Free'),
                              ),
                            ],
                            onChanged: _isSaving
                                ? null
                                : (value) => setState(
                                    () => _transparency = value ?? 'opaque',
                                  ),
                          ),
                          const SizedBox(height: 4),
                          SwitchListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Use default reminders'),
                            value: _useDefaultReminders,
                            onChanged: _isSaving
                                ? null
                                : (value) => setState(() {
                                    _useDefaultReminders = value;
                                    _remindersChanged = true;
                                  }),
                          ),
                          AnimatedSize(
                            duration: MediaQuery.of(context).disableAnimations
                                ? Duration.zero
                                : const Duration(milliseconds: 180),
                            curve: Curves.easeOutCubic,
                            child: _useDefaultReminders
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: DropdownButtonFormField<int>(
                                      initialValue: _reminderMinutes,
                                      decoration: _fieldDecoration(
                                        context,
                                        'Reminder',
                                      ),
                                      items: [
                                        if (![
                                          5,
                                          15,
                                          30,
                                          60,
                                          1440,
                                        ].contains(_reminderMinutes))
                                          DropdownMenuItem(
                                            value: _reminderMinutes,
                                            child: Text(
                                              '$_reminderMinutes minutes before',
                                            ),
                                          ),
                                        const DropdownMenuItem(
                                          value: 5,
                                          child: Text('5 minutes before'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 15,
                                          child: Text('15 minutes before'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 30,
                                          child: Text('30 minutes before'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 60,
                                          child: Text('1 hour before'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 1440,
                                          child: Text('1 day before'),
                                        ),
                                      ],
                                      onChanged: _isSaving
                                          ? null
                                          : (value) => setState(() {
                                              _reminderMinutes = value ?? 30;
                                              _remindersChanged = true;
                                            }),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          InputDecorator(
                            decoration: _fieldDecoration(context, 'Timezone'),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  size: 18,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 8),
                                Text(_timezone),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: MediaQuery.of(context).disableAnimations
                          ? Duration.zero
                          : const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      child: _formError == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.errorContainer,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: theme.colorScheme.onErrorContainer,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _formError!,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: theme
                                                  .colorScheme
                                                  .onErrorContainer,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.sync_alt,
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Google Tasks syncs in the background when available. This event stays in your agenda either way.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateTimeChoiceCard extends StatelessWidget {
  const _DateTimeChoiceCard({
    required this.title,
    required this.dateLabel,
    required this.timeLabel,
    required this.onPickDate,
    required this.onPickTime,
    required this.showTime,
  });

  final String title;
  final String dateLabel;
  final String timeLabel;
  final VoidCallback? onPickDate;
  final VoidCallback? onPickTime;
  final bool showTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onPickDate,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 17,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      dateLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showTime) ...[
          const SizedBox(height: 6),
          Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onPickTime,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 17,
                      color: colors.tertiary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        timeLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

InputDecoration _fieldDecoration(
  BuildContext context,
  String label, {
  String? helperText,
  String? hintText,
  String? counterText,
}) {
  final colors = Theme.of(context).colorScheme;
  final radius = BorderRadius.circular(16);
  return InputDecoration(
    labelText: label,
    hintText: hintText,
    helperText: helperText,
    counterText: counterText,
    filled: true,
    fillColor: colors.surfaceContainerLow,
    border: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.error, width: 1.5),
    ),
  );
}
