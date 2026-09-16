import Foundation
import ManagedSettings
import FamilyControls
import CryptoKit

/// Manages the Screen Time shield that blocks apps.
///
/// Apple's `ApplicationToken` and `ActivityCategoryToken` are opaque values
/// that cannot be constructed from a string identifier — they are obtained
/// only through a `FamilyActivityPicker` or a `FamilyActivitySelection`. This
/// class therefore maintains a two-level persistence strategy:
///
/// 1. **Token mappings** — a dictionary from a stable string identifier to the
///    raw `Data` of the encoded token, stored in `UserDefaults`.
/// 2. **Active token sets** — the in-memory sets of tokens currently applied
///    to the `ManagedSettingsStore`.
///
/// Both dictionaries are synchronised through a concurrent dispatch queue with
/// barrier writes to prevent race conditions on background threads.
///
/// - Note: All public methods are safe to call from any thread.
class ShieldManager: NSObject {

    // MARK: - Private state

    private let store = ManagedSettingsStore()

    private let queue = DispatchQueue(
        label: "com.khanhtq.app_blocker.ShieldManager",
        attributes: .concurrent
    )

    private var _blockedApplicationTokens: Set<ApplicationToken> = []
    private var _blockedCategoryTokens: Set<ActivityCategoryToken> = []
    private var _identifierToAppTokenData: [String: Data] = [:]
    private var _identifierToCategoryTokenData: [String: Data] = [:]

    private let userDefaultsKey = "app_blocker_token_mappings"
    private let blockedAllKey = "app_blocker_blocked_all"

    // MARK: - Thread-safe accessors

    private var blockedApplicationTokens: Set<ApplicationToken> {
        get { queue.sync { _blockedApplicationTokens } }
        set { queue.async(flags: .barrier) { self._blockedApplicationTokens = newValue } }
    }

    private var blockedCategoryTokens: Set<ActivityCategoryToken> {
        get { queue.sync { _blockedCategoryTokens } }
        set { queue.async(flags: .barrier) { self._blockedCategoryTokens = newValue } }
    }

    private var identifierToAppTokenData: [String: Data] {
        get { queue.sync { _identifierToAppTokenData } }
        set { queue.async(flags: .barrier) { self._identifierToAppTokenData = newValue } }
    }

    private var identifierToCategoryTokenData: [String: Data] {
        get { queue.sync { _identifierToCategoryTokenData } }
        set { queue.async(flags: .barrier) { self._identifierToCategoryTokenData = newValue } }
    }

    // MARK: - Initialisation

    override init() {
        super.init()
        loadTokenMappings()
    }

    // MARK: - Public API

    /// Shields the apps whose tokens were previously stored for [identifiers].
    ///
    /// Identifiers that have no stored token (e.g. because the app was selected
    /// via the system picker under a different identifier key) are silently
    /// skipped — the caller should use `blockWithSelection` when a fresh
    /// `FamilyActivitySelection` is available.
    func blockApps(identifiers: [String]) {
        queue.async(flags: .barrier) {
            let decoder = JSONDecoder()
            var appTokens = self._blockedApplicationTokens
            var catTokens = self._blockedCategoryTokens

            for identifier in identifiers {
                if let data = self._identifierToAppTokenData[identifier] {
                    do {
                        let token = try decoder.decode(ApplicationToken.self, from: data)
                        appTokens.insert(token)
                    } catch {
                        // Token data is stale or format changed; remove the stale entry.
                        self._identifierToAppTokenData.removeValue(forKey: identifier)
                    }
                }
                if let data = self._identifierToCategoryTokenData[identifier] {
                    do {
                        let token = try decoder.decode(ActivityCategoryToken.self, from: data)
                        catTokens.insert(token)
                    } catch {
                        self._identifierToCategoryTokenData.removeValue(forKey: identifier)
                    }
                }
            }

            self._blockedApplicationTokens = appTokens
            self._blockedCategoryTokens = catTokens
            self.applyShieldUnsafe()
            self.saveTokenMappingsUnsafe()
        }
    }

