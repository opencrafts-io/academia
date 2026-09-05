import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:billing/billing.dart';

import 'package:injectable/injectable.dart';

import 'package:get_it/get_it.dart';


@InjectableInit()
void configureDependencies(GetIt getIt) {
  configureCoreDependencies(getIt);
  configureLocalDatabaseDependencies(getIt);
  configureBillingDependencies(getIt);
}
