import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDateTime;

  const CountdownTimer({super.key, required this.targetDateTime});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _updateRemainingTime();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    final difference = widget.targetDateTime.difference(now);

    setState(() {
      _remainingTime = difference.isNegative ? Duration.zero : difference;
    });
  }

  // Helper to get time values
  Map<String, int> _getTimeValues(Duration duration) {
    return {
      'days': duration.inDays,
      'hours': duration.inHours % 24,
      'minutes': duration.inMinutes % 60,
      'seconds': duration.inSeconds % 60,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final timeValues = _getTimeValues(_remainingTime);

    if (_remainingTime == Duration.zero) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'Exam time!',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Time to Next Exam',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TimeDigit(
                value: timeValues['days']!,
                label: 'DAYS',
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
              _TimeSeparator(colorScheme: colorScheme),
              _TimeDigit(
                value: timeValues['hours']!,
                label: 'HOURS',
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
              _TimeSeparator(colorScheme: colorScheme),
              _TimeDigit(
                value: timeValues['minutes']!,
                label: 'MINUTES',
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
              _TimeSeparator(colorScheme: colorScheme),
              _TimeDigit(
                value: timeValues['seconds']!,
                label: 'SECONDS',
                colorScheme: colorScheme,
                textTheme: theme.textTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeDigit extends StatelessWidget {
  final int value;
  final String label;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _TimeDigit({
    required this.value,
    required this.label,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _TimeSeparator extends StatelessWidget {
  final ColorScheme colorScheme;

  const _TimeSeparator({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
