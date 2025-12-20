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
          SliverAppBar.large(title: const Text("Settings")),
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
                          // Theme Section
                          _SectionHeader(title: "Appearance"),
                          const SizedBox(height: 12),
                          _ThemeModeCard(
                            currentMode: state.themeMode,
                            onChanged: (mode) {
                              context.read<SettingsCubit>().updateTheme(mode);
                            },
                          ),
                          const SizedBox(height: 16),
                          _ColorSeedCard(
                            currentColor: Color(state.colorSeedValue),
                            onColorChanged: (color) {
                              context.read<SettingsCubit>().updateColor(
                                color.value,
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // Display Section
                          _SectionHeader(title: "Display"),
                          const SizedBox(height: 12),
                          _CompactModeCard(
                            isCompact: state.compactMode,
                            onChanged: (value) {
                              context.read<SettingsCubit>().toggleCompactMode();
                            },
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

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ThemeModeCard extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeModeCard({required this.currentMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Theme Mode", style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ThemeMode.values.map((mode) {
                final isSelected = currentMode == mode;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) => onChanged(mode),
                  label: Text(_getThemeModeName(mode)),
                  // icon: Icon(_getThemeModeIcon(mode)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}

class _ColorSeedCard extends StatelessWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  const _ColorSeedCard({
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

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Accent Color", style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colors.map((color) {
                final isSelected = currentColor.value == color.value;
                return GestureDetector(
                  onTap: () => onColorChanged(color),
                  child: Container(
                    width: 56,
                    height: 56,
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
                              Icons.check,
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
      ),
    );
  }
}

class _CompactModeCard extends StatelessWidget {
  final bool isCompact;
  final ValueChanged<bool> onChanged;

  const _CompactModeCard({required this.isCompact, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Compact Mode",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "Reduce spacing and padding",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Switch(value: isCompact, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
