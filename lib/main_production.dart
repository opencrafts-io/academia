import 'dart:async';
import 'dart:io';

import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/firebase_options.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import './background_callback_dispatcher.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

void main(List<String> args) async {
  await runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // PostHog Configuration
      final config = PostHogConfig(
        'phc_32udm2EGDp8WC0DylStvkmMCvezSDVkDIRKhSMz0IYH',
      );
      config.host = 'https://eu.i.posthog.com';
      config.debug = kDebugMode;
      config.flushAt = 10;
      config.captureApplicationLifecycleEvents = true;
      config.sessionReplay = true;
      config.sessionReplayConfig.maskAllTexts = false;
      config.sessionReplayConfig.maskAllImages = false;

      // Enable exception autocapture
      config.errorTrackingConfig.captureFlutterErrors = true;
      config.errorTrackingConfig.capturePlatformDispatcherErrors = true;
      config.errorTrackingConfig.captureIsolateErrors = true;
      config.errorTrackingConfig.captureNativeExceptions = true;
      config.errorTrackingConfig.captureSilentFlutterErrors = false;

      await Posthog().setup(config);

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
                (await getApplicationDocumentsDirectory()).path,
              ),
      );

      if (runWebViewTitleBarWidget(args)) {
        return;
      }

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (!kIsWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          await Workmanager().initialize(backgroundCallbackDispatcher);
          await registerDefaultBackgroundTasks();
        }
      }

      await di.init(
        FlavorConfig(
          flavor: Flavor.production,
          appName: "Academia",
          apiBaseUrl: "https://api.opencrafts.io",
        ),
      );

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
      Posthog().captureException(error: error, stackTrace: stack);
    },
  );
}
