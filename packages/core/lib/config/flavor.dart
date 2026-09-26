/// Enum to define available app flavors.
///
/// This is used to differentiate between different versions of the app,
/// such as development, staging, and production environments.
enum Flavor { development, staging, production }

/// Configuration for the app flavor currently in use.
///
/// Holds flavor-specific values such as the app name and API base URL, and
/// provides convenience getters for checking the active environment.
class FlavorConfig {
  /// Creates a flavor configuration.
  FlavorConfig({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
  }) : flavorName = flavor.name;

  /// The current app flavor.
  final Flavor flavor;

  /// The name of the application.
  final String appName;

  /// The base URL for API calls.
  final String apiBaseUrl;

  /// The human-readable name of the current flavor.
  final String flavorName;

  /// Whether the app is running in the development environment.
  bool get isDevelopment => flavor == Flavor.development;

  /// Whether the app is running in the staging environment.
  bool get isStaging => flavor == Flavor.staging;

  /// Whether the app is running in the production environment.
  bool get isProduction => flavor == Flavor.production;
}
