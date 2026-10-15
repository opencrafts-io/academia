import ActivityKit
import SwiftUI
import WidgetKit

@available(iOS 16.1, *)
struct PomodoroLiveActivityWidget: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: PomodoroActivityAttributes.self) { context in
      PomodoroLockScreenView(state: context.state)
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Image(systemName: PomodoroPresentation.symbol(for: context.state.phase))
            .font(.title3.weight(.semibold))
            .foregroundStyle(PomodoroPresentation.tint)
            .padding(.leading, 4)
        }
        DynamicIslandExpandedRegion(.trailing) {
          PomodoroCountdown(state: context.state)
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .padding(.trailing, 4)
        }
        DynamicIslandExpandedRegion(.bottom) {
          HStack(spacing: 8) {
            Text(PomodoroPresentation.title(for: context.state.phase))
              .font(.headline)
            if let title = PomodoroPresentation.todoTitle(context.state.todoTitle) {
              Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
            }
            Spacer(minLength: 0)
          }
          .padding(.horizontal, 4)
        }
      } compactLeading: {
        Image(systemName: PomodoroPresentation.symbol(for: context.state.phase))
          .foregroundStyle(PomodoroPresentation.tint)
      } compactTrailing: {
        PomodoroCountdown(state: context.state)
          .font(.system(size: 14, weight: .semibold, design: .rounded))
          .monospacedDigit()
          .accessibilityLabel("Time remaining")
      } minimal: {
        Image(systemName: PomodoroPresentation.symbol(for: context.state.phase))
          .foregroundStyle(PomodoroPresentation.tint)
      }
      .keylineTint(PomodoroPresentation.tint)
    }
  }
}

@available(iOS 16.1, *)
private struct PomodoroLockScreenView: View {
  let state: PomodoroActivityAttributes.ContentState

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack(spacing: 8) {
        Image(systemName: PomodoroPresentation.symbol(for: state.phase))
          .foregroundStyle(PomodoroPresentation.tint)
          .accessibilityHidden(true)
        Text(PomodoroPresentation.title(for: state.phase))
          .font(.headline)
        Spacer(minLength: 12)
        PomodoroCountdown(state: state)
          .font(.system(.title2, design: .rounded, weight: .semibold))
          .monospacedDigit()
          .accessibilityLabel("Time remaining")
      }

      if let title = PomodoroPresentation.todoTitle(state.todoTitle) {
        Text(title)
          .font(.subheadline)
          .lineLimit(1)
          .truncationMode(.tail)
      }

      PomodoroProgress(state: state)
        .accessibilityLabel("Pomodoro progress")
    }
    .padding(16)
    .foregroundStyle(.white)
    .activityBackgroundTint(PomodoroPresentation.background)
    .activitySystemActionForegroundColor(.white)
  }
}

@available(iOS 16.1, *)
private struct PomodoroCountdown: View {
  let state: PomodoroActivityAttributes.ContentState

  var body: some View {
    Group {
      if state.isRunning, let startAt = state.startAt, let endAt = state.endAt {
        Text(timerInterval: startAt...endAt, countsDown: true)
      } else {
        Text(PomodoroPresentation.timeString(state.remainingSeconds))
      }
    }
  }
}

@available(iOS 16.1, *)
private struct PomodoroProgress: View {
  let state: PomodoroActivityAttributes.ContentState

  var body: some View {
    Group {
      if state.isRunning, let startAt = state.startAt, let endAt = state.endAt {
        ProgressView(timerInterval: startAt...endAt, countsDown: false)
      } else {
        let elapsed = max(state.totalSeconds - state.remainingSeconds, 0)
        ProgressView(value: Double(elapsed), total: Double(max(state.totalSeconds, 1)))
      }
    }
    .progressViewStyle(.linear)
    .tint(PomodoroPresentation.tint)
  }
}

@available(iOS 16.1, *)
private enum PomodoroPresentation {
  static let tint = Color(red: 0.43, green: 0.82, blue: 0.77)
  static let background = Color(red: 0.09, green: 0.13, blue: 0.18)

  static func title(for phase: String) -> String {
    switch phase {
    case "shortBreak": return "Short break"
    case "longBreak": return "Long break"
    default: return "Focus"
    }
  }

  static func symbol(for phase: String) -> String {
    switch phase {
    case "shortBreak": return "cup.and.saucer.fill"
    case "longBreak": return "leaf.fill"
    default: return "timer"
    }
  }

  static func todoTitle(_ title: String?) -> String? {
    guard let title = title?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty else {
      return nil
    }
    return title
  }

  static func timeString(_ seconds: Int) -> String {
    let safeSeconds = max(seconds, 0)
    let hours = safeSeconds / 3_600
    let minutes = (safeSeconds % 3_600) / 60
    let remainder = safeSeconds % 60
    if hours > 0 {
      return String(format: "%d:%02d:%02d", hours, minutes, remainder)
    }
    return String(format: "%02d:%02d", minutes, remainder)
  }
}
