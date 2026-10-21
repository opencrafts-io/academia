import 'dart:math' as math;

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/user_profile.dart';
import '../bloc/profile_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.onNext, this.placeholderAvatar});

  final VoidCallback onNext;
  final Widget? placeholderAvatar;

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      final profile = state is ProfileLoadedState ? state.profile : null;
      return _WelcomeContent(
        profile: profile,
        onNext: onNext,
        placeholderAvatar: placeholderAvatar,
      );
    },
  );
}

class _WelcomeContent extends StatelessWidget {
  const _WelcomeContent({
    required this.profile,
    required this.onNext,
    required this.placeholderAvatar,
  });

  final UserProfile? profile;
  final VoidCallback onNext;
  final Widget? placeholderAvatar;

  String get _greeting {
    final name = profile?.name.trim() ?? '';
    if (name.isEmpty) return 'Hi, there Mysterio';
    return 'Hi, ${name.split(RegExp(r'\s+')).first}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final avatarUrl = profile?.avatarUrl?.trim();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        const SizedBox(height: 12),
        Center(
          child: _RotatingAvatar(
            imageUrl: avatarUrl,
            placeholderAvatar: placeholderAvatar,
            label: profile?.name.trim().isNotEmpty == true
                ? '${profile!.name} profile photo'
                : 'Anonymous profile avatar',
            surfaceColor: colors.primaryContainer,
            placeholderColor: colors.secondaryContainer,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          _greeting,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(
          'A few details help us tailor your experience and connect you with your campus community.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 28),
        _WelcomeBenefit(
          icon: Icons.badge_outlined,
          text: 'Build a profile that feels like you',
        ),
        const SizedBox(height: 14),
        _WelcomeBenefit(
          icon: Icons.school_outlined,
          text: 'Find the right tools for your school',
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: onNext,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(58),
            shape: const StadiumBorder(),
          ),
          iconAlignment: IconAlignment.end,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Get started'),
        ),
        const SizedBox(height: 8),
        Text(
          'Takes a minute',
          textAlign: TextAlign.center,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _RotatingAvatar extends StatefulWidget {
  const _RotatingAvatar({
    required this.imageUrl,
    required this.placeholderAvatar,
    required this.label,
    required this.surfaceColor,
    required this.placeholderColor,
  });

  final String? imageUrl;
  final Widget? placeholderAvatar;
  final String label;
  final Color surfaceColor;
  final Color placeholderColor;

  @override
  State<_RotatingAvatar> createState() => _RotatingAvatarState();
}

class _RotatingAvatarState extends State<_RotatingAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 36),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _rotationController.stop();
    } else if (!_rotationController.isAnimating) {
      _rotationController.repeat();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: widget.label,
    image: true,
    child: SizedBox.square(
      dimension: 116,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) => ClipPath(
              clipper: M3EShapeClipper(
                M3EShape.cookie9Sided,
                rotation: _rotationController.value * math.pi * 2,
              ),
              child: child,
            ),
            child: SizedBox.square(
              dimension: 116,
              child: DecoratedBox(
                decoration: BoxDecoration(color: widget.surfaceColor),
              ),
            ),
          ),
          ClipOval(
            child: SizedBox.square(
              dimension: 88,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  ColoredBox(color: widget.placeholderColor),
                  if (widget.placeholderAvatar != null)
                    widget.placeholderAvatar!
                  else
                    Icon(
                      Icons.person_rounded,
                      size: 46,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  if (widget.imageUrl?.isNotEmpty == true)
                    Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, loadedSync) =>
                          loadedSync || frame != null
                          ? child
                          : const SizedBox.shrink(),
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _WelcomeBenefit extends StatelessWidget {
  const _WelcomeBenefit({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
