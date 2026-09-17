/// Each feature claims a unique namespace to avoid notification ID collisions.
///
/// Structure: namespace + (localId * slotsPerEntry) + slotIndex
/// Max localId per feature ≈ 213 million before int32 overflow.
abstract class NotificationNamespaces {
  static const int todos = 10_000_000;
  static const int assignments = 20_000_000;
  static const int exams = 30_000_000;
  // add features here as needed
}
