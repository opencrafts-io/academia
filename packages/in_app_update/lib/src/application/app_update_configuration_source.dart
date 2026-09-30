abstract interface class AppUpdateConfigurationSource {
  Future<Object?> load();
}

class DisabledAppUpdateConfigurationSource
    implements AppUpdateConfigurationSource {
  const DisabledAppUpdateConfigurationSource();

  @override
  Future<Object?> load() async => null;
}
