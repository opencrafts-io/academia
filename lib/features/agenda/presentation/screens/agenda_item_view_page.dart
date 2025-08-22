import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class AgendaItemViewPage extends StatefulWidget {
  const AgendaItemViewPage({super.key, this.agendaEventID});
  final String? agendaEventID;

  @override
  State<AgendaItemViewPage> createState() => _AgendaItemViewPageState();
}

class _AgendaItemViewPageState extends State<AgendaItemViewPage> {
  AgendaEvent? agendaEvent;
  bool _isEditing = false;
  bool _isSubmitting = false;
  bool _isDeleting = false;

  // Controllers for editing
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _attendeesController = TextEditingController();

  // State for editing
  bool _isAllDay = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now().replacing(
    hour: (TimeOfDay.now().hour + 1 >= 24) ? 0 : TimeOfDay.now().hour,
  );
  String _repeatSetting = 'Does not repeat';
  List<Map<String, String>> _attendees = [];

  final List<String> _repeatOptions = [
    'Does not repeat',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];

  @override
  void initState() {
    super.initState();
    // Load cached events to find the specific event
    context.read<AgendaEventBloc>().add(FetchCachedAgendaEventsEvent());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _attendeesController.dispose();
    super.dispose();
  }

  void _toggleEditMode() async {
    // Provide haptic feedback for edit mode toggle
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(preset: VibrationPreset.gentleReminder);
    }
    
    if (!mounted) return;
    
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing && agendaEvent != null) {
        _titleController.text = agendaEvent!.summary ?? '';
        _descriptionController.text = agendaEvent!.description ?? '';
        _locationController.text = agendaEvent!.location ?? '';
        
        // Initialize timing state
        _isAllDay = agendaEvent!.allDay;
        _startDate = agendaEvent!.startTime ?? DateTime.now();
        _endDate = agendaEvent!.endTime ?? DateTime.now().add(const Duration(hours: 1));
        _startTime = TimeOfDay.fromDateTime(agendaEvent!.startTime ?? DateTime.now());
        _endTime = TimeOfDay.fromDateTime(agendaEvent!.endTime ?? DateTime.now().add(const Duration(hours: 1)));
        
        // Initialize recurrence
        if (agendaEvent!.recurrence.isNotEmpty) {
          _repeatSetting = agendaEvent!.recurrence.first.toString().toUpperCase();
        } else {
          _repeatSetting = 'Does not repeat';
        }
        
        // Initialize attendees
        _attendees = agendaEvent!.attendees.map((attendee) {
          return <String, String>{
            'email': attendee['email'] ?? '',
            'displayName': attendee['displayName'] ?? attendee['email'] ?? '',
          };
        }).toList();
      }
    });
  }

  void _updateEvent() async {
    if (agendaEvent != null) {
      // Provide haptic feedback for update action
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(preset: VibrationPreset.softPulse);
      }
      
      if (!mounted) return;
      
      setState(() {
        _isSubmitting = true;
      });

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

      final updatedEvent = agendaEvent!.copyWith(
        summary: _titleController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        allDay: _isAllDay,
        startTime: startDateTime,
        endTime: endDateTime,
        attendees: attendeesList,
        recurrence: recurrenceList,
        updated: DateTime.now(),
      );

      context.read<AgendaEventBloc>().add(
        UpdateAgendaEventEvent(agendaEvent: updatedEvent),
      );
    }
  }

  void _deleteEvent() async {
    if (agendaEvent != null) {
      // Provide haptic feedback for delete action
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(preset: VibrationPreset.emergencyAlert);
      }
      
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Event'),
          content: const Text(
            'Are you sure you want to delete this event? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isDeleting = true;
                });
                context.read<AgendaEventBloc>().add(
                  DeleteAgendaEventEvent(agendaEvent: agendaEvent!),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<AgendaEventBloc, AgendaEventState>(
          listener: (context, state) {
            if (state is AgendaEventLoadedState) {
              // Find the specific event by ID from the stream
              state.agendaEventsStream.listen((events) {
                try {
                  final event = events.firstWhere(
                    (event) => event.id == widget.agendaEventID,
                  );
                  if (agendaEvent?.id != event.id) {
                    setState(() {
                      agendaEvent = event;
                      _isSubmitting = false;
                      _isEditing = false;
                    });
                  }
                } catch (e) {
                  // Event not found - this could mean it was deleted
                  if (agendaEvent != null) {
                    setState(() {
                      agendaEvent = null;
                    });
                    
                    // If we were in the process of deleting, show success message and navigate back
                    if (_isDeleting) {
                      setState(() {
                        _isDeleting = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Event deleted successfully'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      // Event was deleted from elsewhere, just navigate back
                      Navigator.of(context).pop();
                    }
                  }
                }
              });
            } else if (state is AgendaEventErrorState) {
              setState(() {
                _isSubmitting = false;
                _isDeleting = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AgendaEventInitialState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (agendaEvent == null) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    title: const Text('Agenda Item'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SliverFillRemaining(
                    child: Center(child: Text('Event not found')),
                  ),
                ],
              );
            }

            return _AgendaItemViewContent(
              agendaEvent: agendaEvent!,
              isEditing: _isEditing,
              isSubmitting: _isSubmitting,
              isDeleting: _isDeleting,
              titleController: _titleController,
              descriptionController: _descriptionController,
              locationController: _locationController,
              attendeesController: _attendeesController,
              isAllDay: _isAllDay,
              startDate: _startDate,
              endDate: _endDate,
              startTime: _startTime,
              endTime: _endTime,
              repeatSetting: _repeatSetting,
              repeatOptions: _repeatOptions,
              attendees: _attendees,
              onToggleEdit: _toggleEditMode,
              onUpdate: _updateEvent,
              onDelete: _deleteEvent,
              onAllDayChanged: (value) => setState(() => _isAllDay = value),
              onStartDateChanged: (date) => setState(() => _startDate = date),
              onEndDateChanged: (date) => setState(() => _endDate = date),
              onStartTimeChanged: (time) => setState(() => _startTime = time),
              onEndTimeChanged: (time) => setState(() => _endTime = time),
              onRepeatChanged: (setting) => setState(() => _repeatSetting = setting),
              onAttendeesChanged: (attendees) => setState(() => _attendees = attendees),
            );
          },
        ),
      ),
    );
  }
}

