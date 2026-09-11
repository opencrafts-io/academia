import Foundation
import FamilyControls
import Flutter

/// Checks and requests FamilyControls authorization.
///
/// FamilyControls authorization is required to use `ManagedSettings` for app
/// shielding. The user must explicitly approve the prompt; if they decline,
/// `requestPermission` delivers a `PERMISSION_DENIED` Flutter error.
class PermissionManager: NSObject {

    // MARK: - Public API

    /// Returns the current authorization status as a Dart-compatible string:
    /// - `"granted"` — authorization was approved.
    /// - `"denied"`  — authorization was denied or not yet requested.
    /// - `"restricted"` — an unexpected status was returned by the OS.
    func checkPermission() -> String {
        switch AuthorizationCenter.shared.authorizationStatus {
        case .approved:
            return "granted"
        case .denied, .notDetermined:
            return "denied"
        @unknown default:
            return "restricted"
        }
    }

    /// Requests FamilyControls authorization and delivers the result to [result].
    ///
    /// If the request throws (e.g. the user denied the system prompt), a
    /// `PERMISSION_DENIED` Flutter error is returned. If the request succeeds,
    /// the current status string is returned so the caller can distinguish
    /// between `.approved` and `.denied` without a second round-trip.
    func requestPermission(result: @escaping FlutterResult) {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                await MainActor.run {
                    result(self.checkPermission())
                }
            } catch {
                await MainActor.run {
                    result(FlutterError(
                        code: "PERMISSION_DENIED",
                        message: "Family Controls authorization was denied: \(error.localizedDescription)",
                        details: nil
                    ))
                }
            }
        }
    }
}
