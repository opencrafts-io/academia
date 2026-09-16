import Foundation

/// Persists blocking profiles in `UserDefaults` and activates/deactivates them
/// by delegating to `ShieldManager`.
///
/// A profile groups a set of app identifiers (and optionally schedules) that
/// can be blocked atomically. Activating a profile deactivates any previously
/// active profile first. The active profile ID is stored separately from the
/// profile list so that `getProfiles` can annotate each profile with its
/// current active state without mutating the stored list.
class ProfileManager: NSObject {

    private let userDefaultsKey = "app_blocker_profiles"
    private let activeProfileKey = "app_blocker_active_profile_id"

    // Weak reference so ShieldManager's lifetime is not prolonged by ProfileManager.
    private weak var shieldManager: ShieldManager?

    init(shieldManager: ShieldManager) {
        self.shieldManager = shieldManager
        super.init()
    }

    // MARK: - CRUD

    /// Adds [data] as a new profile, replacing any existing profile with the
    /// same `"id"` key. New profiles default to `isActive = false`.
    func createProfile(data: [String: Any]) {
        guard let id = data["id"] as? String else { return }
        var profiles = loadProfiles()
        profiles.removeAll { ($0["id"] as? String) == id }
        var profileData = data
        if profileData["isActive"] == nil { profileData["isActive"] = false }
        profiles.append(profileData)
        saveProfiles(profiles)
    }

    /// Replaces the profile with the same `"id"`, or appends it if absent.
    func updateProfile(data: [String: Any]) {
        guard let id = data["id"] as? String else { return }
        var profiles = loadProfiles()
        if let index = profiles.firstIndex(where: { ($0["id"] as? String) == id }) {
            profiles[index] = data
        } else {
            profiles.append(data)
        }
        saveProfiles(profiles)
    }

    /// Deletes the profile with [id], deactivating it first if it is active.
    func deleteProfile(id: String) {
        let activeId = UserDefaults.standard.string(forKey: activeProfileKey)
        if activeId == id {
            shieldManager?.unblockAll()
            UserDefaults.standard.removeObject(forKey: activeProfileKey)
        }
        var profiles = loadProfiles()
        profiles.removeAll { ($0["id"] as? String) == id }
        saveProfiles(profiles)
    }

    /// Returns all profiles with an injected `"isActive"` field reflecting the
    /// currently active profile ID.
    func getProfiles() -> [[String: Any]] {
        let activeId = UserDefaults.standard.string(forKey: activeProfileKey)
        return loadProfiles().map { profile in
            var p = profile
            p["isActive"] = (p["id"] as? String) == activeId
            return p
        }
    }

    // MARK: - Activation

    /// Activates the profile with [id], deactivating any previously active profile.
    ///
    /// - Returns: `true` if the profile was found and activated; `false` otherwise.
    @discardableResult
    func activateProfile(id: String) -> Bool {
        let profiles = loadProfiles()
        guard let profile = profiles.first(where: { ($0["id"] as? String) == id }) else {
            return false
        }

        // Deactivate the current profile if it differs.
        let currentActiveId = UserDefaults.standard.string(forKey: activeProfileKey)
        if let currentId = currentActiveId, currentId != id {
            deactivateProfile(id: currentId)
        }

        if let appIdentifiers = profile["appIdentifiers"] as? [String] {
            shieldManager?.blockApps(identifiers: appIdentifiers)
        }

        UserDefaults.standard.set(id, forKey: activeProfileKey)
        return true
    }

    /// Deactivates the profile with [id]. No-op if it is not currently active.
    func deactivateProfile(id: String) {
        guard UserDefaults.standard.string(forKey: activeProfileKey) == id else { return }
        shieldManager?.unblockAll()
        UserDefaults.standard.removeObject(forKey: activeProfileKey)
    }

    /// Returns the active profile with an injected `"isActive": true` field,
    /// or `nil` if no profile is active. Cleans up stale active IDs.
    func getActiveProfile() -> [String: Any]? {
        guard let activeId = UserDefaults.standard.string(forKey: activeProfileKey) else {
            return nil
        }
        guard var profile = loadProfiles().first(where: { ($0["id"] as? String) == activeId }) else {
            // The active profile was deleted without going through deactivateProfile.
            UserDefaults.standard.removeObject(forKey: activeProfileKey)
            return nil
        }
        profile["isActive"] = true
        return profile
    }

    // MARK: - Persistence

    private func loadProfiles() -> [[String: Any]] {
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

    private func saveProfiles(_ profiles: [[String: Any]]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: profiles)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            assertionFailure("Failed to serialise profiles: \(error)")
        }
    }
}
