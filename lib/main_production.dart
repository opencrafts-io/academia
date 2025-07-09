import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (runWebViewTitleBarWidget([])) {
    return;
  }

  GetIt.instance.registerSingleton<FlavorConfig>(
    FlavorConfig(
      flavor: Flavor.production,
      appName: "Academia",
      apiBaseUrl: "http://62.169.16.219:8000",
    ),
  );

  runApp(Academia());
}
