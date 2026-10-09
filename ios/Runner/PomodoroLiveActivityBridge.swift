import ActivityKit
import Flutter
import Foundation

private enum PomodoroLiveActivityError: LocalizedError {
  case unsupported
  case disabled
  case invalidArguments(String)
  case activityNotFound(String)

  var errorDescription: String? {
    switch self {
    case .unsupported:
      return "Pomodoro Live Activities require iOS 16.1 or later."
    case .disabled:
      return "Live Activities are disabled for Academia or in iOS Settings. Enable them to show the Pomodoro timer."
    case .invalidArguments(let reason):
      return reason
    case .activityNotFound(let sessionId):
      return "No active Pomodoro Live Activity was found for session \(sessionId)."
    }
  }

  var flutterCode: String {
    switch self {
    case .unsupported: return "live_activities_unsupported"
    case .disabled: return "live_activities_disabled"
    case .invalidArguments: return "invalid_arguments"
    case .activityNotFound: return "activity_not_found"
    }
  }
}

@available(iOS 16.1, *)
@MainActor
final class PomodoroLiveActivityBridge {
  private struct TimerArguments {
    let sessionId: String
    let phase: String
    let startAt: Date?
    let endAt: Date?
    let totalDurationSeconds: Int?
    let remainingSeconds: Int
    let isRunning: Bool
    let todoTitle: String?

    init(_ value: Any?) throws {
      guard let arguments = value as? [String: Any],
            let sessionId = arguments["sessionId"] as? String,
            !sessionId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let phase = arguments["phase"] as? String,
            ["focus", "shortBreak", "longBreak"].contains(phase),
            let remainingSeconds = arguments["remainingSeconds"] as? Int,
            let isRunning = arguments["isRunning"] as? Bool
      else {
        throw PomodoroLiveActivityError.invalidArguments(
          "Expected sessionId, phase, remainingSeconds, and isRunning for a Pomodoro Live Activity."
        )
      }

      self.sessionId = sessionId
      self.phase = phase
      self.remainingSeconds = max(remainingSeconds, 0)
      self.isRunning = isRunning
      self.todoTitle = (arguments["todoTitle"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
      if let totalDurationSeconds = arguments["totalDurationSeconds"] as? Int {
        guard totalDurationSeconds > 0 else {
          throw PomodoroLiveActivityError.invalidArguments("totalDurationSeconds must be greater than zero.")
        }
        self.totalDurationSeconds = totalDurationSeconds
      } else {
        self.totalDurationSeconds = nil
      }

      if isRunning {
        guard let startMillis = arguments["startAtEpochMillis"] as? Int,
              let endMillis = arguments["endAtEpochMillis"] as? Int
        else {
          throw PomodoroLiveActivityError.invalidArguments(
            "A running Pomodoro Live Activity needs startAtEpochMillis and endAtEpochMillis."
          )
        }
        let start = Date(timeIntervalSince1970: Double(startMillis) / 1_000)
        let end = Date(timeIntervalSince1970: Double(endMillis) / 1_000)
        guard end > start else {
          throw PomodoroLiveActivityError.invalidArguments(
            "endAtEpochMillis must be later than startAtEpochMillis."
          )
        }
        self.startAt = start
        self.endAt = end
      } else {
        self.startAt = nil
        self.endAt = nil
      }
    }

    func contentState(previous: PomodoroActivityAttributes.ContentState?) -> PomodoroActivityAttributes.ContentState {
      let duration: Int
      if let totalDurationSeconds {
        duration = totalDurationSeconds
      } else if let startAt, let endAt {
        duration = max(Int(endAt.timeIntervalSince(startAt)), 1)
      } else if previous?.phase == phase {
        duration = max(previous?.totalSeconds ?? remainingSeconds, 1)
      } else {
        duration = max(remainingSeconds, 1)
      }

      return PomodoroActivityAttributes.ContentState(
        phase: phase,
        startAt: startAt,
        endAt: endAt,
        remainingSeconds: remainingSeconds,
        totalSeconds: duration,
        isRunning: isRunning,
        todoTitle: todoTitle
      )
    }
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    Task { @MainActor in
      do {
        switch call.method {
        case "start":
          try await start(TimerArguments(call.arguments))
          result(nil)
        case "update":
          try await update(TimerArguments(call.arguments))
          result(nil)
        case "stop":
          await stop(sessionId: (call.arguments as? [String: Any])?["sessionId"] as? String)
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      } catch let error as PomodoroLiveActivityError {
        result(FlutterError(code: error.flutterCode, message: error.localizedDescription, details: nil))
      } catch {
        result(FlutterError(code: "live_activity_failed", message: error.localizedDescription, details: nil))
      }
    }
  }

  private func ensureActivitiesEnabled() throws {
    guard ActivityAuthorizationInfo().areActivitiesEnabled else {
      throw PomodoroLiveActivityError.disabled
    }
  }

  private func matchingActivity(sessionId: String) -> Activity<PomodoroActivityAttributes>? {
    Activity<PomodoroActivityAttributes>.activities.first { $0.attributes.sessionId == sessionId }
  }

  private func start(_ arguments: TimerArguments) async throws {
    try ensureActivitiesEnabled()

    if let activity = matchingActivity(sessionId: arguments.sessionId) {
      let state = arguments.contentState(previous: activity.contentState)
      await activity.update(using: state)
      return
    }

    // There is one Pomodoro timer at a time. End any older activity when a new
    // session starts so a previous timer cannot remain beside the current one.
    for activity in Activity<PomodoroActivityAttributes>.activities {
      await activity.end(using: nil, dismissalPolicy: .immediate)
    }

    let state = arguments.contentState(previous: nil)
    _ = try Activity.request(
      attributes: PomodoroActivityAttributes(sessionId: arguments.sessionId),
      contentState: state,
      pushType: nil
    )
  }

  private func update(_ arguments: TimerArguments) async throws {
    try ensureActivitiesEnabled()
    guard let activity = matchingActivity(sessionId: arguments.sessionId) else {
      throw PomodoroLiveActivityError.activityNotFound(arguments.sessionId)
    }

    let state = arguments.contentState(previous: activity.contentState)
    await activity.update(using: state)
  }

  private func stop(sessionId: String?) async {
    let activities = Activity<PomodoroActivityAttributes>.activities.filter { activity in
      guard let sessionId, !sessionId.isEmpty else { return true }
      return activity.attributes.sessionId == sessionId
    }
    for activity in activities {
      await activity.end(using: nil, dismissalPolicy: .immediate)
    }
  }
}
