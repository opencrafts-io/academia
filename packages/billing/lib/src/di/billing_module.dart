import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'billing_module.config.dart';

@InjectableInit(
  initializerName: 'initBilling',
  preferRelativeImports: true,
  asExtension: false,
)
void configureBillingDependencies(GetIt getIt) {
  initBilling(getIt);
}