class _AgendaItemViewContent extends StatelessWidget {
  final AgendaEvent agendaEvent;
  final bool isEditing;
  final bool isSubmitting;
  final bool isDeleting;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final TextEditingController attendeesController;
  final bool isAllDay;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String repeatSetting;
  final List<String> repeatOptions;
  final List<Map<String, String>> attendees;
  final VoidCallback onToggleEdit;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final Function(bool) onAllDayChanged;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(String) onRepeatChanged;
  final Function(List<Map<String, String>>) onAttendeesChanged;

  const _AgendaItemViewContent({
    required this.agendaEvent,
    required this.isEditing,
    required this.isSubmitting,
    required this.isDeleting,
    required this.titleController,
    required this.descriptionController,
    required this.locationController,
    required this.attendeesController,
    required this.isAllDay,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.repeatSetting,
    required this.repeatOptions,
    required this.attendees,
    required this.onToggleEdit,
    required this.onUpdate,
    required this.onDelete,
    required this.onAllDayChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onRepeatChanged,
    required this.onAttendeesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar.large(
          title: Text(isEditing ? 'Edit Event' : 'Event Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            if (!isEditing) ...[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onToggleEdit,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: isDeleting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.delete),
                onPressed: isDeleting ? null : onDelete,
                tooltip: 'Delete',
              ),
            ] else ...[
              TextButton(onPressed: onToggleEdit, child: const Text('Cancel')),
              FilledButton(
                onPressed: isSubmitting ? null : onUpdate,
                child: isSubmitting
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
                    : const Text('Save'),
              ),
              const SizedBox(width: 8),
            ],
          ],
        ),

        // Account Section
        SliverToBoxAdapter(child: _AccountSection()),

        // Main Content
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Title Field
              _TitleField(
                controller: titleController,
                enabled: isEditing,
                initialValue: agendaEvent.summary,
              ),
              const SizedBox(height: 24),

              // Description Field
              _DescriptionField(
                controller: descriptionController,
                enabled: isEditing,
                initialValue: agendaEvent.description,
              ),
              const SizedBox(height: 24),

