import 'package:flutter/material.dart';
import 'package:academia/features/course/domain/entities/course_entity.dart';
import 'package:academia/features/timetable/domain/entities/timetable_entry_entity.dart';
import 'package:intl/intl.dart';

/// Card widget to display a timetable entry
class TimetableEntryCard extends StatelessWidget {
  final TimetableEntryEntity entry;
  final CourseEntity course;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TimetableEntryCard({
    super.key,
    required this.entry,
    required this.course,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final courseColor = course.color ?? const Color(0xFF1E1E2E);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color indicator strip
            Container(height: 4, color: courseColor),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time and duration
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 20,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(entry.startDate),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${entry.durationMinutes} min',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: colorScheme.error,
                        ),
                        onPressed: onDelete,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),

                  // Recurrence info
                  if (entry.rrule != null && entry.rrule!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.repeat,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _parseRRuleToReadable(entry.rrule!),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Location
                  if (entry.building != null ||
                      entry.room != null ||
                      entry.location != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _buildLocationString(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  String _parseRRuleToReadable(String rrule) {
    // Simple parser for common RRULE patterns
    if (rrule.contains('FREQ=WEEKLY')) {
      final days = _extractDays(rrule);
      if (days.isNotEmpty) {
        return 'Repeats weekly on ${days.join(', ')}';
      }
      return 'Repeats weekly';
    } else if (rrule.contains('FREQ=DAILY')) {
      return 'Repeats daily';
    } else if (rrule.contains('FREQ=MONTHLY')) {
      return 'Repeats monthly';
    }
    return 'Recurring class';
  }

  List<String> _extractDays(String rrule) {
    final dayMap = {
      'MO': 'Mon',
      'TU': 'Tue',
      'WE': 'Wed',
      'TH': 'Thu',
      'FR': 'Fri',
      'SA': 'Sat',
      'SU': 'Sun',
    };

    final days = <String>[];
    
    // Extract the BYDAY part of the RRULE specifically to avoid false positives
    // like matching 'MO' or 'TH' inside 'MONTHLY' or 'WE' inside 'WEEKLY'.
    final byDayMatch = RegExp(r'BYDAY=([^;]+)').firstMatch(rrule);
    
    if (byDayMatch != null) {
      final byDayValue = byDayMatch.group(1)!;
      // The day order in dayMap ensures we maintain Mon-Sun order in the result
      for (final entry in dayMap.entries) {
        if (byDayValue.contains(entry.key)) {
          days.add(entry.value);
        }
      }
    }

    return days;
  }

  String _buildLocationString() {
    final parts = <String>[];

    if (entry.building != null && entry.building!.isNotEmpty) {
      parts.add(entry.building!);
    }

    if (entry.room != null && entry.room!.isNotEmpty) {
      parts.add(entry.room!);
    }

    if (entry.location != null && entry.location!.isNotEmpty) {
      parts.add(entry.location!);
    }

    return parts.isEmpty ? 'No location specified' : parts.join(', ');
  }
}
