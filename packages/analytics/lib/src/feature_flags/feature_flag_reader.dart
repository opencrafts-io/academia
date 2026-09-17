abstract interface class FeatureFlagReader {
  Future<Object?> readJson(String key);
}
