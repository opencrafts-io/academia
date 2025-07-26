import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:academia/injection_container.dart' as di;
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main(args) async {
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://a80ab93fc282412306a4dc2539a5673f@o4509728817086464.ingest.us.sentry.io/4509732304191488';
      options.tracesSampleRate = 1.0;
      options.replay.sessionSampleRate = 1.0;
      options.replay.onErrorSampleRate = 1.0;
    },
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (runWebViewTitleBarWidget(args)) {
    return;
  }
  await di.init(
    FlavorConfig(
      flavor: Flavor.staging,
      appName: "Academia - Staging",
      apiBaseUrl: "https://qaverisafe.opencrafts.io",
    ),
  );

  runApp(SentryWidget(child: Academia()));
}