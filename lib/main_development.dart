import 'dart:async';
import 'dart:io';

import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:dio_request_inspector/dio_request_inspector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workmanager/workmanager.dart';
import './background_callback_dispatcher.dart';

void main(List<String> args) async {
  await runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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

      if (!kIsWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          await Workmanager().initialize(backgroundCallbackDispatcher);
          registerDefaultBackgroundTasks();
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
      Logger().e('Caught an uncaught exception', error: error);
    },
  );
}
