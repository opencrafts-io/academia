import 'package:in_app_update/src/domain/update_campaign.dart';

sealed class AppUpdateDecision {
  const AppUpdateDecision();
}

class NoAppUpdate extends AppUpdateDecision {
  const NoAppUpdate();
}

class OptionalAppUpdate extends AppUpdateDecision {
  const OptionalAppUpdate(this.campaign);

  final UpdateCampaign campaign;
}

class RequiredAppUpdate extends AppUpdateDecision {
  const RequiredAppUpdate(this.campaign);

  final UpdateCampaign campaign;
}
