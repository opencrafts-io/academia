import 'package:academia/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class Academia extends StatefulWidget {
  const Academia({super.key});

  @override
  State<Academia> createState() => _AcademiaState();
}

class _AcademiaState extends State<Academia> {
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  /// On Android phones with 120hz display by default is chosen the wrong
  /// display mode (e.g. 60hz instead 120hz).
  /// This can easily be corrected, then performance on phones like Oneplus 8T or
  /// Galaxy S20+ is great.
  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution =
        supported
            .where(
              (DisplayMode m) =>
                  m.width == active.width && m.height == active.height,
            )
            .toList()
          ..sort(
            (DisplayMode a, DisplayMode b) =>
                b.refreshRate.compareTo(a.refreshRate),
          );

    final DisplayMode mostOptimalMode = sameResolution.isNotEmpty
        ? sameResolution.first
        : active;

    /// This setting is per session.
    /// Please ensure this was placed with `initState` of your root widget.
    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRouter.router);
  }
}
