import 'package:academia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShereheUtils {
  /// Extracts initials from a name
  static String getInitials(String name) {
    if (name.trim().isEmpty) return "?";

    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return parts.first[0].toUpperCase() + parts.last[0].toUpperCase();
  }

  /// Formats an ISO date string (e.g. 2025-11-20)
  static String formatDate(String isoString, {String pattern = 'dd MMM yyyy'}) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat(pattern).format(dateTime);
    } catch (_) {
      return isoString;
    }
  }

  /// Formats time from an ISO string
  static String formatTime(String isoString, {String pattern = 'hh:mm a'}) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat(pattern).format(dateTime);
    } catch (_) {
      return isoString;
    }
  }

  static int getCrossAxisCount(BuildContext context) {
    if (ResponsiveBreakPoints.isMobile(context)) return 1;
    if (ResponsiveBreakPoints.isTablet(context)) return 2;
    return 3;
  }

  static double getMainAxisExtent(BuildContext context) {
    return ResponsiveBreakPoints.isMobile(context) ? 440 : 500;
  }
}
