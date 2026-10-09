import 'package:core/config/flavor.dart';

class RewardsApiPaths {
  const RewardsApiPaths(this._flavor);

  final FlavorConfig _flavor;

  String get _prefix => switch (_flavor.flavor) {
    Flavor.production => '/verisafe',
    Flavor.staging => '/qa-verisafe',
    Flavor.development => '/dev-verisafe',
  };

  String get account => '$_prefix/accounts/me';
  String get activities => '$_prefix/activity/active';
  String get completeActivity => '$_prefix/users/activity/complete';
  String get streaks => '$_prefix/users/streaks/me';
  String get milestones => '$_prefix/streaks/milestone/active';
  String activityHistory(String accountId) =>
      '$_prefix/users/activity/completions/for-user/$accountId';
}
