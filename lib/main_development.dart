import 'package:academia/app.dart';
import 'package:academia/config/flavor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt.instance.registerSingleton<FlavorConfig>(
    FlavorConfig(
      flavor: Flavor.development,
      appName: "Academia - Dev",
      apiBaseUrl: "http://62.169.16.219:8000",
    ),
  );

  runApp(Academia());
}
