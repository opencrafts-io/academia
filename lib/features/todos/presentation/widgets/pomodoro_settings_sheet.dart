import 'package:flutter/material.dart';

/// Lets the user tune the focus/break durations and how many focus
/// sessions happen before a long break.
class PomodoroSettingsSheet extends StatefulWidget {
  const PomodoroSettingsSheet({
    super.key,
    required this.focusDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.sessionsBeforeLongBreak,
    required this.onSave,
  });

  final Duration focusDuration;
  final Duration shortBreakDuration;
  final Duration longBreakDuration;
  final int sessionsBeforeLongBreak;
  final void Function({
    required Duration focusDuration,
    required Duration shortBreakDuration,
    required Duration longBreakDuration,
    required int sessionsBeforeLongBreak,
  })
  onSave;

  @override
  State<PomodoroSettingsSheet> createState() => _PomodoroSettingsSheetState();
}

class _PomodoroSettingsSheetState extends State<PomodoroSettingsSheet> {
  late int _focusMinutes = widget.focusDuration.inMinutes;
  late int _shortBreakMinutes = widget.shortBreakDuration.inMinutes;
  late int _longBreakMinutes = widget.longBreakDuration.inMinutes;
  late int _sessionsBeforeLongBreak = widget.sessionsBeforeLongBreak;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Timer settings",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _MinutesStepper(
            label: "Focus",
            minutes: _focusMinutes,
            min: 5,
            max: 90,
            onChanged: (v) => setState(() => _focusMinutes = v),
          ),
          _MinutesStepper(
            label: "Short break",
            minutes: _shortBreakMinutes,
            min: 1,
            max: 30,
            onChanged: (v) => setState(() => _shortBreakMinutes = v),
          ),
          _MinutesStepper(
            label: "Long break",
            minutes: _longBreakMinutes,
            min: 5,
            max: 60,
            onChanged: (v) => setState(() => _longBreakMinutes = v),
          ),
          _MinutesStepper(
            label: "Sessions before long break",
            minutes: _sessionsBeforeLongBreak,
            min: 2,
            max: 8,
            suffix: "",
            onChanged: (v) => setState(() => _sessionsBeforeLongBreak = v),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.onSave(
                  focusDuration: Duration(minutes: _focusMinutes),
                  shortBreakDuration: Duration(minutes: _shortBreakMinutes),
                  longBreakDuration: Duration(minutes: _longBreakMinutes),
                  sessionsBeforeLongBreak: _sessionsBeforeLongBreak,
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}

class _MinutesStepper extends StatelessWidget {
  const _MinutesStepper({
    required this.label,
    required this.minutes,
    required this.min,
    required this.max,
    required this.onChanged,
    this.suffix = " min",
  });

  final String label;
  final int minutes;
  final int min;
  final int max;
  final String suffix;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: minutes > min ? () => onChanged(minutes - 1) : null,
          ),
          SizedBox(
            width: 48,
            child: Text(
              "$minutes$suffix",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: minutes < max ? () => onChanged(minutes + 1) : null,
          ),
        ],
      ),
    );
  }
}
