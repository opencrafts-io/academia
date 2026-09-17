/// The current blocking status of an application.
enum BlockStatus {
  /// The app is currently blocked.
  blocked,

  /// The app is not blocked.
  unblocked,

  /// The app is scheduled to be blocked (but not currently blocked).
  scheduled,
}