              // Location Field
              _LocationField(
                controller: locationController,
                enabled: isEditing,
                initialValue: agendaEvent.location,
              ),
              const SizedBox(height: 24),

              // Timing Section
              _TimingSection(
                agendaEvent: agendaEvent,
                isEditing: isEditing,
                isAllDay: isAllDay,
                startDate: startDate,
                endDate: endDate,
                startTime: startTime,
                endTime: endTime,
                repeatSetting: repeatSetting,
                repeatOptions: repeatOptions,
                onAllDayChanged: onAllDayChanged,
                onStartDateChanged: onStartDateChanged,
                onEndDateChanged: onEndDateChanged,
                onStartTimeChanged: onStartTimeChanged,
                onEndTimeChanged: onEndTimeChanged,
                onRepeatChanged: onRepeatChanged,
              ),
              const SizedBox(height: 24),

              // Attendees Section
              _AttendeesSection(
                attendees: isEditing ? attendees : agendaEvent.attendees,
                attendeesController: attendeesController,
                enabled: isEditing,
                onAttendeesChanged: onAttendeesChanged,
              ),
              const SizedBox(height: 24),

              // Additional Info Section
              if (!isEditing) ...[
                _AdditionalInfoSection(agendaEvent: agendaEvent),
                const SizedBox(height: 24),
              ],

              // Bottom padding for safe area
              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }
}

class _AccountSection extends StatelessWidget {
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
            subtitle: const Text('Your primary calendar'),
          );
        },
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String? initialValue;

  const _TitleField({
    required this.controller,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled && initialValue != null) {
      return Text(
        initialValue!,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
      );
    }

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
    );
  }
}

