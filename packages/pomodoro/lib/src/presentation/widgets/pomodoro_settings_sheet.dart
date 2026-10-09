import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Lets the user tune session lengths and the long-break interval.
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
  final _formKey = GlobalKey<FormState>();
  late final _focusController = _controller(widget.focusDuration.inMinutes);
  late final _shortBreakController = _controller(
    widget.shortBreakDuration.inMinutes,
  );
  late final _longBreakController = _controller(
    widget.longBreakDuration.inMinutes,
  );
  late final _sessionsController = _controller(widget.sessionsBeforeLongBreak);

  TextEditingController _controller(int value) =>
      TextEditingController(text: value.toString());

  @override
  void dispose() {
    _focusController.dispose();
    _shortBreakController.dispose();
    _longBreakController.dispose();
    _sessionsController.dispose();
    super.dispose();
  }

  void _adjust(TextEditingController controller, int min, int max, int delta) {
    final current = (int.tryParse(controller.text) ?? min).clamp(min, max);
    final next = (current + delta).clamp(min, max).toString();
    controller.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: next.length),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSave(
      focusDuration: Duration(minutes: int.parse(_focusController.text)),
      shortBreakDuration: Duration(
        minutes: int.parse(_shortBreakController.text),
      ),
      longBreakDuration: Duration(
        minutes: int.parse(_longBreakController.text),
      ),
      sessionsBeforeLongBreak: int.parse(_sessionsController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(
        leading: IconButton(
          tooltip: 'Close settings',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text('Timer settings'),
        actions: [TextButton(onPressed: _save, child: const Text('Save'))],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MinutesStepper(
                  label: 'Focus',
                  unit: 'min',
                  controller: _focusController,
                  min: 5,
                  max: 90,
                  onStep: (delta) => _adjust(_focusController, 5, 90, delta),
                ),
                _MinutesStepper(
                  label: 'Short break',
                  unit: 'min',
                  controller: _shortBreakController,
                  min: 1,
                  max: 30,
                  onStep: (delta) =>
                      _adjust(_shortBreakController, 1, 30, delta),
                ),
                _MinutesStepper(
                  label: 'Long break',
                  unit: 'min',
                  controller: _longBreakController,
                  min: 5,
                  max: 60,
                  onStep: (delta) =>
                      _adjust(_longBreakController, 5, 60, delta),
                ),
                _MinutesStepper(
                  label: 'Sessions before long break',
                  unit: 'sessions',
                  controller: _sessionsController,
                  min: 2,
                  max: 8,
                  onStep: (delta) => _adjust(_sessionsController, 2, 8, delta),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MinutesStepper extends StatelessWidget {
  const _MinutesStepper({
    required this.label,
    required this.unit,
    required this.controller,
    required this.min,
    required this.max,
    required this.onStep,
  });

  final String label;
  final String unit;
  final TextEditingController controller;
  final int min;
  final int max;
  final ValueChanged<int> onStep;

  String? _validate(String? value) {
    final number = int.tryParse(value ?? '');
    if (number == null) return 'Enter a number';
    if (number < min || number > max) return '$min–$max $unit';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final minutes = int.tryParse(value.text);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
              IconButton(
                tooltip: 'Decrease $label',
                onPressed: minutes != null && minutes <= min
                    ? null
                    : () => onStep(-1),
                icon: const Icon(Icons.remove_circle_outline_rounded),
              ),
              SizedBox(
                width: 92,
                child: TextFormField(
                  controller: controller,
                  validator: _validate,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixText: unit,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Increase $label',
                onPressed: minutes != null && minutes >= max
                    ? null
                    : () => onStep(1),
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
