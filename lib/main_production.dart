import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';

void main(args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (runWebViewTitleBarWidget(args)) {
    return;
  }

  await di.init(
    FlavorConfig(
      flavor: Flavor.production,
      appName: "Academia",
      apiBaseUrl: "https://qaverisafe.opencrafts.io",
    ),
  );

  runApp(Academia());
}
