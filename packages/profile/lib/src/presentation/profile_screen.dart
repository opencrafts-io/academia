import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:time_since/time_since.dart';

import '../domain/user_profile.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.onRefresh,
    required this.onOpenPasswordSettings,
    required this.onLinkInstitution,
    required this.onSignOut,
    required this.linkedInstitutionsBuilder,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final VoidCallback onOpenPasswordSettings;
  final VoidCallback onLinkInstitution;
  final VoidCallback onSignOut;
  final WidgetBuilder linkedInstitutionsBuilder;

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
    listener: (context, state) {
      if (state is AccountDeletionRequestedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            behavior: SnackBarBehavior.floating,
          ),
        );
        unawaited(_signOutAfterDeletion(context));
      }
    },
    child: Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is! ProfileLoadedState) {
              return _buildUnavailable(context, state);
            }
            return _buildProfile(context, state.profile);
          },
        ),
      ),
    ),
  );

  Widget _buildUnavailable(BuildContext context, ProfileState state) =>
      CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _pinnedAppBar(context),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: state is ProfileErrorState
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _EmptyStateIcon(
                            icon: Icons.person_off_outlined,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Your profile could not be loaded',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check your connection and try again.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          FilledButton.icon(
                            onPressed: () => context.read<ProfileBloc>().add(
                              RefreshProfileEvent(),
                            ),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try again'),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator.adaptive(),
            ),
          ),
        ],
      );

  Widget _buildProfile(BuildContext context, UserProfile profile) =>
      CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _pinnedAppBar(context),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _IdentityHeader(profile: profile),
                      const SizedBox(height: 32),
                      const _SectionHeading(
                        title: 'Personal details',
                        subtitle: 'Your account information',
                      ),
                      const SizedBox(height: 12),
                      _ProfileCard(
                        child: _DetailList(
                          items: [
                            _DetailItem(
                              icon: Icons.badge_outlined,
                              label: 'Full name',
                              value: profile.name,
                            ),
                            _DetailItem(
                              icon: Icons.alternate_email,
                              label: 'Username',
                              value: profile.username == null
                                  ? 'Not added'
                                  : '@${profile.username}',
                            ),
                            _DetailItem(
                              icon: Icons.credit_card_outlined,
                              label: 'National ID or passport',
                              value: profile.nationalID ?? 'Not added',
                            ),
                            _DetailItem(
                              icon: Icons.call_outlined,
                              label: 'Phone number',
                              value: profile.phone ?? 'Not added',
                            ),
                            _DetailItem(
                              icon: Icons.mail_outline,
                              label: 'Email address',
                              value: profile.email,
                            ),
                            _DetailItem(
                              icon: Icons.schedule_outlined,
                              label: 'Member since',
                              value: timeSince(profile.createdAt),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const _SectionHeading(
                        title: 'Your institutions',
                        subtitle: 'Campus services connected to your account',
                      ),
                      const SizedBox(height: 12),
                      _ProfileCard(
                        child: Column(
                          children: [
                            _ActionTile(
                              icon: Icons.add_link_rounded,
                              title: 'Link an institution',
                              subtitle: 'Connect your campus and classes',
                              onTap: onLinkInstitution,
                            ),
                            _InsetDivider(),
                            linkedInstitutionsBuilder(context),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const _SectionHeading(
                        title: 'Account security',
                        subtitle: 'Manage how you access your account',
                      ),
                      const SizedBox(height: 12),
                      _ProfileCard(
                        child: _ActionTile(
                          icon: Icons.lock_outline_rounded,
                          title: 'Password and sign-in',
                          subtitle: profile.email.isEmpty
                              ? 'Set or change your password'
                              : 'Sign-in email · ${profile.email}',
                          onTap: onOpenPasswordSettings,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _ProfileCard(
                        child: _ActionTile(
                          icon: Icons.logout_rounded,
                          title: 'Log out',
                          subtitle: 'Remove this account from this device',
                          onTap: () => _confirmSignOut(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _DestructiveCard(
                        child: _ActionTile(
                          icon: Icons.delete_outline_rounded,
                          title: 'Request account deletion',
                          subtitle: 'You can recover your account for 14 days',
                          isDestructive: true,
                          onTap: () => _confirmDeletion(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  SliverAppBar _pinnedAppBar(BuildContext context) => SliverAppBar(
    pinned: true,
    floating: false,
    title: const Text('Profile'),
    scrolledUnderElevation: 0,
    backgroundColor: Theme.of(context).colorScheme.surface,
    surfaceTintColor: Colors.transparent,
  );

  Future<void> _signOutAfterDeletion(BuildContext context) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (context.mounted) onSignOut();
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final shouldSignOut = await showAdaptiveDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Text('Log out?'),
        content: const Text(
          'Your profile and offline data will be removed from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (shouldSignOut == true && context.mounted) onSignOut();
  }

  Future<void> _confirmDeletion(BuildContext context) async {
    final shouldDelete = await showAdaptiveDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Theme.of(context).colorScheme.error,
        ),
        title: const Text('Request account deletion?'),
        content: const Text(
          'Your account will be scheduled for deletion. You can recover it '
          'within 14 days before it is permanently removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Request deletion'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && context.mounted) {
      context.read<ProfileBloc>().add(RequestAccountDeletionEvent());
    }
  }
}

class _IdentityHeader extends StatelessWidget {
  const _IdentityHeader({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final initials = _profileInitials(profile.name);
    final avatarUrl = profile.avatarUrl?.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipPath(
          clipper: const M3EShapeClipper(M3EShape.cookie9Sided),
          child: SizedBox.square(
            dimension: 92,
            child: DecoratedBox(
              decoration: BoxDecoration(color: colors.primaryContainer),
              child: avatarUrl == null || avatarUrl.isEmpty
                  ? Center(child: _AvatarInitials(initials: initials))
                  : Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded || frame != null) {
                              return child;
                            }
                            return Center(
                              child: _AvatarInitials(initials: initials),
                            );
                          },
                      errorBuilder: (context, error, stackTrace) =>
                          Center(child: _AvatarInitials(initials: initials)),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          profile.username == null ? profile.email : '@${profile.username}',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurfaceVariant,
          ),
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _AvatarInitials extends StatelessWidget {
  const _AvatarInitials({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) => Text(
    initials.isEmpty ? '?' : initials,
    style: Theme.of(context).textTheme.headlineSmall
        ?.copyWith(fontWeight: FontWeight.w700),
  );
}

String _profileInitials(String name) => name
    .trim()
    .split(RegExp(r'\s+'))
    .where((part) => part.isNotEmpty)
    .take(2)
    .map((part) => part.characters.first.toUpperCase())
    .join();

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    ),
  );
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shadowColor: colors.shadow.withValues(alpha: 0.12),
      surfaceTintColor: Colors.transparent,
      color: color ?? colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _DetailItem {
  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _DetailList extends StatelessWidget {
  const _DetailList({required this.items});

  final List<_DetailItem> items;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var index = 0; index < items.length; index++) ...[
        _DetailRow(item: items[index]),
        if (index < items.length - 1)
          const _InsetDivider(indent: 76, endIndent: 20),
      ],
    ],
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.item});

  final _DetailItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isMissing = item.value == 'Not added';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Icon(
              item.icon,
              size: 20,
              color: colors.onSecondaryContainer,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isMissing
                        ? colors.onSurfaceVariant
                        : colors.onSurface,
                    fontWeight: isMissing ? FontWeight.normal : FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final titleColor = isDestructive ? colors.error : colors.onSurface;
    return ListTile(
      minTileHeight: 76,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDestructive
              ? colors.errorContainer
              : colors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: isDestructive
              ? colors.onErrorContainer
              : colors.onPrimaryContainer,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(color: titleColor),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: isDestructive ? colors.error : colors.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}

class _InsetDivider extends StatelessWidget {
  const _InsetDivider({this.indent = 20, this.endIndent = 20});

  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) => Divider(
    height: 1,
    thickness: 1,
    indent: indent,
    endIndent: endIndent,
    color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
  );
}

class _DestructiveCard extends StatelessWidget {
  const _DestructiveCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return _ProfileCard(
      color: colors.errorContainer.withValues(alpha: 0.28),
      child: child,
    );
  }
}

class _EmptyStateIcon extends StatelessWidget {
  const _EmptyStateIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 32, color: color),
    );
  }
}
