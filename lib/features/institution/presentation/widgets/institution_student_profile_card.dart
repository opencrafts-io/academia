import 'package:academia/core/core.dart';
import 'package:flutter/material.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class InstitutionStudentProfileCard extends StatelessWidget {
  final InstitutionProfile? profile;
  final VoidCallback onTap;

  const InstitutionStudentProfileCard({
    super.key,
    this.profile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isFake = profile == null;

    return Skeletonizer(
      enabled: isFake,
      child: Card.filled(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: theme.colorScheme.primaryContainer,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ExpressiveAvatar(profile: profile, size: 36),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.studentName ?? 'Student Name',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${profile?.studentId ?? '#ID'} • ${profile?.program ?? 'General Studies'}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    Icon(Icons.open_in_new_rounded),
                  ],
                ),
                const SizedBox(height: 24),
                _buildStatsRow(theme, profile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme, InstitutionProfile? profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: "GPA",
            value: profile?.gpa?.toStringAsFixed(2) ?? "—",
          ),
          _StatDivider(),
          _StatItem(label: "YEAR", value: "${profile?.year ?? '—'}"),
          _StatDivider(),
          _StatItem(
            label: "STATUS",
            value: profile?.status?.name.toUpperCase() ?? "UNKNOWN",
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 1.5,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _ExpressiveAvatar extends StatelessWidget {
  final InstitutionProfile? profile;
  final double size;

  const _ExpressiveAvatar({this.profile, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage =
        profile?.profilePicture != null && profile!.profilePicture!.isNotEmpty;

    return CircleAvatar(
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      radius: size,
      child: Padding(
        padding: EdgeInsets.zero,
        child: ClipPath(
          clipper: ScallopClipper(numberOfScallops: 8, scallopDepth: 4),
          child: Container(
            color: theme.colorScheme.surface,
            child: _buildImageLogic(theme, hasImage),
          ),
        ),
      ),
    );
  }

  Widget _buildImageLogic(ThemeData theme, bool hasImage) {
    if (!hasImage) return _buildPlaceholder(theme);

    final String source = profile!.profilePicture!;

    // Check for Base64 (starts with data:image or is a raw base64 string without http)
    final bool isBase64 =
        source.startsWith('data:image') || !source.contains('://');

    if (isBase64) {
      try {
        final cleanBase64 = source.contains(',')
            ? source.split(',').last
            : source;
        return Image.memory(
          base64Decode(cleanBase64.trim()),
          fit: BoxFit.cover,
          errorBuilder: (context, _, __) => _buildPlaceholder(theme),
        );
      } catch (e) {
        return _buildPlaceholder(theme);
      }
    }

    // Otherwise use CachedNetworkImage for URLs
    return CachedNetworkImage(
      imageUrl: source,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: SizedBox(
          width: size * 0.3,
          height: size * 0.3,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      errorWidget: (context, url, error) => _buildPlaceholder(theme),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    final String initial = profile?.studentName.isNotEmpty == true
        ? profile!.studentName[0].toUpperCase()
        : "";

    return Center(
      child: initial.isNotEmpty
          ? Text(
              initial,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.35,
              ),
            )
          : Icon(
              Icons.person_outline_rounded,
              color: theme.colorScheme.outline,
              size: size * 0.4,
            ),
    );
  }
}
