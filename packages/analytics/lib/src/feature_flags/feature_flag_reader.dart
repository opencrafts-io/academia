abstract interface class FeatureFlagReader {
  Future<Object?> readJson(String key);

  Future<bool> isEnabled(String key);
}
