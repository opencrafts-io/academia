import 'package:core/config/flavor.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class BillingApiPaths {
  BillingApiPaths(this._flavorConfig);

  final FlavorConfig _flavorConfig;

  String get _prefix =>
      _flavorConfig.isProduction ? '/verisafe' : '/qa-verisafe';

  String get plans => '$_prefix/plans';
  String get orders => '$_prefix/orders';
  String get checkoutSessions => '$_prefix/checkout-sessions';
  String orderItems(String orderId) => '$orders/$orderId/items';
  String get subscription => '$_prefix/subscriptions/me';
  String entitlements(String planCode) =>
      '$_prefix/entitlements/$planCode';
}
