import 'dart:async';
import 'dart:convert';

import 'package:academia/config/config.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:academia/injection_container.dart';
import 'package:analytics/analytics.dart';
import 'package:billing/billing.dart' as billing;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings/settings.dart' as settings;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash/splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _launchCountKey = 'splash_launch_tip_count';
  static const _cachedConfigurationKey = 'splash_launch_tips_payload';

  late final DateTime _startedAt;
  SplashTipConfiguration _configuration = SplashTipConfiguration.defaults;
  SplashTip? _tip = SplashTipConfiguration.defaults.tips.first;
  Timer? _navigationTimer;
  String? _destination;
  DateTime? _authResolvedAt;
  bool _authReady = false;
  bool _actionInProgress = false;
  bool _navigationStarted = false;

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now();
    unawaited(_loadLaunchTips());
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadLaunchTips() async {
    SharedPreferences? preferences;
    var launchIndex = DateTime.now().millisecondsSinceEpoch;

    try {
      preferences = await SharedPreferences.getInstance();
      launchIndex = preferences.getInt(_launchCountKey) ?? 0;
      await preferences.setInt(_launchCountKey, launchIndex + 1);
      final cachedPayload = preferences.getString(_cachedConfigurationKey);
      final cachedConfiguration = SplashTipConfiguration.tryParse(
        cachedPayload,
      );
      if (cachedConfiguration != null) {
        _applyConfiguration(cachedConfiguration, launchIndex);
      } else {
        _applyConfiguration(SplashTipConfiguration.defaults, launchIndex);
      }
    } on Object {
      _applyConfiguration(SplashTipConfiguration.defaults, launchIndex);
    }

    if (!sl<FlavorConfig>().isProduction) return;

    try {
      final payload = await sl<FeatureFlagReader>().readJson(
        SplashTipConfiguration.flagKey,
      );
      final configuration = SplashTipConfiguration.tryParse(payload);
      if (configuration == null) return;
      final serializedPayload = payload is String
          ? payload
          : jsonEncode(payload);
      await preferences?.setString(_cachedConfigurationKey, serializedPayload);
      if (mounted) _applyConfiguration(configuration, launchIndex);
    } on Object {
      // Keep the bundled or last cached tips when remote config is unavailable.
    }
  }

  void _applyConfiguration(
    SplashTipConfiguration configuration,
    int launchIndex,
  ) {
    if (!mounted) return;
    setState(() {
      _configuration = configuration;
      _tip = configuration.enabled && configuration.tips.isNotEmpty
          ? configuration.tips[launchIndex % configuration.tips.length]
          : null;
    });
    _scheduleNavigation();
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      _authReady = true;
      _authResolvedAt = DateTime.now();
      _destination = HomeRoute().location;
    } else if (state is AuthUnauthenticated) {
      _authReady = true;
      _authResolvedAt = DateTime.now();
      _destination = AuthRoute().location;
    } else if (state is AuthError) {
      _authReady = false;
      _authResolvedAt = null;
      _destination = null;
      _navigationTimer?.cancel();
    }

    if (mounted) setState(() {});
    _scheduleNavigation();
  }

  void _scheduleNavigation() {
    _navigationTimer?.cancel();
    if (!mounted || !_authReady || _destination == null) return;

    final now = DateTime.now();
    final minimumEnd = _startedAt.add(_configuration.minimumDisplayDuration);
    final actionOpportunityEnd = _configuration.enabled && _tip?.action != null
        ? _authResolvedAt?.add(const Duration(milliseconds: 1200))
        : null;
    final displayUntil =
        actionOpportunityEnd != null && actionOpportunityEnd.isAfter(minimumEnd)
        ? actionOpportunityEnd
        : minimumEnd;
    final remaining = displayUntil.difference(now);
    _navigationTimer = Timer(
      remaining.isNegative ? Duration.zero : remaining,
      _continueWhenReady,
    );
  }

  void _continueWhenReady() {
    if (!mounted ||
        !_authReady ||
        _destination == null ||
        _actionInProgress ||
        _navigationStarted) {
      return;
    }

    final elapsed = DateTime.now().difference(_startedAt);
    if (elapsed < _configuration.minimumDisplayDuration) {
      _scheduleNavigation();
      return;
    }

    _navigateToDestination();
  }

  void _continueNow() {
    _navigationTimer?.cancel();
    _navigateToDestination();
  }

  void _navigateToDestination() {
    final destination = _destination;
    if (!mounted || destination == null || _navigationStarted) return;
    _navigationStarted = true;
    context.go(destination);
  }

  Future<void> _performTipAction(SplashTipAction action) async {
    if (!_authReady || _actionInProgress || _navigationStarted) return;
    _actionInProgress = true;
    _navigationTimer?.cancel();
    if (mounted) setState(() {});

    try {
      switch (action) {
        case SplashTipAction.premium:
          await const billing.PaywallRoute(
            featureName: 'Academia Premium',
            accessMessage: 'Upgrade to unlock an ad-free Academia experience.',
          ).push(context);
        case SplashTipAction.notifications:
          await const settings.NotificationSettingsRoute().push(context);
        case SplashTipAction.lockIn:
          await LockInRoute().push(context);
      }
    } finally {
      if (mounted) {
        _actionInProgress = false;
        _scheduleNavigation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) => LaunchTipsSplashView(
        brand: Assets.icons.academia.image(width: 40, height: 40),
        tip: _tip,
        tipsEnabled: _configuration.enabled,
        authReady: _authReady && !_actionInProgress,
        authError: state is AuthError ? state.message : null,
        onContinue: _authReady ? _continueNow : null,
        onTipAction: _authReady && !_actionInProgress
            ? _performTipAction
            : null,
        onRetry: state is AuthError
            ? () => context.read<AuthBloc>().add(AuthCheckStatusEvent())
            : null,
      ),
      listener: _onAuthStateChanged,
    );
  }
}
