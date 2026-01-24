import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/institution/institution.dart';

class InstitutionStudentProfileCard extends StatefulWidget {
  final String userID;
  final int institutionID;
  final VoidCallback onTap;

  const InstitutionStudentProfileCard({
    super.key,
    required this.userID,
    required this.institutionID,
    required this.onTap,
  });

  @override
  State<InstitutionStudentProfileCard> createState() =>
      _InstitutionProfileCardState();
}

class _InstitutionProfileCardState
    extends State<InstitutionStudentProfileCard> {
  @override
  void initState() {
    super.initState();
    context.read<StudentProfileBloc>().add(
      WatchProfileByUserAndInstitutionEvent(
        userID: widget.userID,
        institutionID: widget.institutionID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final profile = context.select<StudentProfileBloc, InstitutionProfile?>((
      bloc,
    ) {
      final fromList = bloc.state.profiles?.firstWhere(
        (p) =>
            p.userID == widget.userID && p.institution == widget.institutionID,
      );

      if (fromList != null) return fromList;

      // Fallback to the single 'profile' field if it matches
      final singleProfile = bloc.state.profile;
      if (singleProfile != null &&
          singleProfile.userID == widget.userID &&
          singleProfile.institution == widget.institutionID) {
        return singleProfile;
      }

      return null;
    });

    // Show a loading shimmer or placeholder if the profile isn't loaded yet
    if (profile == null) {
      return _buildLoadingPlaceholder(theme);
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32), // Expressive M3 Shape
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      color: theme.colorScheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ExpressiveAvatar(profile: profile),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.studentName,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildBadge(
                          theme,
                          profile.program ?? "General Studies",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildStatsRow(theme, profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(ThemeData theme, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme, InstitutionProfile profile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: "GPA",
            value: profile.gpa?.toStringAsFixed(2) ?? "—",
          ),
          _StatDivider(),
          _StatItem(label: "YEAR", value: "${profile.year ?? 1}"),
          _StatDivider(),
          _StatItem(
            label: "STATUS",
            value: profile.status?.name.toUpperCase() ?? "??",
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder(ThemeData theme) {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Center(child: CircularProgressIndicator.adaptive()),
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
  final InstitutionProfile profile;
  const _ExpressiveAvatar({required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2), // Border effect
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.colorScheme.surface,
            image: profile.profilePicture != null
                ? DecorationImage(
                    image: NetworkImage(profile.profilePicture!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: profile.profilePicture == null
              ? Center(
                  child: Text(
                    profile.studentName[0],
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
