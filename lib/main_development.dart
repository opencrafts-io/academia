import 'dart:async';
import 'dart:io';

import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/firebase_options.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';
import './background_callback_dispatcher.dart';

void main(args) async {
  await runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      if (runWebViewTitleBarWidget(args)) {
        return;
      }

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (!kIsWeb) {
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        if (Platform.isAndroid || Platform.isIOS) {
          Workmanager().initialize(backgroundCallbackDispatcher);
        }
      }
      await di.init(
        FlavorConfig(
          flavor: Flavor.staging,
          appName: "Academia - Dev",
          apiBaseUrl: "https://api.opencrafts.io",
        ),
      );

      runApp(
        DioRequestInspectorMain(
          inspector: di.sl<DioRequestInspector>(),
          child: Academia(),
        ),
      );
    },
    (error, stacktrace) {
      if (!kIsWeb) {
        FirebaseCrashlytics.instance.recordError(error, stacktrace);
      }
    },
  );
}
