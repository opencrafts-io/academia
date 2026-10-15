import ActivityKit
import Foundation

@available(iOS 16.1, *)
struct PomodoroActivityAttributes: ActivityAttributes {
  struct ContentState: Codable, Hashable {
    var phase: String
    var startAt: Date?
    var endAt: Date?
    var remainingSeconds: Int
    var totalSeconds: Int
    var isRunning: Bool
    var todoTitle: String?
  }

  var sessionId: String
}
