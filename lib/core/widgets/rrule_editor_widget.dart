import 'package:flutter/material.dart';

class RRuleEditorWidget extends StatefulWidget {
  final String? initialRRule;
  final Function(String?) onRRuleChanged;

  const RRuleEditorWidget({
    super.key,
    this.initialRRule,
    required this.onRRuleChanged,
  });

  @override
  State<RRuleEditorWidget> createState() => _RRuleEditorWidgetState();
}

class _RRuleEditorWidgetState extends State<RRuleEditorWidget> {
  RecurrenceType _recurrenceType = RecurrenceType.none;
  Set<DayOfWeek> _selectedDays = {};
  int _interval = 1;

  @override
  void initState() {
    super.initState();
    if (widget.initialRRule != null && widget.initialRRule!.isNotEmpty) {
      _parseRRule(widget.initialRRule!);
    }
  }

  void _parseRRule(String rrule) {
    if (rrule.contains('FREQ=WEEKLY')) {
      _recurrenceType = RecurrenceType.weekly;

      // Extract selected days
      final dayMap = {
        'MO': DayOfWeek.monday,
        'TU': DayOfWeek.tuesday,
        'WE': DayOfWeek.wednesday,
        'TH': DayOfWeek.thursday,
        'FR': DayOfWeek.friday,
        'SA': DayOfWeek.saturday,
        'SU': DayOfWeek.sunday,
      };

      // Extract only the days listed after BYDAY= specifically to avoid false positives
      final byDayMatch = RegExp(r'BYDAY=([^;]+)').firstMatch(rrule);
      if (byDayMatch != null) {
        final byDayValue = byDayMatch.group(1)!;
        for (final entry in dayMap.entries) {
          if (byDayValue.contains(entry.key)) {
            _selectedDays.add(entry.value);
          }
        }
      }

      // Extract interval if present
      final intervalMatch = RegExp(r'INTERVAL=(\d+)').firstMatch(rrule);
      if (intervalMatch != null) {
        _interval = int.parse(intervalMatch.group(1)!);
      }
    } else if (rrule.contains('FREQ=DAILY')) {
      _recurrenceType = RecurrenceType.daily;
    }
  }

  String? _buildRRule() {
    if (_recurrenceType == RecurrenceType.none) {
      return null;
    }

    if (_recurrenceType == RecurrenceType.daily) {
      return 'FREQ=DAILY';
    }

    if (_recurrenceType == RecurrenceType.weekly) {
      if (_selectedDays.isEmpty) {
        return null;
      }

      final dayMap = {
        DayOfWeek.monday: 'MO',
        DayOfWeek.tuesday: 'TU',
        DayOfWeek.wednesday: 'WE',
        DayOfWeek.thursday: 'TH',
        DayOfWeek.friday: 'FR',
        DayOfWeek.saturday: 'SA',
        DayOfWeek.sunday: 'SU',
      };

      final days = _selectedDays.map((day) => dayMap[day]!).join(',');

      if (_interval > 1) {
        return 'FREQ=WEEKLY;INTERVAL=$_interval;BYDAY=$days';
      }

      return 'FREQ=WEEKLY;BYDAY=$days';
    }

    return null;
  }

  void _updateRRule() {
    widget.onRRuleChanged(_buildRRule());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.repeat, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Recurrence',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Recurrence type selector
            SegmentedButton<RecurrenceType>(
              segments: const [
                ButtonSegment(
                  value: RecurrenceType.none,
                  label: Text('One-time'),
                  icon: Icon(Icons.event),
                ),
                ButtonSegment(
                  value: RecurrenceType.daily,
                  label: Text('Daily'),
                  icon: Icon(Icons.today),
                ),
                ButtonSegment(
                  value: RecurrenceType.weekly,
                  label: Text('Weekly'),
                  icon: Icon(Icons.calendar_view_week),
                ),
              ],
              selected: {_recurrenceType},
              onSelectionChanged: (Set<RecurrenceType> selection) {
                setState(() {
                  _recurrenceType = selection.first;
                  _updateRRule();
                });
              },
              multiSelectionEnabled: false,
            ),

            // Weekly options
            if (_recurrenceType == RecurrenceType.weekly) ...[
              const SizedBox(height: 24),

              Text(
                'Repeat on',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 12),

              // Day selector chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: DayOfWeek.values.map((day) {
                  final isSelected = _selectedDays.contains(day);
                  return FilterChip(
                    label: Text(_getDayLabel(day)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedDays.add(day);
                        } else {
                          _selectedDays.remove(day);
                        }
                        _updateRRule();
                      });
                    },
                    showCheckmark: false,
                    selectedColor: colorScheme.primaryContainer,
                    backgroundColor: colorScheme.surface,
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // Interval selector
              Row(
                children: [
                  Text('Every', style: theme.textTheme.bodyMedium),
                  const SizedBox(width: 12),
                  DropdownButton<int>(
                    value: _interval,
                    items: List.generate(4, (index) => index + 1)
                        .map(
                          (i) => DropdownMenuItem(value: i, child: Text('$i')),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _interval = value;
                          _updateRRule();
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _interval == 1 ? 'week' : 'weeks',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],

            // Preview
            if (_recurrenceType != RecurrenceType.none) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getRecurrenceDescription(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getDayLabel(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.monday:
        return 'Mon';
      case DayOfWeek.tuesday:
        return 'Tue';
      case DayOfWeek.wednesday:
        return 'Wed';
      case DayOfWeek.thursday:
        return 'Thu';
      case DayOfWeek.friday:
        return 'Fri';
      case DayOfWeek.saturday:
        return 'Sat';
      case DayOfWeek.sunday:
        return 'Sun';
    }
  }

  String _getRecurrenceDescription() {
    if (_recurrenceType == RecurrenceType.daily) {
      return 'This class repeats every day';
    }

    if (_recurrenceType == RecurrenceType.weekly) {
      if (_selectedDays.isEmpty) {
        return 'Please select at least one day';
      }

      final days = _selectedDays.map(_getDayLabel).join(', ');
      final interval = _interval > 1 ? 'every $_interval weeks' : 'every week';
      return 'This class repeats $interval on $days';
    }

    return 'This is a one-time class';
  }
}

enum RecurrenceType { none, daily, weekly }

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
