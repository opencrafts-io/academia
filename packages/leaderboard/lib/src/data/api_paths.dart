import 'package:core/config/flavor.dart';

class LeaderboardApiPaths {
  const LeaderboardApiPaths(this._flavor);

  final FlavorConfig _flavor;

  String get _prefix => switch (_flavor.flavor) {
    Flavor.production => '/verisafe',
    Flavor.staging => '/qa-verisafe',
    Flavor.development => '/dev-verisafe',
  };

  String get global => '$_prefix/leaderboard/global';

  String around(String accountId) => '$global/$accountId/around';
}
