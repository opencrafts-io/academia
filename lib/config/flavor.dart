/// Enum to define available app flavors
///
/// This is used to differentiate between different versions of the app,
/// such as development, staging, and production environments.
enum Flavor { development, staging, production }

/// Class to manage flavor configurations
///
/// This class provides a structure for managing different app flavors,
/// allowing you to specify flavor-specific properties like the app name
/// and API base URL. It includes helpers to determine the current flavor.
class FlavorConfig {
  /// The current app flavor
  ///
  /// Defines whether the app is running in development, staging, or production.
  final Flavor flavor;

  /// The name of the application
  ///
  /// This can be used for display purposes to indicate the current flavor of the app.
  final String appName;

  /// The base URL for API calls
  ///
  /// This allows you to configure different backend environments for each flavor.
  final String apiBaseUrl;

  /// The human-readable name of the current flavor
  ///
  /// This is derived from the `Flavor` enum and is primarily used for logging or debugging.
  final String flavorName;

  /// Constructor
  ///
  /// Creates an instance of `FlavorConfig` with the specified properties.
  ///
  /// * [flavor] - The app flavor (e.g., `Flavor.dev` for development).
  /// * [appName] - The name of the app for the specified flavor.
  /// * [apiBaseUrl] - The API base URL for the specified flavor.
  FlavorConfig({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
  }) : flavorName = flavor.name;

  /// Checks if the current flavor is development
  ///
  /// Returns `true` if the app is running in the development environment.
  bool get isDevelopment => flavor == Flavor.development;

  /// Checks if the current flavor is staging
  ///
  /// Returns `true` if the app is running in the staging environment.
  bool get isStaging => flavor == Flavor.staging;

  /// Checks if the current flavor is production
  ///
  /// Returns `true` if the app is running in the production environment.
  bool get isProduction => flavor == Flavor.production;
}

/// Example of how to use this class with `get_it` for dependency injection:
///
/// ```dart
/// final getIt = GetIt.instance;
/// getIt.registerSingleton<FlavorConfig>(
///   FlavorConfig(
///     flavor: Flavor.dev,
///     appName: "My App Dev",
///     apiBaseUrl: "https://api.dev.myapp.com",
///   ),
/// );
/// ```
