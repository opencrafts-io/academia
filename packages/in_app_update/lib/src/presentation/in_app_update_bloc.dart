import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/src/application/app_update_configuration_source.dart';
import 'package:in_app_update/src/application/app_update_platform_provider.dart';
import 'package:in_app_update/src/application/app_update_store_urls.dart';
import 'package:in_app_update/src/application/app_version_provider.dart';
import 'package:in_app_update/src/domain/app_update_decision.dart';
import 'package:in_app_update/src/domain/app_update_policy_evaluator.dart';
import 'package:in_app_update/src/domain/update_campaign.dart';
import 'package:injectable/injectable.dart';

sealed class InAppUpdateEvent {
  const InAppUpdateEvent();
}

class CheckForInAppUpdateEvent extends InAppUpdateEvent {
  const CheckForInAppUpdateEvent();
}

sealed class InAppUpdateState {
  const InAppUpdateState();
}

class InAppUpdateInitial extends InAppUpdateState {
  const InAppUpdateInitial();
}

class InAppUpdateNotRequired extends InAppUpdateState {
  const InAppUpdateNotRequired();
}

class InAppUpdateOptional extends InAppUpdateState {
  const InAppUpdateOptional(this.campaign);

  final UpdateCampaign campaign;
}

class InAppUpdateRequired extends InAppUpdateState {
  const InAppUpdateRequired(this.campaign);

  final UpdateCampaign campaign;
}

@lazySingleton
class InAppUpdateBloc extends Bloc<InAppUpdateEvent, InAppUpdateState> {
  InAppUpdateBloc({
    required this.configurationSource,
    required this.platformProvider,
    required this.versionProvider,
    required this.storeUrls,
    AppUpdatePolicyEvaluator? policyEvaluator,
  }) : policyEvaluator = policyEvaluator ?? AppUpdatePolicyEvaluator(),
       super(const InAppUpdateInitial()) {
    on<CheckForInAppUpdateEvent>(_checkForUpdate);
  }

  final AppUpdateConfigurationSource configurationSource;
  final AppUpdatePlatformProvider platformProvider;
  final AppVersionProvider versionProvider;
  final AppUpdateStoreUrls storeUrls;
  final AppUpdatePolicyEvaluator policyEvaluator;

  Future<void> _checkForUpdate(
    CheckForInAppUpdateEvent event,
    Emitter<InAppUpdateState> emit,
  ) async {
    try {
      final platform = platformProvider.currentPlatform;
      if (platform == null) {
        emit(const InAppUpdateNotRequired());
        return;
      }

      final result = policyEvaluator.evaluate(
        rawConfiguration: await configurationSource.load(),
        platform: platform,
        currentVersion: await versionProvider.currentVersion(),
        fallbackStoreUrl: storeUrls.forPlatform(platform),
      );
      switch (result) {
        case RequiredAppUpdate(:final campaign):
          emit(InAppUpdateRequired(campaign));
        case OptionalAppUpdate(:final campaign):
          emit(InAppUpdateOptional(campaign));
        case NoAppUpdate():
          emit(const InAppUpdateNotRequired());
      }
    } catch (_) {
      emit(const InAppUpdateNotRequired());
    }
  }
}
