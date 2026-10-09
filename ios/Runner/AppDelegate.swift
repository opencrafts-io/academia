import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let didFinishLaunching = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    registerPomodoroLiveActivityChannel()
    return didFinishLaunching
  }

  private func registerPomodoroLiveActivityChannel() {
    guard let controller = window?.rootViewController as? FlutterViewController else { return }

    let channel = FlutterMethodChannel(
      name: "io.opencrafts.academia/pomodoro_status",
      binaryMessenger: controller.binaryMessenger
    )
    if #available(iOS 16.1, *) {
      let bridge = PomodoroLiveActivityBridge()
      channel.setMethodCallHandler { call, result in
        bridge.handle(call, result: result)
      }
    } else {
      channel.setMethodCallHandler { call, result in
        switch call.method {
        case "start", "update", "stop":
          result(FlutterError(
            code: "live_activities_unsupported",
            message: "Pomodoro Live Activities require iOS 16.1 or later.",
            details: nil
          ))
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }
}
