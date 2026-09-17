import Foundation
import Flutter

/// Delivers block events from native iOS code to the Flutter event stream.
///
/// `FlutterEventSink` must only be called on the main thread. All calls to
/// `sendEvent` dispatch to `DispatchQueue.main` before invoking the sink, so
/// callers may call from any thread.
class BlockEventStreamHandler: NSObject, FlutterStreamHandler {

    /// The active event sink, set by Flutter when a listener subscribes.
    /// Accessed only on the main thread (via `DispatchQueue.main.async`).
    private var eventSink: FlutterEventSink?

    // MARK: - FlutterStreamHandler

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    // MARK: - Public API

    /// Sends a typed block event to the Flutter side.
    ///
    /// Safe to call from any thread.
    ///
    /// - Parameters:
    ///   - type: Event type matching Dart's `BlockEventType` values:
    ///           `"blocked"`, `"unblocked"`, `"attemptedAccess"`,
    ///           `"scheduleActivated"`, `"scheduleDeactivated"`,
    ///           `"profileActivated"`, `"profileDeactivated"`.
    ///   - packageName: Identifier of the affected app, or `nil`.
    ///   - scheduleId: ID of the schedule that triggered the event, or `nil`.
    ///   - profileId: ID of the profile that triggered the event, or `nil`.
    func sendEvent(type: String, packageName: String?, scheduleId: String?, profileId: String? = nil) {
        var event: [String: Any] = [
            "type": type,
            "timestamp": Int(Date().timeIntervalSince1970 * 1000),
        ]
        if let packageName = packageName { event["packageName"] = packageName }
        if let scheduleId = scheduleId { event["scheduleId"] = scheduleId }
        if let profileId = profileId { event["profileId"] = profileId }

        DispatchQueue.main.async { [weak self] in
            self?.eventSink?(event)
        }
    }
}
