import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/study_entities.dart';
import 'study_tools_feedback.dart';

class StudyMaterialHeaderCard extends StatelessWidget {
  const StudyMaterialHeaderCard({required this.material, super.key});

  final StudyMaterial material;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card.filled(
      color: colors.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: colors.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    material.filename.split('.').last.toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge
                        ?.copyWith(color: colors.onPrimaryContainer),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              material.filename,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colors.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MaterialMetadataChip(
                  icon:
                      material.courseId == null &&
                          material.courseLabel.trim().isEmpty
                      ? Icons.folder_open_outlined
                      : Icons.school_outlined,
                  label: material.courseLabel.isEmpty
                      ? 'Unassigned'
                      : material.courseLabel,
                ),
                _MaterialMetadataChip(
                  icon: Icons.data_usage_outlined,
                  label: studyToolsFileSize(material.sizeBytes),
                ),
                _MaterialMetadataChip(
                  icon: Icons.calendar_today_outlined,
                  label: DateFormat.yMMMd().format(material.uploadedAt),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudySectionHeading extends StatelessWidget {
  const StudySectionHeading({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 4),
      Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    ],
  );
}

class StudyGenerationOptions extends StatelessWidget {
  const StudyGenerationOptions({
    required this.busy,
    required this.loadingFormat,
    required this.onGenerate,
    super.key,
  });

  final bool busy;
  final QuestionFormat? loadingFormat;
  final ValueChanged<QuestionFormat> onGenerate;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columns = constraints.maxWidth > 560 ? 3 : 1;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: QuestionFormat.values.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisExtent: 82,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final format = QuestionFormat.values[index];
          return _GenerationTile(
            format: format,
            enabled: !busy,
            loading: loadingFormat == format,
            onTap: () => onGenerate(format),
          );
        },
      );
    },
  );
}

class _MaterialMetadataChip extends StatelessWidget {
  const _MaterialMetadataChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 16),
    label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    visualDensity: VisualDensity.compact,
    side: BorderSide.none,
    backgroundColor: Theme.of(context).colorScheme.surface
        .withValues(alpha: 0.7),
  );
}

class _GenerationTile extends StatelessWidget {
  const _GenerationTile({
    required this.format,
    required this.enabled,
    required this.loading,
    required this.onTap,
  });

  final QuestionFormat format;
  final bool enabled;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (icon, color) = switch (format) {
      QuestionFormat.flashcard => (
        Icons.style_outlined,
        colors.primaryContainer,
      ),
      QuestionFormat.mcq => (
        Icons.fact_check_outlined,
        colors.secondaryContainer,
      ),
      QuestionFormat.openEnded => (
        Icons.edit_note_rounded,
        colors.tertiaryContainer,
      ),
    };
    return Card.filled(
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      format.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Generate questions',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: loading
                    ? const SizedBox.square(
                        key: ValueKey('loading'),
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        key: ValueKey('arrow'),
                        Icons.arrow_forward_rounded,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
