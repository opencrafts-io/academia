import 'package:academia/features/settings/presentation/cubit/settings_state.dart';
import 'package:academia/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            snap: true,
            pinned: true,
            floating: true,
            title: const Text("Settings"),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: MultiSliver(
              pushPinnedChildren: true,
              children: [
                SliverToBoxAdapter(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          _SettingsSection(
                            icon: Icons.palette_rounded,
                            title: "Appearance",
                            children: [
                              _ThemeModeRow(
                                currentMode: state.themeMode,
                                onChanged: (mode) {
                                  context.read<SettingsCubit>().updateTheme(
                                    mode,
                                  );
                                },
                              ),
                              _ToggleRow(
                                title: "Enable material you",
                                subTitle: "Makes the app feel more modern",
                                value: state.enableMaterialYou,
                                onChanged: (_) {
                                  context
                                      .read<SettingsCubit>()
                                      .toggleEnableMaterialYou();
                                },
                              ),
                              _ToggleRow(
                                title: "Automatic Color scheme",
                                subTitle:
                                    "Pick your color scheme based on wallpaper",
                                value: state.automaticallyPickAccentColor,
                                onChanged: (_) {
                                  context
                                      .read<SettingsCubit>()
                                      .toggleEnableAutomaticAccentColor();
                                },
                              ),
                              if (!state.automaticallyPickAccentColor)
                                _ColorSeedRow(
                                  currentColor: Color(state.colorSeedValue),
                                  onColorChanged: (color) {
                                    context.read<SettingsCubit>().updateColor(
                                      color.toARGB32(),
                                    );
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _SettingsSection(
                            icon: Icons.tune_rounded,
                            title: "Display",
                            children: [
                              _ToggleRow(
                                title: "Compact Mode",
                                subTitle: "Reduce spacing and padding",
                                value: state.compactMode,
                                onChanged: (_) {
                                  context
                                      .read<SettingsCubit>()
                                      .toggleCompactMode();
                                },
                              ),
                              _ToggleRow(
                                title: "Extra Dark Mode",
                                subTitle:
                                    "Enable extra dark mode for OLED displays",
                                value: state.extraDarkMode,
                                onChanged: (_) {
                                  context
                                      .read<SettingsCubit>()
                                      .toggleEnableExtraDarkMode();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _SettingsSection(
                            icon: Icons.school_rounded,
                            title: "Courses",
                            children: [
                              _ToggleRow(
                                title: "Daily schedule at glance",
                                subTitle:
                                    "Pin a smart shortcut for today’s courses to the top of your feed.",
                                value: state.showDailyScheduleOnFeed,
                                onChanged: (_) {
                                  context
                                      .read<SettingsCubit>()
                                      .toggleShowDailyScheduleOnFeed();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A tonal, grouped card for a settings section: a small labeled header
/// above a single rounded container holding all of the section's rows,
/// separated by hairline dividers - rather than one bordered card per row.
class _SettingsSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeModeRow extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeModeRow({required this.currentMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Theme", style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.light_mode_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.dark_mode_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.brightness_auto_rounded),
              ),
            ],
            selected: {currentMode},
            onSelectionChanged: (selected) => onChanged(selected.first),
          ),
        ],
      ),
    );
  }
}

class _ColorSeedRow extends StatelessWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  const _ColorSeedRow({
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF6200EE),
      const Color(0xFF03DAC6),
      const Color(0xFFFF0266),
      const Color(0xFFFF6E40),
      const Color(0xFFFFC400),
      const Color(0xFF00B8D4),
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Accent color", style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((color) {
              final isSelected = currentColor.toARGB32() == color.toARGB32();
              return GestureDetector(
                onTap: () => onColorChanged(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 3,
                          )
                        : null,
                  ),
                  child: isSelected
                      ? Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          ),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final bool value;
  final String title;
  final String subTitle;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.value,
    required this.title,
    required this.subTitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(title, style: Theme.of(context).textTheme.labelLarge),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
