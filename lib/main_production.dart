import 'dart:async';
import 'dart:io';

import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import './background_callback_dispatcher.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

void main(List<String> args) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final (storageDir, _) = await (
        getApplicationDocumentsDirectory(),
        di.init(
          FlavorConfig(
            flavor: Flavor.production,
            appName: "Academia",
            apiBaseUrl: "https://api.opencrafts.io",
          ),
        ),
      ).wait;

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(storageDir.path),
      );

      if (runWebViewTitleBarWidget(args)) {
        return;
      }

      await _initPostHog();

      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        await Workmanager().initialize(backgroundCallbackDispatcher);
        await registerDefaultBackgroundTasks();
      }

      await di.sl.allReady();

      runApp(
        PostHogWidget(
          child: DioRequestInspectorMain(
            inspector: di.sl<DioRequestInspector>(),
            child: Academia(),
          ),
        ),
      );
    },
    (error, stack) {
      try {
        Posthog().captureRunZonedGuardedError(error: error, stackTrace: stack);
      } catch (e) {
        debugPrint(e.toString());
      }
    },
  );
}

Future<void> _initPostHog() async {
  final config =
      PostHogConfig('phc_32udm2EGDp8WC0DylStvkmMCvezSDVkDIRKhSMz0IYH')
        ..host = 'https://eu.i.posthog.com'
        ..debug = kDebugMode
        ..flushAt = 10
        ..captureApplicationLifecycleEvents = true
        ..sessionReplay = true
        ..sessionReplayConfig.maskAllTexts = false
        ..sessionReplayConfig.maskAllImages = false
        ..errorTrackingConfig.captureFlutterErrors = true
        ..errorTrackingConfig.capturePlatformDispatcherErrors = true
        ..errorTrackingConfig.captureIsolateErrors = true
        ..errorTrackingConfig.captureNativeExceptions = true
        ..errorTrackingConfig.captureSilentFlutterErrors = false;
  await Posthog().setup(config);
}
