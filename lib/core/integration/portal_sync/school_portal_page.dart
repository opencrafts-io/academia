import 'dart:async';

import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/injection_container.dart';
import 'package:billing/billing.dart';
import 'package:courses/courses.dart' as courses;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_sync/portal_sync.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'academia_portal_importer.dart';
import 'portal_billing_access_policy.dart';
import 'portal_firebase_bootstrap.dart';
import 'portal_replay_guard.dart';

/// App composition only: the standalone package owns browser and assistant UI.
class SchoolPortalPage extends StatefulWidget {
  const SchoolPortalPage({required this.institutionId, super.key});
  final int institutionId;

  @override
  State<SchoolPortalPage> createState() => _SchoolPortalPageState();
}

class _SchoolPortalPageState extends State<SchoolPortalPage> {
  PortalSyncController? _controller;
  String? _error;
  bool _preparing = true;
  late final PortalReplayGuard _replayGuard;
  String? _accountId;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _replayGuard = PortalReplayGuard(
      isActive: Posthog().isSessionReplayActive,
      stop: Posthog().stopSessionRecording,
      resume: () async {
        await WidgetsBinding.instance.endOfFrame;
        await Posthog().startSessionRecording();
      },
    );
    unawaited(_prepare());
  }

  bool _isCurrentAccount() {
    if (!mounted) return false;
    final state = context.read<ProfileBloc>().state;
    return state is ProfileLoadedState && state.profile.id == _accountId;
  }

  Future<void> _prepare() async {
    final generation = ++_generation;
    setState(() {
      _preparing = true;
      _error = null;
    });
    try {
      if (!portalSyncEnabled) {
        throw StateError('This build does not include internal portal sync.');
      }
      final profile = context.read<ProfileBloc>().state;
      if (profile is! ProfileLoadedState) {
        throw StateError('Sign in to Academia to connect your portal.');
      }
      _accountId = profile.profile.id;
      final institutions = context.read<InstitutionBloc>().state.whenOrNull(
        loaded: (value) => value,
      );
      final institution = institutions
          ?.where((value) => value.institutionId == widget.institutionId)
          .firstOrNull;
      if (institution == null) {
        throw StateError(
          'Open your school in Academia before connecting its portal.',
        );
      }

      // Native platform views can bypass Flutter screenshot masking. Suspend
      // replay before constructing the browser and restore after route teardown.
      await _replayGuard.enter();
      if (!mounted || generation != _generation || !_isCurrentAccount()) return;
      final ai = await PortalFirebaseBootstrap.initialize();
      final preferences = await SharedPreferences.getInstance();
      if (!mounted || generation != _generation || !_isCurrentAccount()) return;
      final candidates =
          [
                ...?institution.webPages,
                for (final domain in institution.domains ?? <String>[])
                  'https://$domain',
              ]
              .map(Uri.tryParse)
              .whereType<Uri>()
              .where(
                (uri) =>
                    uri.scheme == 'https' &&
                    uri.host.isNotEmpty &&
                    uri.userInfo.isEmpty,
              );
      final connection = PortalConnection(
        accountId: _accountId!,
        institutionId: widget.institutionId,
        schoolName: institution.name,
        portalUri:
            candidates.firstOrNull ??
            Uri.parse('https://portal.yourschool.edu'),
      );
      final controller = PortalSyncController(
        connection: connection,
        analysisClient: FirebasePortalAnalysisClient(
          firebaseAI: ai,
          modelName: portalModelName,
        ),
        modelVersion: portalModelName,
        cacheStore: SharedPreferencesPortalCacheStore(preferences),
        usageStore: SharedPreferencesPortalUsageStore(
          preferences,
          // Temporary, bounded allowance while configuring live portal analysis.
          initialSetupLimit: kDebugMode ? 50 : 6,
          dailyLimit: kDebugMode ? 50 : 4,
          monthlyLimit: kDebugMode ? 100 : 30,
        ),
        accessPolicy: PortalBillingAccessPolicy(
          getStatus: sl<GetCurrentSubscriptionStatus>(),
          isCurrentAccount: _isCurrentAccount,
        ),
        importer: AcademiaPortalImporter(
          repository: sl<courses.CourseRepository>(),
          ledger: SharedPreferencesPortalImportLedger(preferences),
          accountId: _accountId!,
          institutionId: widget.institutionId,
          isCurrentAccount: _isCurrentAccount,
        ),
      );
      _controller?.dispose();
      setState(() {
        _controller = controller;
        _preparing = false;
      });
    } catch (error, stack) {
      portalDebugLog('session.prepare_failed', error: error, stackTrace: stack);
      if (!mounted || generation != _generation) return;
      final message = error is StateError
          ? error.message.toString()
          : error is UnsupportedError
          ? error.message ?? 'This device is not supported yet.'
          : 'Portal sync could not start. Check your connection and try again.';
      setState(() {
        _error = message;
        _preparing = false;
      });
    }
  }

  void _onAccountChanged(BuildContext context, ProfileState state) {
    if (_isCurrentAccount()) return;
    _generation++;
    _controller?.stop();
    _controller?.dispose();
    setState(() {
      _controller = null;
      _error = 'Your account changed. Close this screen and connect again.';
      _preparing = false;
    });
  }

  @override
  void dispose() {
    _generation++;
    _controller?.dispose();
    unawaited(_replayGuard.exit().catchError((Object _) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
    listener: _onAccountChanged,
    child: PostHogMaskWidget(
      child: _controller != null
          ? PortalSyncPage(
              connection: _controller!.connection,
              controller: _controller!,
              onUpgrade: () =>
                  const PaywallRoute(featureName: 'school portal sync')
                      .push(context),
            )
          : Scaffold(
              appBar: AppBar(title: const Text('School portal')),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _preparing
                      ? const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Preparing your private portal session…'),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cloud_off_rounded, size: 48),
                            const SizedBox(height: 16),
                            Text(
                              _error ?? 'Portal sync could not start.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            FilledButton(
                              onPressed: _prepare,
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                ),
              ),
            ),
    ),
  );
}
