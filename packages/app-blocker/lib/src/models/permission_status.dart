/// The status of required permissions for app blocking.
enum BlockerPermissionStatus {
  /// All required permissions are granted.
  granted,

  /// One or more permissions are denied but can be requested.
  denied,

  /// Permissions are restricted and cannot be requested.
  ///
  /// On iOS, this may occur when parental controls restrict the feature.
  restricted,
}
