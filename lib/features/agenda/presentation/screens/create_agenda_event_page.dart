import 'package:academia/features/agenda/agenda.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAgendaEventPage extends StatefulWidget {
  const CreateAgendaEventPage({super.key});

  @override
  State<CreateAgendaEventPage> createState() => _CreateAgendaEventPageState();
}

class _CreateAgendaEventPageState extends State<CreateAgendaEventPage>
    with TickerProviderStateMixin {
  // Animation controllers for microinteractions
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive layout for larger screens
            if (constraints.maxWidth > 600) {
              return _DesktopLayout(constraints: constraints);
            }
            return _MobileLayout();
          },
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final BoxConstraints constraints;

  const _DesktopLayout({required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left side - Form
        Expanded(
          flex: 2,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const _AgendaForm(),
          ),
        ),
        // Right side - Preview or additional info
        Expanded(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Center(
              child: Text(
                'Event Preview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _AgendaForm();
  }
}

class _AgendaForm extends StatefulWidget {
  const _AgendaForm();

  @override
  State<_AgendaForm> createState() => _AgendaFormState();
}

class _AgendaFormState extends State<_AgendaForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _attendeesController = TextEditingController();

  bool _isAllDay = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now().replacing(
    hour: (TimeOfDay.now().hour + 1 >= 24) ? 0 : TimeOfDay.now().hour,
  );
  final String _selectedEventType = 'Event';
  String _repeatSetting = 'Does not repeat';
  String _notification = '30 minutes before';
  List<Map<String, String>> _attendees = [];

  // State management for form submission
  bool _isSubmitting = false;

  // Animation controllers for microinteractions
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final List<String> _repeatOptions = [
    'Does not repeat',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  final List<String> _notificationOptions = [
    '5 minutes before',
    '10 minutes before',
    '15 minutes before',
    '30 minutes before',
    '1 hour before',
    '1 day before',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _attendeesController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Add microinteraction feedback
      _scaleController.forward(from: 0.0);

      // Convert attendees list to List<dynamic> format
      List<dynamic> attendeesList = _attendees
          .map(
            (attendee) => {
              'email': attendee['email'] ?? '',
              'displayName': attendee['displayName'] ?? '',
            },
          )
          .toList();

      // Convert repeat setting to recurrence format
      List<dynamic> recurrenceList = [];
      if (_repeatSetting != 'Does not repeat') {
        recurrenceList.add(_repeatSetting.toLowerCase());
      }

      // Special handling for birthday events - always yearly recurrence
      if (_selectedEventType == 'Birthday') {
        recurrenceList = ['yearly'];
      }

      // Convert notification to reminders format
      Map<String, dynamic> remindersMap = {
        'useDefault': false,
        'overrides': [
          {
            'method': 'popup',
            'minutes': _getNotificationMinutes(_notification),
          },
        ],
      };

      // Special handling for birthday events - add multiple reminders
      if (_selectedEventType == 'Birthday') {
        remindersMap['overrides'] = [
          {'method': 'email', 'minutes': 24 * 60}, // 1 day before
          {'method': 'popup', 'minutes': 60}, // 1 hour before
        ];
      }

      // Create start and end DateTime with proper time
      final startDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );

      final endDateTime = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        _endTime.hour,
        _endTime.minute,
      );

      // Handle special event types
      String summary = _titleController.text;
      String description = _descriptionController.text;

      if (_selectedEventType == 'Birthday') {
        // For birthday events, format like the example
        final personName = _titleController.text
            .replaceAll("'s Birthday", "")
            .trim();
        summary = "$personName's Birthday";
        description = "Happy Birthday $personName! 🎉";

        // Set default location if empty
        if (_locationController.text.isEmpty) {
          _locationController.text = "Birthday Celebration";
        }

        // Set default time for birthday events (6 PM - 10 PM)
        if (_startTime.hour == 0 && _startTime.minute == 0) {
          _startTime = const TimeOfDay(hour: 18, minute: 0);
          _endTime = const TimeOfDay(hour: 22, minute: 0);
        }
      }

      final agendaEvent = AgendaEvent(
        id: _selectedEventType == 'Birthday'
            ? 'birthday_${_titleController.text.toLowerCase().replaceAll(' ', '_').replaceAll("'s_birthday", "")}'
            : 'event_${DateTime.now().millisecondsSinceEpoch}',
        summary: summary,
        description: description,
        location: _locationController.text,
        allDay: _isAllDay,
        startTime: startDateTime,
        endTime: endDateTime,
        timezone: 'Africa/Nairobi',
        status: 'confirmed',
        transparency: 'opaque',
        calendarId: 'primary',
        created: DateTime.now(),
        updated: DateTime.now(),
        attendees: attendeesList,
        recurrence: recurrenceList,
        reminders: remindersMap,
      );

      context.read<AgendaEventBloc>().add(
        CreateAgendaEventEvent(agendaEvent: agendaEvent),
      );

      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Creating event...'),
            ],
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  int _getNotificationMinutes(String notification) {
    switch (notification) {
      case '5 minutes before':
        return 5;
      case '10 minutes before':
        return 10;
      case '15 minutes before':
        return 15;
      case '30 minutes before':
        return 30;
      case '1 hour before':
        return 60;
      case '1 day before':
        return 1440; // 24 * 60 minutes
      default:
        return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgendaEventBloc, AgendaEventState>(
      listener: (context, state) {
        if (state is AgendaEventLoadedState && _isSubmitting) {
          // Success state
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text('Event created successfully!'),
                ],
              ),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
          setState(() {
            _isSubmitting = false;
          });
          Navigator.of(context).pop();
        } else if (state is AgendaEventErrorState && _isSubmitting) {
          // Error state
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(state.error)),
                ],
              ),
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  _saveEvent(); // Retry the operation
                },
              ),
            ),
          );
          setState(() {
            _isSubmitting = false;
          });
        }
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  // Top Bar
                  SliverAppBar.large(
                    title: const Text("Create agenda item"),
                    actions: [
                      BlocBuilder<AgendaEventBloc, AgendaEventState>(
                        builder: (context, state) {
                          return FilledButton(
                            onPressed: _isSubmitting ? null : _saveEvent,
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text("Save"),
                          );
                        },
                      ),
                    ],
                  ),

                  // SliverToBoxAdapter(child: _TopBar(onSave: _saveEvent)),
                  // Account and Calendar Selection
                  SliverToBoxAdapter(child: const _AccountSection()),

                  // Main Form Content
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Title Field
                        _TitleField(
                          controller: _titleController,
                          enabled: !_isSubmitting,
                        ),
                        const SizedBox(height: 24),

                        // Description Field
                        _DescriptionField(
                          controller: _descriptionController,
                          enabled: !_isSubmitting,
                        ),
                        const SizedBox(height: 24),

                        // Location Field
                        _LocationField(
                          controller: _locationController,
                          enabled: !_isSubmitting,
                        ),
                        const SizedBox(height: 24),

                        // Timing Section
                        _TimingSection(
                          isAllDay: _isAllDay,
                          startDate: _startDate,
                          endDate: _endDate,
                          startTime: _startTime,
                          endTime: _endTime,
                          repeatSetting: _repeatSetting,
                          repeatOptions: _repeatOptions,
                          enabled: !_isSubmitting,
                          onAllDayChanged: (value) =>
                              setState(() => _isAllDay = value),
                          onStartDateChanged: (date) =>
                              setState(() => _startDate = date),
                          onEndDateChanged: (date) =>
                              setState(() => _endDate = date),
                          onStartTimeChanged: (time) =>
                              setState(() => _startTime = time),
                          onEndTimeChanged: (time) =>
                              setState(() => _endTime = time),
                          onRepeatChanged: (setting) =>
                              setState(() => _repeatSetting = setting),
                        ),
                        const SizedBox(height: 24),

                        // Attendees Section
                        _AttendeesSection(
                          attendees: _attendees,
                          attendeesController: _attendeesController,
                          enabled: !_isSubmitting,
                          onAttendeesChanged: (attendees) =>
                              setState(() => _attendees = attendees),
                        ),
                        const SizedBox(height: 24),

                        // Additional Options
                        _AdditionalOptions(
                          notification: _notification,
                          notificationOptions: _notificationOptions,
                          onNotificationChanged: (notification) =>
                              setState(() => _notification = notification),
                        ),
                        const SizedBox(height: 24),

                        // Bottom padding for safe area
                        const SizedBox(height: 100),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          String userEmail = 'anonymous@example.com';

          if (state is ProfileLoadedState) {
            userEmail = state.profile.email;
          }

          return ListTile(
            leading: UserAvatar(radius: 20),
            title: Text(userEmail),
            subtitle: Text('Your primary calendar'),
          );
        },
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const _TitleField({required this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: 'Add title',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: enabled
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
      ),
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: enabled
            ? null
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const _DescriptionField({required this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: 'Add description',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: enabled
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: enabled
            ? null
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      maxLines: 3,
      minLines: 1,
    );
  }
}

