import 'package:flutter/foundation.dart';

abstract final class BillingApiPaths {
  static String get _prefix => kDebugMode ? '/qa-verisafe' : '/verisafe';

  static String get plans => '$_prefix/plans';
  static String get orders => '$_prefix/orders';
  static String get subscription => '$_prefix/subscriptions/me';
  static String entitlements(String planCode) =>
      '$_prefix/entitlements/$planCode';
}
