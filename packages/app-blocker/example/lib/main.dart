import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:app_blocker/app_blocker.dart';

void main() => runApp(const AppBlockerExampleApp());

// ─────────────────────────────────────────────────────────────────────────────
// App shell
// ─────────────────────────────────────────────────────────────────────────────

/// Example app demonstrating the app_blocker plugin.
///
/// This app shows how to use the app_blocker package to block and unblock
/// apps on Android and iOS, manage time-based schedules, create focus
/// profiles, and listen to real-time block events.
class AppBlockerExampleApp extends StatelessWidget {
  const AppBlockerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Blocker Demo',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const _Shell(),
    );
  }
}

class _Shell extends StatefulWidget {
  const _Shell();

  @override
  State<_Shell> createState() => _ShellState();
}

class _ShellState extends State<_Shell> {
  int _tab = 0;
  final _blockingTabKey = GlobalKey<_BlockingTabState>();
  final _schedulesTabKey = GlobalKey<_SchedulesTabState>();
  final _profilesTabKey = GlobalKey<_ProfilesTabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          _BlockingTab(
            key: _blockingTabKey,
            onUnblockAll: () {
              if (Platform.isAndroid) _schedulesTabKey.currentState?._load();
              _profilesTabKey.currentState?._load();
            },
          ),
          _SchedulesTab(key: _schedulesTabKey),
          _ProfilesTab(key: _profilesTabKey),
          const _EventsTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) {
          setState(() => _tab = i);
          if (i == 0) _blockingTabKey.currentState?._refreshBlocked();
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.block), label: 'Blocking'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'Schedules'),
          NavigationDestination(icon: Icon(Icons.view_list), label: 'Profiles'),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Events',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Blocking tab
// ─────────────────────────────────────────────────────────────────────────────

class _BlockingTab extends StatefulWidget {
  const _BlockingTab({super.key, this.onUnblockAll});

  final VoidCallback? onUnblockAll;

  @override
  State<_BlockingTab> createState() => _BlockingTabState();
}

