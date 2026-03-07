import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

part 'in_app_update_event.dart';
part 'in_app_update_state.dart';

class InAppUpdateBloc extends Bloc<InAppUpdateEvent, InAppUpdateState> {
  InAppUpdateBloc() : super(InAppUpdateInitial()) {
    on<CheckForInAppUpdateEvent>((event, emit) async {
      if (kIsWeb) return;
      try {
        await Posthog().reloadFeatureFlags();

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = Version.parse(packageInfo.version);
        final Object? rawPayload = await Posthog().getFeatureFlagResult(
          'app-upgrade-config',
        );

        if (rawPayload is! Map) {
          return;
        }

        final payload = _deepConvert(rawPayload);

        final platformKey = Platform.isAndroid ? 'android' : 'ios';
        final config = payload[platformKey] as Map<String, dynamic>?;

        if (config != null) {
          final minVersionStr = config['min_version'] as String;
          final minVersion = Version.parse(minVersionStr);
          final isCritical = config['is_critical'] as bool? ?? false;
          final message =
              payload['message'] as String? ?? "A new version is available!";

          if (currentVersion < minVersion) {
            emit(
              InAppUpdateRequired(message: message, isMandatory: isCritical),
            );
            return;
          }
        }
        emit(InAppUpdateNotRequired());
      } catch (e) {
        emit(InAppUpdateNotRequired());
      }
    });
  }

  Future<void> redirectToStore() async {
    if (kIsWeb) return;
    final url = Platform.isAndroid
        ? Uri.parse(
            "https://play.google.com/store/apps/details?id=io.opencrafts.academia&hl=en&gl=KE",
          )
        : Uri.parse(
            "https://apps.apple.com/us/app/academia-for-campus-students/id6753922995",
          );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Map<String, dynamic> _deepConvert(Map map) {
    return map.map((key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), _deepConvert(value));
      } else if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((e) => e is Map ? _deepConvert(e) : e).toList(),
        );
      }
      return MapEntry(key.toString(), value);
    });
  }
}
