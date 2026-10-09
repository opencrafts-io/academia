import 'package:academia/config/config.dart';
import 'package:flutter/material.dart';

class RewardsEssentialsCard extends StatelessWidget {
  const RewardsEssentialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card.filled(
      color: colors.tertiaryContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ListTile(
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: .72),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(Icons.auto_awesome_rounded, color: colors.tertiary),
        ),
        title: Text(
          'Points and rewards',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.onTertiaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          'Build streaks and celebrate your wins',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.onTertiaryContainer,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_rounded,
          color: colors.onTertiaryContainer,
        ),
        onTap: () => AchievementsHomePageRoute().push(context),
      ),
    );
  }
}
