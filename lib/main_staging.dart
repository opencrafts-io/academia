import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/firebase_options.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

void main(args) async {
  WidgetsFlutterBinding.ensureInitialized();

  MediaKit.ensureInitialized();
  
  if (runWebViewTitleBarWidget(args)) {
    return;
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init(
    FlavorConfig(
      flavor: Flavor.staging,
      appName: "Academia - Staging",
      apiBaseUrl: "https://api.opencrafts.io",
    ),
  );

  runApp(Academia());
}