    /// Applies a `FamilyActivitySelection` directly, storing the tokens for
    /// future use with `blockApps` / `unblockApps`.
    func blockWithSelection(selection: FamilyActivitySelection) {
        queue.async(flags: .barrier) {
            self._blockedApplicationTokens = selection.applicationTokens
            self._blockedCategoryTokens = selection.categoryTokens
            self.storeTokensFromSelectionUnsafe(selection: selection)
            self.applyShieldUnsafe()
            self.saveTokenMappingsUnsafe()
        }
    }

    /// Blocks all app categories via the `ManagedSettingsStore`.
    func blockAll() {
        queue.async(flags: .barrier) {
            self.store.shield.applicationCategories = .all()
            UserDefaults.standard.set(true, forKey: self.blockedAllKey)
        }
    }

    /// Removes the shield for [identifiers] that were previously blocked.
    func unblockApps(identifiers: [String]) {
        queue.async(flags: .barrier) {
            let decoder = JSONDecoder()
            for identifier in identifiers {
                if let data = self._identifierToAppTokenData[identifier] {
                    if let token = try? decoder.decode(ApplicationToken.self, from: data) {
                        self._blockedApplicationTokens.remove(token)
                    }
                }
                if let data = self._identifierToCategoryTokenData[identifier] {
                    if let token = try? decoder.decode(ActivityCategoryToken.self, from: data) {
                        self._blockedCategoryTokens.remove(token)
                    }
                }
            }
            self.applyShieldUnsafe()
            self.saveTokenMappingsUnsafe()
        }
    }

    /// Removes all shields and clears persisted state.
    func unblockAll() {
        queue.async(flags: .barrier) {
            self._blockedApplicationTokens = []
            self._blockedCategoryTokens = []
            self.store.shield.applications = nil
            self.store.shield.applicationCategories = nil
            UserDefaults.standard.set(false, forKey: self.blockedAllKey)
            self.saveTokenMappingsUnsafe()
        }
    }

    /// Returns the identifiers of currently blocked apps, or `["__all__"]` if
    /// block-all mode is active.
    func getBlockedApps() -> [String] {
        if UserDefaults.standard.bool(forKey: blockedAllKey) {
            return ["__all__"]
        }

        return queue.sync {
            let decoder = JSONDecoder()
            var result: [String] = []

            for (identifier, data) in _identifierToAppTokenData {
                if let token = try? decoder.decode(ApplicationToken.self, from: data),
                   _blockedApplicationTokens.contains(token) {
                    result.append(identifier)
                }
            }
            for (identifier, data) in _identifierToCategoryTokenData {
                if let token = try? decoder.decode(ActivityCategoryToken.self, from: data),
                   _blockedCategoryTokens.contains(token),
                   !result.contains(identifier) {
                    result.append(identifier)
                }
            }
            return result
        }
    }

    // MARK: - Selection storage (called from ActivityPickerCoordinator)

    /// Stores the tokens from [selection] under stable hash-derived keys and
    /// returns those keys so callers can use them as opaque identifiers.
    ///
    /// Using a hash of the raw token data instead of sequential indices ensures
    /// the same app always maps to the same key across picker sessions, so
    /// previously-blocked apps are never accidentally orphaned.
    @discardableResult
    func storeTokensFromSelection(selection: FamilyActivitySelection) -> [(key: String, isApp: Bool)] {
        return queue.sync(flags: .barrier) {
            let result = self.storeTokensFromSelectionUnsafe(selection: selection)
            self.saveTokenMappingsUnsafe()
            return result
        }
    }

    /// Returns a summary of currently blocked tokens using their stable keys.
    func getSelectionInfo() -> [[String: Any]] {
        return queue.sync {
            var result: [[String: Any]] = []
            let decoder = JSONDecoder()

            for (key, data) in _identifierToAppTokenData {
                if let token = try? decoder.decode(ApplicationToken.self, from: data),
                   _blockedApplicationTokens.contains(token) {
                    result.append([
                        "packageName": key,
                        "appName": "Selected App",
                        "isSystemApp": false,
                    ])
                }
            }
            for (key, data) in _identifierToCategoryTokenData {
                if let token = try? decoder.decode(ActivityCategoryToken.self, from: data),
                   _blockedCategoryTokens.contains(token) {
                    result.append([
                        "packageName": key,
                        "appName": "Selected Category",
                        "isSystemApp": false,
                    ])
                }
            }
            return result
        }
    }

