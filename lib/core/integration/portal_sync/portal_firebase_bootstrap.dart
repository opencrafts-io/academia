import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:portal_sync/portal_sync.dart' show portalDebugLog;

FirebaseOptions portalFirebaseOptionsForPlatform(
  TargetPlatform platform, {
  String? androidPackageName,
}) {
  if (platform == TargetPlatform.iOS) return DefaultFirebaseOptions.ios;
  if (platform != TargetPlatform.android) {
    throw UnsupportedError('Portal sync supports Android and iOS.');
  }
  // All three registrations share the generated project and client API key.
  final appId = switch (androidPackageName) {
    'io.opencrafts.academia' => DefaultFirebaseOptions.android.appId,
    'io.opencrafts.academia.dev' =>
      '1:975540451403:android:ddfd2491970182121975ce',
    'io.opencrafts.academia.stg' =>
      '1:975540451403:android:acd2c594092788111975ce',
    _ => throw UnsupportedError('Unknown Academia Android app registration.'),
  };
  return DefaultFirebaseOptions.android.copyWith(appId: appId);
}

const portalSyncEnabled = bool.fromEnvironment(
  'PORTAL_SYNC_ENABLED',
  defaultValue: kDebugMode,
);
const portalModelName = String.fromEnvironment(
  'PORTAL_AI_MODEL',
  defaultValue: 'gemini-3.8-flash',
);

/// A named app uses Academia's saved Firebase registration for the native flavor.
/// Other Academia features never need Firebase to start successfully.
class PortalFirebaseBootstrap {
  static Future<FirebaseAI>? _initialization;
  static Future<FirebaseAI> initialize() =>
      _initialization ??= _initialize().catchError((Object error) {
        _initialization = null;
        throw error;
      });

  static Future<FirebaseAI> _initialize() async {
    if (!portalSyncEnabled) {
      throw StateError('Portal sync is not enabled in this build.');
    }
    if (kIsWeb ||
        !const [
          TargetPlatform.android,
          TargetPlatform.iOS,
        ].contains(defaultTargetPlatform)) {
      throw UnsupportedError(
        'The internal portal release supports Android and iOS.',
      );
    }
    final androidPackageName = defaultTargetPlatform == TargetPlatform.android
        ? (await PackageInfo.fromPlatform()).packageName
        : null;
    final options = portalFirebaseOptionsForPlatform(
      defaultTargetPlatform,
      androidPackageName: androidPackageName,
    );
    const name = 'academia-portal-internal';
    final matches = Firebase.apps.where((app) => app.name == name);
    final app = matches.isNotEmpty
        ? matches.first
        : await Firebase.initializeApp(name: name, options: options);
    final appCheck = FirebaseAppCheck.instanceFor(app: app);
    const debugProvider = bool.fromEnvironment(
      'PORTAL_APP_CHECK_DEBUG',
      defaultValue: kDebugMode,
    );
    if (debugProvider && kReleaseMode) {
      throw StateError(
        'App Check debug providers require a development build.',
      );
    }
    await appCheck.activate(
      providerAndroid: debugProvider
          ? const AndroidDebugProvider()
          : const AndroidPlayIntegrityProvider(),
      providerApple: debugProvider
          ? const AppleDebugProvider()
          : const AppleAppAttestWithDeviceCheckFallbackProvider(),
    );
    portalDebugLog(
      'firebase.ready project=${app.options.projectId} app=${app.options.appId} '
      'appCheck=${debugProvider ? 'debug' : 'device'}',
      model: portalModelName,
    );
    return FirebaseAI.googleAI(app: app);
  }
}