class _LocationField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const _LocationField({required this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: 'Add location',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          Icons.location_on,
          size: 20,
          color: enabled
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: enabled
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: enabled
            ? null
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}

class _TimingSection extends StatelessWidget {
  final bool isAllDay;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String repeatSetting;
  final List<String> repeatOptions;
  final bool enabled;
  final Function(bool) onAllDayChanged;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(String) onRepeatChanged;

  const _TimingSection({
    required this.isAllDay,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.repeatSetting,
    required this.repeatOptions,
    this.enabled = true,
    required this.onAllDayChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onRepeatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // All-day toggle
        Row(
          children: [
            Text('All-day', style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            Switch(
              value: isAllDay,
              onChanged: enabled ? onAllDayChanged : null,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Start date/time
        _DateTimeRow(
          label: 'Start',
          date: startDate,
          time: startTime,
          isAllDay: isAllDay,
          enabled: enabled,
          onDateChanged: onStartDateChanged,
          onTimeChanged: onStartTimeChanged,
        ),
        const SizedBox(height: 12),

        // End date/time
        _DateTimeRow(
          label: 'End',
          date: endDate,
          time: endTime,
          isAllDay: isAllDay,
          enabled: enabled,
          onDateChanged: onEndDateChanged,
          onTimeChanged: onEndTimeChanged,
        ),
        const SizedBox(height: 16),

        // Timezone
        Row(
          children: [
            Icon(
              Icons.language,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              'East Africa Time',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Repeat setting
        _AnimatedRepeatSelector(
          repeatSetting: repeatSetting,
          repeatOptions: repeatOptions,
          enabled: enabled,
          onRepeatChanged: onRepeatChanged,
        ),
      ],
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  final String label;
  final DateTime date;
  final TimeOfDay time;
  final bool isAllDay;
  final bool enabled;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;

  const _DateTimeRow({
    required this.label,
    required this.date,
    required this.time,
    required this.isAllDay,
    this.enabled = true,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const Spacer(),
        TextButton(
          onPressed: enabled ? () => _selectDate(context, onDateChanged) : null,
          child: Text(
            _formatDate(date),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: enabled
                  ? null
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        if (!isAllDay) ...[
          const SizedBox(width: 16),
          TextButton(
            onPressed: enabled
                ? () => _selectTime(context, onTimeChanged)
                : null,
            child: Text(
              time.format(context),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: enabled
                    ? null
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    Function(DateTime) onChanged,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    Function(TimeOfDay) onChanged,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonth(date.month)} ${date.year}';
  }

  String _getDayOfWeek(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class _AnimatedRepeatSelector extends StatefulWidget {
  final String repeatSetting;
  final List<String> repeatOptions;
  final bool enabled;
  final Function(String) onRepeatChanged;

  const _AnimatedRepeatSelector({
    required this.repeatSetting,
    required this.repeatOptions,
    this.enabled = true,
    required this.onRepeatChanged,
  });

  @override
  State<_AnimatedRepeatSelector> createState() =>
      _AnimatedRepeatSelectorState();
}

class _AnimatedRepeatSelectorState extends State<_AnimatedRepeatSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enabled ? (_) => _controller.forward() : null,
      onTapUp: widget.enabled
          ? (_) {
              _controller.reverse();
              _showRepeatDialog(context);
            }
          : null,
      onTapCancel: widget.enabled ? () => _controller.reverse() : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Row(
          children: [
            Icon(
              Icons.repeat,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              widget.repeatSetting,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.enabled
                    ? null
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showRepeatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Repeat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.repeatOptions.map((option) {
            return ListTile(
              title: Text(option),
              trailing: widget.repeatSetting == option
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                widget.onRepeatChanged(option);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _AttendeesSection extends StatefulWidget {
  final List<Map<String, String>> attendees;
  final TextEditingController attendeesController;
  final bool enabled;
  final Function(List<Map<String, String>>) onAttendeesChanged;

  const _AttendeesSection({
    required this.attendees,
    required this.attendeesController,
    this.enabled = true,
    required this.onAttendeesChanged,
  });

  @override
  State<_AttendeesSection> createState() => _AttendeesSectionState();
}

class _AttendeesSectionState extends State<_AttendeesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.people,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text('Add people', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        const SizedBox(height: 8),

        // Add attendee input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.attendeesController,
                enabled: widget.enabled,
                decoration: InputDecoration(
                  hintText: 'Enter email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty && value.contains('@')) {
                    final newAttendee = <String, String>{
                      'email': value,
                      'displayName': value.split(
                        '@',
                      )[0], // Use email prefix as display name
                    };
                    final updatedAttendees = List<Map<String, String>>.from(
                      widget.attendees,
                    )..add(newAttendee);
                    widget.onAttendeesChanged(updatedAttendees);
                    widget.attendeesController.clear();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: widget.enabled
                  ? () {
                      final value = widget.attendeesController.text;
                      if (value.isNotEmpty && value.contains('@')) {
                        final newAttendee = <String, String>{
                          'email': value,
                          'displayName': value.split('@')[0],
                        };
                        final updatedAttendees = List<Map<String, String>>.from(
                          widget.attendees,
                        )..add(newAttendee);
                        widget.onAttendeesChanged(updatedAttendees);
                        widget.attendeesController.clear();
                      }
                    }
                  : null,
              child: const Text('Add'),
            ),
          ],
        ),

        // Display attendees
        if (widget.attendees.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...widget.attendees.map(
            (attendee) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Text(
                      (attendee['displayName'] ?? 'A')[0].toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attendee['displayName'] ?? '',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          attendee['email'] ?? '',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: widget.enabled
                        ? () {
                            final updatedAttendees =
                                List<Map<String, String>>.from(widget.attendees)
                                  ..remove(attendee);
                            widget.onAttendeesChanged(updatedAttendees);
                          }
                        : null,
                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                    color: widget.enabled
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.error.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],

        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: widget.enabled ? () {} : null,
          child: const Text('View schedules'),
        ),
      ],
    );
  }
}

class _AdditionalOptions extends StatelessWidget {
  final String notification;
  final List<String> notificationOptions;
  final Function(String) onNotificationChanged;

  const _AdditionalOptions({
    required this.notification,
    required this.notificationOptions,
    required this.onNotificationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Notification
        _NotificationRow(
          notification: notification,
          notificationOptions: notificationOptions,
          onNotificationChanged: onNotificationChanged,
        ),
      ],
    );
  }
}

class _NotificationRow extends StatefulWidget {
  final String notification;
  final List<String> notificationOptions;
  final Function(String) onNotificationChanged;

  const _NotificationRow({
    required this.notification,
    required this.notificationOptions,
    required this.onNotificationChanged,
  });

  @override
  State<_NotificationRow> createState() => _NotificationRowState();
}

class _NotificationRowState extends State<_NotificationRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              widget.notification,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => widget.onNotificationChanged(''),
              icon: const Icon(Icons.close, size: 16),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            _showNotificationDialog(context);
          },
          onTapCancel: () => _controller.reverse(),
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              'Add notification',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.notificationOptions.map((option) {
            return ListTile(
              title: Text(option),
              trailing: widget.notification == option
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                widget.onNotificationChanged(option);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
