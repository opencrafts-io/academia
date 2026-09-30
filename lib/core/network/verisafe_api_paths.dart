import 'package:core/config/flavor.dart';

/// Builds routes served under the flavor-specific Verisafe API prefix.
class VerisafeApiPaths {
  const VerisafeApiPaths(this.flavor);

  final FlavorConfig flavor;

  String get servicePrefix => switch (flavor.flavor) {
    Flavor.production => 'verisafe',
    Flavor.staging => 'qa-verisafe',
    Flavor.development => 'dev-verisafe',
  };

  String auth(String endpoint) => '/$servicePrefix/auth/$endpoint';
}
