import Foundation

/// Persists time-based blocking schedules in `UserDefaults`.
///
/// Schedules are stored as a JSON-encoded array of `[String: Any]` maps, with
/// the same structure expected by the Flutter channel on both platforms.
/// All methods are synchronous and safe to call from the main thread.
class ScheduleManager: NSObject {

    private let userDefaultsKey = "app_blocker_schedules"

    // MARK: - Public API

    /// Adds [data] as a new schedule, replacing any existing schedule with the
    /// same `"id"` key to maintain idempotency.
    func addSchedule(data: [String: Any]) {
        guard let id = data["id"] as? String else { return }
        var schedules = loadSchedules()
        schedules.removeAll { ($0["id"] as? String) == id }
        schedules.append(data)
        saveSchedules(schedules)
    }

    /// Replaces the schedule with the same `"id"`, or appends it if absent.
    func updateSchedule(data: [String: Any]) {
        guard let id = data["id"] as? String else { return }
        var schedules = loadSchedules()
        if let index = schedules.firstIndex(where: { ($0["id"] as? String) == id }) {
            schedules[index] = data
        } else {
            schedules.append(data)
        }
        saveSchedules(schedules)
    }

    /// Removes the schedule with [id]. No-op if not found.
    func removeSchedule(id: String) {
        var schedules = loadSchedules()
        schedules.removeAll { ($0["id"] as? String) == id }
        saveSchedules(schedules)
    }

    /// Returns all persisted schedules.
    func getSchedules() -> [[String: Any]] {
        return loadSchedules()
    }

    /// Sets `"enabled"` to `true` for the schedule with [id].
    func enableSchedule(id: String) {
        setEnabled(true, forId: id)
    }

    /// Sets `"enabled"` to `false` for the schedule with [id].
    func disableSchedule(id: String) {
        setEnabled(false, forId: id)
    }

    // MARK: - Persistence

    private func loadSchedules() -> [[String: Any]] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return []
        }
        do {
            let decoded = try JSONSerialization.jsonObject(with: data)
            return decoded as? [[String: Any]] ?? []
        } catch {
            // Persisted data is corrupt; reset to a clean state.
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
            return []
        }
    }

    private func saveSchedules(_ schedules: [[String: Any]]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: schedules)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            // This should never happen for well-formed schedule maps; assert
            // in debug builds so developers notice if the data model is broken.
            assertionFailure("Failed to serialise schedules: \(error)")
        }
    }

    private func setEnabled(_ enabled: Bool, forId id: String) {
        var schedules = loadSchedules()
        guard let index = schedules.firstIndex(where: { ($0["id"] as? String) == id }) else { return }
        var schedule = schedules[index]
        schedule["enabled"] = enabled
        schedules[index] = schedule
        saveSchedules(schedules)
    }
}
