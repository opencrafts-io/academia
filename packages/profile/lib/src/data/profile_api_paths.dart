import 'package:core/config/flavor.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProfileApiPaths {
  ProfileApiPaths(this._flavor);

  final FlavorConfig _flavor;

  String get _prefix => switch (_flavor.flavor) {
    Flavor.production => 'verisafe',
    Flavor.staging => 'qa-verisafe',
    Flavor.development => 'dev-verisafe',
  };

  String get account => '/$_prefix/accounts/me';
  String get phone => '$account/phone';
  String get deletionRequest => '/$_prefix/accounts/deletion-request';
  String get recovery => '/$_prefix/accounts/recovery';
}
