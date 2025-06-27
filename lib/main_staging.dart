import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingleton<FlavorConfig>(
    FlavorConfig(
      flavor: Flavor.staging,
      appName: "Academia - Staging",
      apiBaseUrl: "http://62.169.16.219:8000",
    ),
  );

  runApp(Academia());
}
