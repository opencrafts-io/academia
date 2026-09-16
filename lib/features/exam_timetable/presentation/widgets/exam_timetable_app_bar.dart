import 'package:academia/config/router/routes.dart';
import 'package:academia/features/profile/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class ExamTimetableAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onHelpTap;

  const ExamTimetableAppBar({
    super.key,
    required this.onSearchTap,
    required this.onHelpTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSurface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: InkWell(
        onTap: onSearchTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 52,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20,
                color: colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Search by course code',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: "Help",
          onPressed: onHelpTap,
          icon: Icon(
            Icons.info_outline_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        IconButton(
          onPressed: () => ProfileRoute().push(context),
          icon: UserAvatar(scallopDepth: 4, numberOfScallops: 12),
        ),
      ],
    );
  }
}
