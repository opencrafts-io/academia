import 'package:core/core.dart';
import 'package:core/config/flavor.dart';
import 'package:database/database.dart';
import 'package:billing/billing.dart';
import 'package:ads/ads.dart';
import 'package:lock_in/lock_in.dart';

import 'package:injectable/injectable.dart';

import 'package:get_it/get_it.dart';

@InjectableInit()
void configureDependencies(GetIt getIt, FlavorConfig flavorConfig) {
  configureCoreDependencies(getIt, flavorConfig);
  configureLocalDatabaseDependencies(getIt);
  configureLockInDependencies(getIt);
  configureBillingDependencies(getIt);
  configureAdsDependencies(getIt);
}