class _BlockingTabState extends State<_BlockingTab>
    with WidgetsBindingObserver {
  final _blocker = AppBlocker.instance;

  BlockerPermissionStatus? _permission;
  BlockerCapabilities? _caps;
  List<AppInfo> _apps = [];
  Set<String> _selectedApps = {};
  List<String> _blockedApps = [];
  bool _loadingApps = false;
  BlockScreenConfig? _blockScreenConfig;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
    _loadCaps();
    _refreshBlocked();
    _loadBlockScreenConfig();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Re-check permissions automatically when the user returns from Settings.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    try {
      final s = await _blocker.checkPermission();
      if (mounted) setState(() => _permission = s);
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _loadCaps() async {
    try {
      final c = await _blocker.getCapabilities();
      if (mounted) setState(() => _caps = c);
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _refreshBlocked() async {
    try {
      final list = await _blocker.getBlockedApps();
      if (mounted) setState(() => _blockedApps = list);
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _loadBlockScreenConfig() async {
    try {
      final config = await _blocker.getBlockScreenConfig();
      if (mounted) setState(() => _blockScreenConfig = config);
    } catch (_) {}
  }

  Future<void> _requestPermission() async {
    try {
      final s = await _blocker.requestPermission();
      if (mounted) setState(() => _permission = s);
    } catch (e) {
      _err('$e');
    }
  }

  Future<Set<String>?> _showAppPicker({Set<String> initial = const {}}) async {
    if (Platform.isIOS) {
      setState(() => _loadingApps = true);
      try {
        final picked = await _blocker.getApps();
        return picked.map((a) => a.packageName).toSet();
      } catch (e) {
        _err('$e');
        return null;
      } finally {
        if (mounted) setState(() => _loadingApps = false);
      }
    }

    if (_apps.isEmpty) {
      setState(() => _loadingApps = true);
      try {
        _apps = await _blocker.getApps();
      } catch (e) {
        _err('$e');
        setState(() => _loadingApps = false);
        return null;
      }
      setState(() => _loadingApps = false);
    }

    if (!mounted) return null;
    return showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AppPicker(apps: _apps, initial: initial),
    );
  }

  Future<void> _selectApps() async {
    final selected = await _showAppPicker(initial: _selectedApps);
    if (selected != null) setState(() => _selectedApps = selected);
  }

  Future<void> _blockSelected() async {
    if (_selectedApps.isEmpty) return;
    try {
      await _blocker.blockApps(_selectedApps.toList());
      _snack('${_selectedApps.length} app(s) blocked');
      setState(() => _selectedApps = {});
      _refreshBlocked();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _unblockSelected() async {
    if (_selectedApps.isEmpty) return;
    try {
      await _blocker.unblockApps(_selectedApps.toList());
      _snack('${_selectedApps.length} app(s) unblocked');
      setState(() => _selectedApps = {});
      _refreshBlocked();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _blockAll() async {
    try {
      await _blocker.blockAll();
      _snack('All apps blocked');
      _refreshBlocked();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _unblockAll() async {
    try {
      await _blocker.unblockAll();
      _snack('All apps unblocked');
      _refreshBlocked();
      widget.onUnblockAll?.call();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _checkAppStatus() async {
    final selected = await _showAppPicker();
    if (selected == null || selected.isEmpty) return;
    try {
      final status = await _blocker.getAppStatus(selected.first);
      _snack('"${selected.first}" is ${status.name}');
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _configureBlockScreen() async {
    final saved = await showDialog<BlockScreenConfig>(
      context: context,
      builder: (_) => _BlockScreenConfigDialog(
        blocker: _blocker,
        initial: _blockScreenConfig,
      ),
    );
    if (saved != null) setState(() => _blockScreenConfig = saved);
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _err(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final granted = _permission == BlockerPermissionStatus.granted;

    return Scaffold(
      appBar: AppBar(title: const Text('Blocking')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Permissions & capabilities
          _Section(
            title: 'Permissions',
            children: [
              Row(
                children: [
                  Icon(
                    granted ? Icons.check_circle : Icons.warning,
                    color: granted ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text('Status: ${_permission?.name ?? '…'}'),
                ],
              ),
              if (!granted && Platform.isAndroid) ...[
                const SizedBox(height: 8),
                Text(
                  'Android requires 2 permissions: Accessibility service '
                  'and Alarms & reminders (exact alarm). '
                  'Tap "Grant next" to open the relevant Settings screen. '
                  'Return here and tap again until all are granted.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonal(
                    onPressed: _checkPermission,
                    child: const Text('Check'),
                  ),
                  FilledButton(
                    onPressed: granted ? null : _requestPermission,
                    child: const Text('Grant next'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Capabilities
          _Section(
            title: 'Capabilities',
            children: [
              if (_caps == null)
                Text(
                  'Not loaded',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _CapChip('Block apps', _caps!.canBlockApps),
                    _CapChip('Block screen', _caps!.canCustomizeBlockScreen),
                    _CapChip('Shield', _caps!.canUseSystemShield),
                    _CapChip('Schedule', _caps!.canSchedule),
                    _CapChip('App list', _caps!.canGetInstalledApps),
                    _CapChip('Picker', _caps!.canShowActivityPicker),
                  ],
                ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: _loadCaps,
                child: const Text('Refresh capabilities'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Block list
          _Section(
            title: 'Currently Blocked Apps (${_blockedApps.length})',
            trailing: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshBlocked,
            ),
            children: [
              if (_blockedApps.isEmpty)
                Text(
                  'None',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              else
                ..._blockedApps.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(p, style: theme.textTheme.bodySmall),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () async {
                            await _blocker.unblockApps([p]);
                            _refreshBlocked();
                          },
                          child: const Text('Unblock'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Block / unblock selected apps
          _Section(
            title: 'Block / Unblock Apps',
            children: [
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: _loadingApps ? null : _selectApps,
                      child: _loadingApps
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _selectedApps.isEmpty
                                  ? 'Select Apps…'
                                  : '${_selectedApps.length} app(s) selected',
                            ),
                    ),
                  ),
                  if (_selectedApps.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: 'Clear selection',
                      onPressed: () => setState(() => _selectedApps = {}),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _selectedApps.isNotEmpty
                          ? _blockSelected
                          : null,
                      child: const Text('Block'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _selectedApps.isNotEmpty
                          ? _unblockSelected
                          : null,
                      child: const Text('Unblock'),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _blockAll,
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                      child: const Text('Block all apps'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _unblockAll,
                      child: const Text('Unblock all apps'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Check app status
          _Section(
            title: 'App Status',
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _checkAppStatus,
                  child: const Text('Check App Status…'),
                ),
              ),
            ],
          ),

          // Block screen config (Android only)
          if (Platform.isAndroid) ...[
            const SizedBox(height: 12),
            _Section(
              title: 'Block Screen Config (Android)',
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _configureBlockScreen,
                    child: const Text('Configure Block Screen…'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// Block screen config dialog (Android-only)
class _BlockScreenConfigDialog extends StatefulWidget {
  const _BlockScreenConfigDialog({required this.blocker, this.initial});
  final AppBlocker blocker;
  final BlockScreenConfig? initial;

  @override
  State<_BlockScreenConfigDialog> createState() =>
      _BlockScreenConfigDialogState();
}

class _BlockScreenConfigDialogState extends State<_BlockScreenConfigDialog> {
  late final TextEditingController _title;
  late final TextEditingController _subtitle;
  late final TextEditingController _message;

  @override
  void initState() {
    super.initState();
    final c = widget.initial;
    _title = TextEditingController(text: c?.title ?? 'App Blocked');
    _subtitle = TextEditingController(text: c?.subtitle ?? 'Take a break!');
    _message = TextEditingController(
      text: c?.message ?? 'This app is currently blocked.',
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _subtitle.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Block Screen Config'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _subtitle,
            decoration: const InputDecoration(labelText: 'Subtitle'),
          ),
          TextField(
            controller: _message,
            decoration: const InputDecoration(labelText: 'Message'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            final config = BlockScreenConfig(
              title: _title.text,
              subtitle: _subtitle.text,
              message: _message.text,
            );
            try {
              await widget.blocker.setBlockScreenConfig(config);
              if (context.mounted) {
                Navigator.pop(context, config);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Block screen config saved')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$e'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Schedules tab
// ─────────────────────────────────────────────────────────────────────────────

class _SchedulesTab extends StatefulWidget {
  const _SchedulesTab({super.key});

  @override
  State<_SchedulesTab> createState() => _SchedulesTabState();
}

class _SchedulesTabState extends State<_SchedulesTab> {
  final _blocker = AppBlocker.instance;
  List<BlockSchedule> _schedules = [];
  bool _supported = true;

  @override
  void initState() {
    super.initState();
    _blocker.getCapabilities().then((caps) {
      if (mounted) {
        _supported = caps.canSchedule;
        if (_supported) _load();
      }
    });
  }

  Future<void> _load() async {
    try {
      final s = await _blocker.getSchedules();
      if (mounted) setState(() => _schedules = s);
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _toggle(BlockSchedule s) async {
    try {
      if (s.enabled) {
        await _blocker.disableSchedule(s.id);
      } else {
        await _blocker.enableSchedule(s.id);
      }
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _delete(String id) async {
    try {
      await _blocker.removeSchedule(id);
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _add() async {
    final schedule = await showDialog<BlockSchedule>(
      context: context,
      builder: (_) => const _ScheduleDialog(),
    );
    if (schedule == null) return;
    try {
      await _blocker.addSchedule(schedule);
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  void _err(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  String _dayLabels(List<int> days) {
    const names = ['', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    return days.map((d) => names[d]).join(', ');
  }

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
        actions: [
          if (_supported)
            IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
        ],
      ),
      body: _schedules.isEmpty
          ? Center(
              child: Text(
                _supported
                    ? 'No schedules yet. Tap + to add one.'
                    : 'Schedule-based blocking is not supported on this platform.',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _schedules.length,
              itemBuilder: (_, i) {
                final s = _schedules[i];
                return Card(
                  child: ListTile(
                    title: Text(s.name),
                    subtitle: Text(
                      '${_fmtTime(s.startTime)} – ${_fmtTime(s.endTime)}'
                      ' • ${s.scheduleDate != null ? '[one-time] ${_fmtDate(s.scheduleDate!)}' : _dayLabels(s.weekdays)}'
                      '\n${s.appIdentifiers.length} app(s)',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(value: s.enabled, onChanged: (_) => _toggle(s)),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _delete(s.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: _supported
          ? FloatingActionButton(onPressed: _add, child: const Icon(Icons.add))
          : null,
    );
  }
}

class _ScheduleDialog extends StatefulWidget {
  const _ScheduleDialog();

  @override
  State<_ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<_ScheduleDialog> {
  final _name = TextEditingController();
  Set<String> _selectedApps = {};
  final Set<int> _weekdays = {1, 2, 3, 4, 5};
  TimeOfDay _start = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 17, minute: 0);
  bool _isOneTime = false;
  DateTime _scheduleDate = DateTime.now();

  static const _dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
    );
    if (picked != null) {
      setState(() => isStart ? _start = picked : _end = picked);
    }
  }

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduleDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _scheduleDate = picked);
    }
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Schedule'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g. Work hours',
              ),
            ),
            const SizedBox(height: 8),
            _AppPickerField(
              selectedApps: _selectedApps,
              onChanged: (apps) => setState(() => _selectedApps = apps),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('One-time schedule'),
              value: _isOneTime,
              onChanged: (v) => setState(() => _isOneTime = v ?? false),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            if (_isOneTime)
              OutlinedButton(
                onPressed: _pickDate,
                child: Text('Date: ${_fmtDate(_scheduleDate)}'),
              )
            else ...[
              Text('Days', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                children: List.generate(7, (i) {
                  final day = i + 1;
                  return FilterChip(
                    label: Text(_dayNames[i]),
                    selected: _weekdays.contains(day),
                    onSelected: (v) => setState(
                      () => v ? _weekdays.add(day) : _weekdays.remove(day),
                    ),
                  );
                }),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickTime(true),
                    child: Text('Start: ${_fmtTime(_start)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickTime(false),
                    child: Text('End: ${_fmtTime(_end)}'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_name.text.trim().isEmpty ||
                (!_isOneTime && _weekdays.isEmpty) ||
                _selectedApps.isEmpty) {
              return;
            }
            Navigator.pop(
              context,
              BlockSchedule(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _name.text.trim(),
                appIdentifiers: _selectedApps.toList(),
                weekdays: _isOneTime ? [] : (_weekdays.toList()..sort()),
                startTime: _start,
                endTime: _end,
                scheduleDate: _isOneTime ? _scheduleDate : null,
              ),
            );
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profiles tab
// ─────────────────────────────────────────────────────────────────────────────

class _ProfilesTab extends StatefulWidget {
  const _ProfilesTab({super.key});

  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab> {
  final _blocker = AppBlocker.instance;
  List<BlockProfile> _profiles = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final p = await _blocker.getProfiles();
      if (mounted) setState(() => _profiles = p);
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _toggle(BlockProfile p) async {
    try {
      if (p.isActive) {
        await _blocker.deactivateProfile(p.id);
      } else {
        await _blocker.activateProfile(p.id);
      }
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _delete(String id) async {
    try {
      await _blocker.deleteProfile(id);
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _create() async {
    final profile = await showDialog<BlockProfile>(
      context: context,
      builder: (_) => const _ProfileDialog(),
    );
    if (profile == null) return;
    try {
      await _blocker.createProfile(profile);
      _load();
    } catch (e) {
      _err('$e');
    }
  }

  Future<void> _showActive() async {
    try {
      final p = await _blocker.getActiveProfile();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              p == null ? 'No active profile' : 'Active: ${p.name}',
            ),
          ),
        );
      }
    } catch (e) {
      _err('$e');
    }
  }

  void _err(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Get active profile',
            onPressed: _showActive,
          ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _load),
        ],
      ),
      body: _profiles.isEmpty
          ? const Center(child: Text('No profiles yet. Tap + to add one.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _profiles.length,
              itemBuilder: (_, i) {
                final p = _profiles[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: p.isActive
                          ? cs.primary
                          : cs.surfaceContainerHighest,
                      child: Icon(
                        Icons.person,
                        color: p.isActive ? cs.onPrimary : cs.onSurfaceVariant,
                      ),
                    ),
                    title: Text(p.name),
                    subtitle: Text(
                      '${p.appIdentifiers.length} apps'
                      ' • ${p.schedules.length} schedules'
                      '${p.isActive ? ' • Active' : ''}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => _toggle(p),
                          child: Text(p.isActive ? 'Deactivate' : 'Activate'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _delete(p.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _create,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProfileDialog extends StatefulWidget {
  const _ProfileDialog();

  @override
  State<_ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<_ProfileDialog> {
  final _name = TextEditingController();
  Set<String> _selectedApps = {};

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'e.g. Work Mode',
            ),
            autofocus: true,
          ),
          const SizedBox(height: 8),
          _AppPickerField(
            selectedApps: _selectedApps,
            onChanged: (apps) => setState(() => _selectedApps = apps),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_name.text.trim().isEmpty) return;
            Navigator.pop(
              context,
              BlockProfile(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _name.text.trim(),
                appIdentifiers: _selectedApps.toList(),
              ),
            );
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Events tab
// ─────────────────────────────────────────────────────────────────────────────

class _EventsTab extends StatefulWidget {
  const _EventsTab();

  @override
  State<_EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<_EventsTab> {
  StreamSubscription<BlockEvent>? _sub;
  final List<BlockEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _sub = AppBlocker.instance.onBlockEvent.listen((e) {
      if (mounted) setState(() => _events.insert(0, e));
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  String _fmtTime(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}:'
      '${t.second.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Events (${_events.length})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: 'Clear',
            onPressed: () => setState(() => _events.clear()),
          ),
        ],
      ),
      body: _events.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 12),
                  const Text('No events yet'),
                  const SizedBox(height: 4),
                  Text(
                    'Block or unblock apps to see events here',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _events.length,
              itemBuilder: (_, i) {
                final e = _events[i];
                return Card(
                  child: ListTile(
                    leading: _EventIcon(type: e.type),
                    title: Text(e.type.name),
                    subtitle: Text(
                      [
                        if (e.packageName != null) e.packageName!,
                        if (e.scheduleId != null) 'schedule: ${e.scheduleId}',
                        _fmtTime(e.timestamp),
                      ].join(' • '),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _EventIcon extends StatelessWidget {
  const _EventIcon({required this.type});
  final BlockEventType type;

  @override
  Widget build(BuildContext context) {
    final (IconData icon, Color color) = switch (type) {
      BlockEventType.blocked => (Icons.block, Colors.red),
      BlockEventType.unblocked => (Icons.lock_open, Colors.green),
      BlockEventType.attemptedAccess => (Icons.warning_amber, Colors.orange),
      BlockEventType.scheduleActivated => (Icons.schedule, Colors.blue),
      BlockEventType.scheduleDeactivated => (Icons.schedule_send, Colors.grey),
      BlockEventType.profileActivated => (Icons.person, Colors.purple),
      BlockEventType.profileDeactivated => (Icons.person_off, Colors.grey),
    };
    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children, this.trailing});

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ?trailing,
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _CapChip extends StatelessWidget {
  const _CapChip(this.label, this.supported);

  final String label;
  final bool supported;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: Icon(
        supported ? Icons.check : Icons.close,
        size: 14,
        color: supported ? Colors.green : Colors.red,
      ),
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// App picker field (reusable button that opens the app picker)
// ─────────────────────────────────────────────────────────────────────────────

class _AppPickerField extends StatefulWidget {
  const _AppPickerField({required this.selectedApps, required this.onChanged});

  final Set<String> selectedApps;
  final ValueChanged<Set<String>> onChanged;

  @override
  State<_AppPickerField> createState() => _AppPickerFieldState();
}

class _AppPickerFieldState extends State<_AppPickerField> {
  List<AppInfo>? _apps;
  bool _loading = false;

  Future<void> _open() async {
    if (Platform.isIOS) {
      setState(() => _loading = true);
      try {
        final picked = await AppBlocker.instance.getApps();
        widget.onChanged(picked.map((a) => a.packageName).toSet());
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$e')));
        }
      } finally {
        if (mounted) setState(() => _loading = false);
      }
      return;
    }

    if (_apps == null) {
      setState(() => _loading = true);
      try {
        _apps = await AppBlocker.instance.getApps();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$e')));
          setState(() => _loading = false);
        }
        return;
      }
      if (mounted) setState(() => _loading = false);
    }

    if (!mounted) return;
    final selected = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AppPicker(apps: _apps!, initial: widget.selectedApps),
    );
    if (selected != null) widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.selectedApps.length;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _loading ? null : _open,
            icon: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.apps, size: 18),
            label: Text(count == 0 ? 'Select apps…' : '$count app(s) selected'),
          ),
        ),
        if (count > 0) ...[
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Clear selection',
            onPressed: () => widget.onChanged({}),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// App picker bottom sheet
// ─────────────────────────────────────────────────────────────────────────────

class _AppPicker extends StatefulWidget {
  const _AppPicker({required this.apps, required this.initial});

  final List<AppInfo> apps;
  final Set<String> initial;

  @override
  State<_AppPicker> createState() => _AppPickerState();
}

class _AppPickerState extends State<_AppPicker> {
  late final Set<String> _selected = Set.from(widget.initial);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: cs.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Apps',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${_selected.length} selected',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: widget.apps.length,
              itemBuilder: (_, i) {
                final app = widget.apps[i];
                final isSelected = _selected.contains(app.packageName);
                return ListTile(
                  leading: _AppIcon(icon: app.icon),
                  title: Text(
                    app.appName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    app.packageName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: cs.primary)
                      : const Icon(Icons.circle_outlined),
                  onTap: () => setState(
                    () => isSelected
                        ? _selected.remove(app.packageName)
                        : _selected.add(app.packageName),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context, _selected),
              child: Text(
                _selected.isEmpty
                    ? 'Confirm (none selected)'
                    : 'Confirm (${_selected.length})',
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.icon});

  final Uint8List? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(icon!, width: 40, height: 40, fit: BoxFit.cover),
      );
    }
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.apps,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        size: 24,
      ),
    );
  }
}
