import 'package:academia/features/agenda/domain/domain.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class AddCourseToAgendaWidget extends StatefulWidget {
  const AddCourseToAgendaWidget({super.key, required this.magnetCourseInfo});
  final MagnetCourseInfo magnetCourseInfo;

  @override
  State<AddCourseToAgendaWidget> createState() =>
      _AddCourseToAgendaWidgetState();
}

class _AddCourseToAgendaWidgetState extends State<AddCourseToAgendaWidget> {
  final _formKey = GlobalKey<FormState>();

  // Form state variables
  late TextEditingController _summaryController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late Duration _duration;
  late DateTime _endDate;

  // MODIFICATION: Use a Set to store multiple selected reminder times
  final Set<int> _selectedReminderMinutes = {};

  // Using a Set to store the selected recurrence days (e.g., "MO", "TU")
  final Set<String> _selectedDays = {};

  // Available options for UI
  final Map<String, String> _weekdays = {
    'MO': 'Mon',
    'TU': 'Tue',
    'WE': 'Wed',
    'TH': 'Thu',
    'FR': 'Fri',
    'SA': 'Sat',
    'SU': 'Sun',
  };

  final Map<int, String> _reminderOptions = {
    5: '5 mins before',
    10: '10 mins before',
    30: '30 mins before',
    60: '1 hour before',
    1440: '1 day before',
  };

  @override
  void initState() {
    super.initState();
    final course = widget.magnetCourseInfo;

    // Initialize controllers with course data
    _summaryController = TextEditingController(
      text: "${course.courseCode}: ${course.courseTitle}",
    );
    _descriptionController = TextEditingController(
      text:
          "Instructor: ${course.instructor ?? 'N/A'}\n"
          "${course.courseDescription ?? ''}",
    );
    _locationController = TextEditingController(text: course.location ?? '');

    // Initialize date, time, and duration
    _startDate = course.schedule ?? DateTime.now();
    _startTime = TimeOfDay.fromDateTime(_startDate);
    _duration = course.duration ?? const Duration(hours: 1, minutes: 30);

    // Default end date to 3 months after start, a typical semester length
    _endDate = DateTime(_startDate.year, _startDate.month + 3, _startDate.day);

    // Pre-select the day of the week based on the start date
    final startDay = DateFormat(
      'E',
    ).format(_startDate).toUpperCase().substring(0, 2);
    if (_weekdays.keys.contains(startDay)) {
      _selectedDays.add(startDay);
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    _summaryController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // --- UI Builder Methods ---

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Add ${widget.magnetCourseInfo.courseCode} to your calendar",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.sigmarOne().fontFamily,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Time and Duration Pickers
              _buildTimeAndDurationPickers(),
              const SizedBox(height: 16),

              const Divider(),
              const SizedBox(height: 8),

              Text(
                "Recurrence",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),

              _buildDaySelector(),
              const SizedBox(height: 16),

              _buildRecurrenceEndDatePicker(),
              const SizedBox(height: 16),

              const Divider(),
              const SizedBox(height: 8),

              // MODIFICATION: Reminder chips instead of a dropdown
              _buildReminderSelector(),
              const SizedBox(height: 24),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _addEventToCalendar,
                  icon: const Icon(Icons.add_task),
                  label: const Text('Add to Calendar'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeAndDurationPickers() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: _selectTime,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
              child: Text(_startTime.format(context)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Duration',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.hourglass_bottom),
            ),
            child: Text(
              '${_duration.inHours}h ${_duration.inMinutes.remainder(60)}m',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Repeats on", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _weekdays.entries.map((entry) {
            final isSelected = _selectedDays.contains(entry.key);
            return FilterChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selectedDays.add(entry.key);
                  } else {
                    _selectedDays.remove(entry.key);
                  }
                });
              },
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecurrenceEndDatePicker() {
    return InkWell(
      onTap: _selectEndDate,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'End of recurrence',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.event_repeat),
        ),
        child: Text(DateFormat.yMMMd().format(_endDate)),
      ),
    );
  }

  // NEW WIDGET: Replaces the dropdown with selectable chips for multiple reminders
  Widget _buildReminderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reminders", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _reminderOptions.entries.map((entry) {
            final isSelected = _selectedReminderMinutes.contains(entry.key);
            return FilterChip(
              label: Text(entry.value),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selectedReminderMinutes.add(entry.key);
                  } else {
                    _selectedReminderMinutes.remove(entry.key);
                  }
                });
              },
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
            );
          }).toList(),
        ),
      ],
    );
  }

  // --- Logic Methods ---

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime(_startDate.year + 5), // Allow up to 5 years
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  // MODIFIED METHOD: Now handles multiple reminders
  void _addEventToCalendar() {
    if (!_formKey.currentState!.validate()) {
      return; // Validation failed
    }
    if (_selectedDays.isEmpty) {
      // Get screen dimensions and padding
      final screenHeight = MediaQuery.of(context).size.height;
      final statusBarHeight = MediaQuery.of(context).padding.top;

      // Show a floating SnackBar at the top of the screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select at least one day for the class to repeat.',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Theme.of(context).colorScheme.onError,
          margin: EdgeInsets.only(
            // Position the SnackBar at the top
            bottom: screenHeight - (statusBarHeight + 240),
            left: 16,
            right: 16,
          ),
        ),
      );
      return;
    }

    // Combine date and time for the final start time
    final finalStartTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );
    final finalEndTime = finalStartTime.add(_duration);

    // Format the end date for the RRULE string
    final untilDate = DateTime.utc(
      _endDate.year,
      _endDate.month,
      _endDate.day,
      23,
      59,
      59,
    );
    final formattedUntilDate = DateFormat(
      "yyyyMMdd'T'HHmmss'Z'",
    ).format(untilDate);

    // Build the recurrence rule string
    final rrule =
        'RRULE:FREQ=WEEKLY;UNTIL=$formattedUntilDate;BYDAY=${_selectedDays.first}';

    // Build the reminders map from the Set of selected minutes
    final Map<String, dynamic> reminders = {};
    if (_selectedReminderMinutes.isNotEmpty) {
      reminders['useDefault'] = false;
      // Map the selected minutes to the required Google Calendar override format
      reminders['overrides'] = _selectedReminderMinutes.map((minutes) {
        return {'method': 'popup', 'minutes': minutes};
      }).toList();
    } else {
      // If no reminders are selected, use the calendar's default
      reminders['useDefault'] = true;
    }
    String generateGoogleEventId(String courseCode) {
      final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
      // Sanitize course code: allow only [a-zA-Z0-9_-], replace others with '_'
      final safeCourseCode = courseCode.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '_',
      );
      return "course_${safeCourseCode}_$timestamp";
    }

    // Create the final AgendaEvent object
    final newEvent = AgendaEvent(
      id: generateGoogleEventId(
        widget.magnetCourseInfo.courseCode,
      ).toLowerCase().replaceAll("-", "_"), // A unique ID
      summary: _summaryController.text,
      location: _locationController.text,
      description: _descriptionController.text,
      startTime: finalStartTime,
      endTime: finalEndTime,
      recurrence: [rrule],
      reminders: reminders,
      updated: DateTime.now(),
      created: DateTime.now(),
      calendarId: 'primary',
      transparency: "opaque",
      status: "confirmed",
      timezone: 'Africa/Nairobi',
    );

    // Pop the screen and return the new event
    Navigator.of(context).pop(newEvent);
  }
}

