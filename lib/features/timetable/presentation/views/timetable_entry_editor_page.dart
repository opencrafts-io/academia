import 'package:academia/core/core.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:uuid/uuid.dart';

/// Page for adding or editing timetable entries
class TimetableEntryEditorPage extends StatefulWidget {
  final String courseId;
  final String courseName;
  final Color courseColor;
  final TimetableEntryEntity? entry;

  const TimetableEntryEditorPage({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.courseColor,
    this.entry,
  });

  @override
  State<TimetableEntryEditorPage> createState() =>
      _TimetableEntryEditorPageState();
}

class _TimetableEntryEditorPageState extends State<TimetableEntryEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late int _durationMinutes;
  late TextEditingController _buildingController;
  late TextEditingController _roomController;
  late TextEditingController _locationController;
  String? _rrule;

  @override
  void initState() {
    super.initState();

    if (widget.entry != null) {
      // Editing existing entry
      _startDate = DateTime(
        widget.entry!.startDate.year,
        widget.entry!.startDate.month,
        widget.entry!.startDate.day,
      );
      _startTime = TimeOfDay.fromDateTime(widget.entry!.startDate);
      _durationMinutes = widget.entry!.durationMinutes;
      _buildingController = TextEditingController(text: widget.entry!.building);
      _roomController = TextEditingController(text: widget.entry!.room);
      _locationController = TextEditingController(text: widget.entry!.location);
      _rrule = widget.entry!.rrule;
    } else {
      // Creating new entry
      _startDate = DateTime.now();
      _startTime = TimeOfDay.now();
      _durationMinutes = 60;
      _buildingController = TextEditingController();
      _roomController = TextEditingController();
      _locationController = TextEditingController();
      _rrule = null;
    }
  }

  @override
  void dispose() {
    _buildingController.dispose();
    _roomController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEditing = widget.entry != null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(isEditing ? 'Edit Class' : 'New Class'),
            backgroundColor: widget.courseColor,
            foregroundColor: _getContrastColor(widget.courseColor),
            actions: [
              TextButton(
                onPressed: _saveEntry,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: _getContrastColor(widget.courseColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course name display
                    Card(
                      elevation: 0,
                      color: widget.courseColor.withAlpha(25),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: widget.courseColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Course',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.courseName,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Date and Time Section
                    Text(
                      'When',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date picker
                    _buildDateTimeTile(
                      context,
                      icon: Icons.calendar_today,
                      label: 'Date',
                      value: _formatDate(_startDate),
                      onTap: () => _selectDate(context),
                    ),

                    const SizedBox(height: 8),

                    // Time picker
                    _buildDateTimeTile(
                      context,
                      icon: Icons.access_time,
                      label: 'Start Time',
                      value: _startTime.format(context),
                      onTap: () => _selectTime(context),
                    ),

                    const SizedBox(height: 8),

                    // Duration selector
                    _buildDurationSelector(context, theme, colorScheme),

                    const SizedBox(height: 24),

                    // Recurrence Section
                    Text(
                      'Recurrence',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    RRuleEditorWidget(
                      initialRRule: _rrule,
                      onRRuleChanged: (newRRule) {
                        setState(() {
                          _rrule = newRRule;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // Location Section
                    Text(
                      'Location',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: _buildingController,
                      decoration: InputDecoration(
                        labelText: 'Building',
                        hintText: 'e.g., Science Block',
                        prefixIcon: const Icon(Icons.apartment),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: _roomController,
                      decoration: InputDecoration(
                        labelText: 'Room',
                        hintText: 'e.g., Room 301',
                        prefixIcon: const Icon(Icons.meeting_room),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location/Campus',
                        hintText: 'e.g., Main Campus',
                        prefixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationSelector(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final durations = [30, 45, 60, 90, 120, 180];

    return Card(
      elevation: 0,
      color: colorScheme.tertiaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withAlpha(64)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timelapse, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Duration',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: durations.map((duration) {
                final isSelected = _durationMinutes == duration;
                return ChoiceChip(
                  label: Text('$duration min'),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _durationMinutes = duration;
                      });
                    }
                  },
                  selectedColor: colorScheme.primaryContainer,
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );

    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == tomorrow) {
      return 'Tomorrow';
    } else {
      final months = [
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
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }

  void _saveEntry() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Combine date and time
    final startDateTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    String getUserID() {
      final state = context.read<ProfileBloc>().state;
      if (state is ProfileLoadedState) {
        return state.profile.id;
      }
      return '';
    }

    final entry = TimetableEntryEntity(
      id: widget.entry?.id ?? const Uuid().v4(),
      serverId: widget.entry?.serverId,
      userId: getUserID(),
      institutionId: widget.entry?.institutionId ?? 0,
      courseId: widget.courseId,
      timetableId: widget.entry?.timetableId ?? '',
      rrule: _rrule,
      startDate: startDateTime,
      durationMinutes: _durationMinutes,
      building: _buildingController.text.isEmpty
          ? null
          : _buildingController.text,
      room: _roomController.text.isEmpty ? null : _roomController.text,
      location: _locationController.text.isEmpty
          ? null
          : _locationController.text,
      isSynced: false,
      isDeleted: false,
      lastUpdated: DateTime.now(),
    );

    context.read<TimetableEntryBloc>().add(
      CreateOrUpdateTimetableEntryEvent(entry: entry),
    );

    Navigator.of(context).pop();
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
