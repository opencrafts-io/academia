import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../application/lock_in_service.dart';
import '../domain/lock_rule.dart';

class LockRuleEditorPage extends StatefulWidget {
  const LockRuleEditorPage({super.key, required this.service, this.rule});

  final LockInService service;
  final LockRule? rule;

  @override
  State<LockRuleEditorPage> createState() => _LockRuleEditorPageState();
}

class _LockRuleEditorPageState extends State<LockRuleEditorPage> {
  late final TextEditingController _name;
  late Set<int> _weekdays;
  late int _startMinutes;
  late int _endMinutes;
  final _selectedApps = <BlockedApp>{};
  late Future<List<BlockedApp>> _apps;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final rule = widget.rule;
    _name = TextEditingController(text: rule?.name ?? '');
    _weekdays = {
      ...(rule?.weekdays ??
          {
            DateTime.monday,
            DateTime.tuesday,
            DateTime.wednesday,
            DateTime.thursday,
            DateTime.friday,
          }),
    };
    _startMinutes = rule?.startMinutes ?? 9 * 60;
    _endMinutes = rule?.endMinutes ?? 17 * 60;
    _selectedApps.addAll(rule?.apps ?? const []);
    _apps = widget.service.installedApps();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool start) async {
    final value = start ? _startMinutes : _endMinutes;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: value ~/ 60, minute: value % 60),
    );
    if (picked != null) {
      setState(() {
        if (start) {
          _startMinutes = picked.hour * 60 + picked.minute;
        } else {
          _endMinutes = picked.hour * 60 + picked.minute;
        }
      });
    }
  }

  Future<void> _save() async {
    final rule = LockRule(
      id: widget.rule?.id ?? 'lock-in-${DateTime.now().microsecondsSinceEpoch}',
      name: _name.text.trim(),
      apps: _selectedApps.toList(growable: false),
      weekdays: _weekdays,
      startMinutes: _startMinutes,
      endMinutes: _endMinutes,
    );
    if (!rule.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add a name, app, day, and a non-zero time window.'),
        ),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.service.saveRule(rule);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rule == null ? 'New Lock In rule' : 'Edit Lock In rule',
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton.icon(
          key: const Key('lock-in-save-action'),
          onPressed: _saving ? null : _save,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: WavyCircularProgressIndicator(
                    size: 20,
                    amplitude: 2,
                    frequency: 8,
                  ),
                )
              : const Icon(Icons.check_rounded),
          label: Text(_saving ? 'Saving…' : 'Save rule'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
        ),
      ),
      body: FutureBuilder<List<BlockedApp>>(
        future: _apps,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Semantics(
                label: 'Loading installed apps',
                child: WavyCircularProgressIndicator(
                  size: 48,
                  amplitude: 3,
                  frequency: 8,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Rule name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Text('Days', style: Theme.of(context).textTheme.titleSmall),
              Wrap(
                spacing: 8,
                children: List.generate(7, (index) {
                  final day = index + 1;
                  return FilterChip(
                    label: Text(weekdayLabels[index]),
                    selected: _weekdays.contains(day),
                    onSelected: (selected) => setState(
                      () =>
                          selected ? _weekdays.add(day) : _weekdays.remove(day),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickTime(true),
                      child: Text(
                        'Start ${TimeOfDay(hour: _startMinutes ~/ 60, minute: _startMinutes % 60).format(context)}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickTime(false),
                      child: Text(
                        'End ${TimeOfDay(hour: _endMinutes ~/ 60, minute: _endMinutes % 60).format(context)}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Apps to block',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              ...snapshot.requireData.map(
                (app) => CheckboxListTile(
                  value: _selectedApps.contains(app),
                  secondary: _BlockedAppIcon(app: app),
                  title: Text(app.displayName),
                  subtitle: Text(app.identifier),
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (selected) => setState(
                    () => selected == true
                        ? _selectedApps.add(app)
                        : _selectedApps.remove(app),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

class _BlockedAppIcon extends StatelessWidget {
  const _BlockedAppIcon({required this.app});

  final BlockedApp app;

  @override
  Widget build(BuildContext context) {
    final icon = app.icon;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox.square(
        dimension: 40,
        child: icon == null
            ? ColoredBox(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Center(
                  child: Text(
                    app.displayName.isEmpty
                        ? '?'
                        : app.displayName.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: .w700,
                    ),
                  ),
                ),
              )
            : Image.memory(
                icon,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
      ),
    );
  }
}
