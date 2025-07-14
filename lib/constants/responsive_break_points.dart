import 'package:flutter/widgets.dart';

class ResponsiveBreakPoints {
  // Define your breakpoint values as static constants.
  // These values typically represent the *maximum* width for a given breakpoint
  // before the next larger breakpoint kicks in.
  static const double mobile = 600.0; // Up to 600.0 logical pixels wide
  static const double tablet = 1024.0; // Up to 1024.0 logical pixels wide
  static const double desktop = 1440.0; // Up to 1440.0 logical pixels wide
  static const double largeDesktop = 1920.0; // Up to 1920.0 logical pixels wide

  /// Checks if the current screen width corresponds to a mobile device.
  /// Typically, anything less than or equal to the [mobile] breakpoint.
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= mobile;
  }

  /// Checks if the current screen width corresponds to a tablet device.
  /// Typically, greater than [mobile] and less than or equal to [tablet].
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > mobile && width <= tablet;
  }

  /// Checks if the current screen width corresponds to a desktop device.
  /// Typically, greater than [tablet] and less than or equal to [desktop].
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > tablet && width <= desktop;
  }

  /// Checks if the current screen width corresponds to a large desktop device.
  /// Typically, greater than [desktop].
  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > desktop;
  }

  /// A more general method to get the current device type as a string.
  static String getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= mobile) {
      return 'Mobile';
    } else if (width <= tablet) {
      return 'Tablet';
    } else if (width <= desktop) {
      return 'Desktop';
    } else {
      return 'Large Desktop';
    }
  }
}