    // MARK: - Private helpers (must be called within queue)

    /// Applies the current in-memory token sets to the `ManagedSettingsStore`.
    /// **Caller must hold the queue write lock.**
    private func applyShieldUnsafe() {
        store.shield.applications = _blockedApplicationTokens.isEmpty ? nil : _blockedApplicationTokens
        if _blockedCategoryTokens.isEmpty {
            store.shield.applicationCategories = nil
        } else {
            store.shield.applicationCategories = .specific(_blockedCategoryTokens)
        }
    }

    /// Stores tokens from a selection under stable keys derived from the
    /// base64-encoded token data itself, and returns those keys paired with
    /// whether each entry is an app (true) or category (false).
    ///
    /// Because the key IS the encoded token, the same app always maps to the
    /// same key across picker sessions — no hashing dependency required.
    /// **Caller must hold the queue write lock.**
    @discardableResult
    private func storeTokensFromSelectionUnsafe(selection: FamilyActivitySelection) -> [(key: String, isApp: Bool)] {
        var result: [(key: String, isApp: Bool)] = []
        for token in selection.applicationTokens {
            if let data = try? JSONEncoder().encode(token) {
                let key = data.base64EncodedString()
                _identifierToAppTokenData[key] = data
                result.append((key: key, isApp: true))
            }
        }
        for token in selection.categoryTokens {
            if let data = try? JSONEncoder().encode(token) {
                let key = data.base64EncodedString()
                _identifierToCategoryTokenData[key] = data
                result.append((key: key, isApp: false))
            }
        }
        return result
    }

    /// Serialises all state to `UserDefaults`.
    /// **Caller must hold the queue write lock.**
    private func saveTokenMappingsUnsafe() {
        let encoder = JSONEncoder()

        let appMappings = _identifierToAppTokenData.compactMapValues { $0.base64EncodedString() }
        let catMappings = _identifierToCategoryTokenData.compactMapValues { $0.base64EncodedString() }

        let blockedAppTokens: [String] = _blockedApplicationTokens.compactMap {
            (try? encoder.encode($0))?.base64EncodedString()
        }
        let blockedCatTokens: [String] = _blockedCategoryTokens.compactMap {
            (try? encoder.encode($0))?.base64EncodedString()
        }

        let storage: [String: Any] = [
            "appMappings": appMappings,
            "catMappings": catMappings,
            "blockedAppTokens": blockedAppTokens,
            "blockedCatTokens": blockedCatTokens,
        ]
        UserDefaults.standard.set(storage, forKey: userDefaultsKey)
    }

    /// Loads persisted token state from `UserDefaults` into the in-memory stores.
    /// Called once from `init()` — no lock needed at that point.
    private func loadTokenMappings() {
        guard let storage = UserDefaults.standard.dictionary(forKey: userDefaultsKey) else {
            return
        }

        let decoder = JSONDecoder()

        if let appMappings = storage["appMappings"] as? [String: String] {
            for (key, base64) in appMappings {
                if let data = Data(base64Encoded: base64) {
                    _identifierToAppTokenData[key] = data
                }
            }
        }

        if let catMappings = storage["catMappings"] as? [String: String] {
            for (key, base64) in catMappings {
                if let data = Data(base64Encoded: base64) {
                    _identifierToCategoryTokenData[key] = data
                }
            }
        }

        if let blockedAppIds = storage["blockedAppTokens"] as? [String] {
            for base64 in blockedAppIds {
                guard let data = Data(base64Encoded: base64) else { continue }
                do {
                    let token = try decoder.decode(ApplicationToken.self, from: data)
                    _blockedApplicationTokens.insert(token)
                } catch {
                    // Token format changed across OS versions; discard silently.
                }
            }
        }

        if let blockedCatIds = storage["blockedCatTokens"] as? [String] {
            for base64 in blockedCatIds {
                guard let data = Data(base64Encoded: base64) else { continue }
                do {
                    let token = try decoder.decode(ActivityCategoryToken.self, from: data)
                    _blockedCategoryTokens.insert(token)
                } catch {
                    // Token format changed across OS versions; discard silently.
                }
            }
        }
    }
}
