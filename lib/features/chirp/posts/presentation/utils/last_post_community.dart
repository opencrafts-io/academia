import 'package:shared_preferences/shared_preferences.dart';

/// Remembers which community the user last posted to, so the composer can
/// start there instead of asking every time.
class LastPostCommunity {
  static const _key = 'chirp_last_post_community_id';

  const LastPostCommunity._();

  static Future<int?> read() async {
    try {
      return (await SharedPreferences.getInstance()).getInt(_key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> write(int communityId) async {
    try {
      await (await SharedPreferences.getInstance()).setInt(_key, communityId);
    } catch (_) {
      // Best effort: losing this only means the user picks again next time.
    }
  }
}