class _DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final String? initialValue;

  const _DescriptionField({
    required this.controller,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            initialValue ?? 'No description',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: initialValue != null
                  ? null
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

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
  final String? initialValue;

  const _LocationField({
    required this.controller,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      if (initialValue == null || initialValue!.isEmpty) {
        return const SizedBox.shrink();
      }

      return Row(
        children: [
          Icon(
            Icons.location_on,
            size: 20,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              initialValue!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      );
    }

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
  final AgendaEvent agendaEvent;
  final bool isEditing;
  final bool isAllDay;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String repeatSetting;
  final List<String> repeatOptions;
  final Function(bool) onAllDayChanged;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(String) onRepeatChanged;

  const _TimingSection({
    required this.agendaEvent,
    required this.isEditing,
    required this.isAllDay,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.repeatSetting,
    required this.repeatOptions,
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
        Text(
          'Time',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        if (isEditing) ...[
          // Edit mode - All-day toggle
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text('All-day', style: Theme.of(context).textTheme.bodyLarge),
              const Spacer(),
              Switch(
                value: isAllDay,
                onChanged: onAllDayChanged,
                activeThumbColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Edit mode - Start date/time
          _DateTimeRow(
            label: 'Start',
            date: startDate,
            time: startTime,
            isAllDay: isAllDay,
            enabled: true,
            onDateChanged: onStartDateChanged,
            onTimeChanged: onStartTimeChanged,
          ),
          const SizedBox(height: 12),

          // Edit mode - End date/time
          _DateTimeRow(
            label: 'End',
            date: endDate,
            time: endTime,
            isAllDay: isAllDay,
            enabled: true,
            onDateChanged: onEndDateChanged,
            onTimeChanged: onEndTimeChanged,
          ),
          const SizedBox(height: 16),

          // Edit mode - Recurrence
          _RepeatSelector(
            repeatSetting: repeatSetting,
            repeatOptions: repeatOptions,
            enabled: true,
            onRepeatChanged: onRepeatChanged,
          ),
        ] else ...[
          // View mode - All-day indicator
          if (agendaEvent.allDay) ...[
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Text('All day', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // View mode - Start date/time
          if (agendaEvent.startTime != null) ...[
            _DateTimeDisplay(
              label: 'Start',
              dateTime: agendaEvent.startTime!,
              isAllDay: agendaEvent.allDay,
            ),
            const SizedBox(height: 12),
          ],

          // View mode - End date/time
          if (agendaEvent.endTime != null) ...[
            _DateTimeDisplay(
              label: 'End',
              dateTime: agendaEvent.endTime!,
              isAllDay: agendaEvent.allDay,
            ),
            const SizedBox(height: 12),
          ],

          // View mode - Recurrence
          if (agendaEvent.recurrence.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.repeat,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Text(
                  agendaEvent.recurrence.first.toString().toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ],

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
              agendaEvent.timezone ?? 'East Africa Time',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
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
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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

class _DateTimeDisplay extends StatelessWidget {
  final String label;
  final DateTime dateTime;
  final bool isAllDay;

  const _DateTimeDisplay({
    required this.label,
    required this.dateTime,
    required this.isAllDay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.schedule,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                _formatDateTime(dateTime, isAllDay),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime, bool isAllDay) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dateStr;
    if (eventDate == today) {
      dateStr = 'Today';
    } else if (eventDate == today.add(const Duration(days: 1))) {
      dateStr = 'Tomorrow';
    } else if (eventDate == today.subtract(const Duration(days: 1))) {
      dateStr = 'Yesterday';
    } else {
      dateStr = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }

    if (isAllDay) {
      return dateStr;
    } else {
      final timeStr = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      return '$dateStr at $timeStr';
    }
  }
}

class _RepeatSelector extends StatelessWidget {
  final String repeatSetting;
  final List<String> repeatOptions;
  final bool enabled;
  final Function(String) onRepeatChanged;

  const _RepeatSelector({
    required this.repeatSetting,
    required this.repeatOptions,
    this.enabled = true,
    required this.onRepeatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _showRepeatDialog(context) : null,
      child: Row(
        children: [
          Icon(
            Icons.repeat,
            size: 20,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Text(
            repeatSetting,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: enabled
                  ? null
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
    );
  }

  void _showRepeatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Repeat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: repeatOptions.map((option) {
            return ListTile(
              title: Text(option),
              trailing: repeatSetting == option
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                onRepeatChanged(option);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _AttendeesSection extends StatelessWidget {
  final List<dynamic> attendees;
  final TextEditingController attendeesController;
  final bool enabled;
  final Function(List<Map<String, String>>) onAttendeesChanged;

  const _AttendeesSection({
    required this.attendees,
    required this.attendeesController,
    required this.enabled,
    required this.onAttendeesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendees',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        if (enabled) ...[
          // Add attendee input
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: attendeesController,
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
                        'displayName': value.split('@')[0], // Use email prefix as display name
                      };
                      final updatedAttendees = List<Map<String, String>>.from(attendees)..add(newAttendee);
                      onAttendeesChanged(updatedAttendees);
                      attendeesController.clear();
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () {
                  final value = attendeesController.text;
                  if (value.isNotEmpty && value.contains('@')) {
                    final newAttendee = <String, String>{
                      'email': value,
                      'displayName': value.split('@')[0],
                    };
                    final updatedAttendees = List<Map<String, String>>.from(attendees)..add(newAttendee);
                    onAttendeesChanged(updatedAttendees);
                    attendeesController.clear();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Display attendees
        if (attendees.isNotEmpty) ...[
          ...attendees.map(
            (attendee) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          attendee['email'] ?? '',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (enabled) ...[
                    IconButton(
                      onPressed: () {
                        final updatedAttendees = List<Map<String, String>>.from(attendees)..remove(attendee);
                        onAttendeesChanged(updatedAttendees);
                      },
                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _AdditionalInfoSection extends StatelessWidget {
  final AgendaEvent agendaEvent;

  const _AdditionalInfoSection({required this.agendaEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        // Status
        if (agendaEvent.status != null) ...[
          _InfoRow(
            icon: Icons.info_outline,
            label: 'Status',
            value: agendaEvent.status!,
          ),
          const SizedBox(height: 8),
        ],

        // Created date
        if (agendaEvent.created != null) ...[
          _InfoRow(
            icon: Icons.schedule,
            label: 'Created',
            value: _formatDate(agendaEvent.created!),
          ),
          const SizedBox(height: 8),
        ],

        // Last updated
        if (agendaEvent.updated != null) ...[
          _InfoRow(
            icon: Icons.update,
            label: 'Last updated',
            value: _formatDate(agendaEvent.updated!),
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
