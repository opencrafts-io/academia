import 'package:pub_semver/pub_semver.dart';

enum AppUpdateMode { optional, required }

class UpdateCampaign {
  const UpdateCampaign({
    required this.id,
    required this.targetVersion,
    required this.mode,
    required this.title,
    required this.message,
    required this.storeUrl,
  });

  final String id;
  final Version targetVersion;
  final AppUpdateMode mode;
  final String title;
  final String message;
  final Uri storeUrl;
}
