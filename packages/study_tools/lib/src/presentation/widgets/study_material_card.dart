import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/study_entities.dart';
import 'study_tools_feedback.dart';

class StudyMaterialCard extends StatelessWidget {
  const StudyMaterialCard({
    required this.material,
    required this.onTap,
    super.key,
  });

  final StudyMaterial material;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extension = material.filename.split('.').last.toUpperCase();
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: SizedBox.square(
                      dimension: 48,
                      child: Icon(
                        _fileIcon(extension),
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      extension,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: colors.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                material.filename,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    material.courseId == null
                        ? Icons.folder_open_outlined
                        : Icons.school_outlined,
                    size: 16,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      material.courseLabel.isEmpty
                          ? 'Unassigned'
                          : material.courseLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat.MMMd().format(material.uploadedAt),
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                  const Spacer(),
                  Text(
                    studyToolsFileSize(material.sizeBytes),
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _fileIcon(String extension) => switch (extension) {
    'PDF' => Icons.picture_as_pdf_outlined,
    'PPTX' => Icons.slideshow_outlined,
    'XLSX' || 'XLS' => Icons.table_chart_outlined,
    _ => Icons.description_outlined,
  };
}
