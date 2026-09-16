import Flutter
import UIKit

/// Flutter plugin entry-point for app_blocker on iOS.
public class AppBlockerPlugin: NSObject, FlutterPlugin {

    private var permissionManager: PermissionManager?
    var shieldManager: ShieldManager?
    private var activityPickerCoordinator: ActivityPickerCoordinator?
    private var scheduleManager: ScheduleManager?
    private var profileManager: ProfileManager?
    private var eventStreamHandler: BlockEventStreamHandler?

    /// Shared instance exposed to `ActivityPickerCoordinator` for callbacks.
    static var shared: AppBlockerPlugin?

    // MARK: - Registration

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.khanhtq.app_blocker/methods",
            binaryMessenger: registrar.messenger()
        )
        let eventChannel = FlutterEventChannel(
            name: "com.khanhtq.app_blocker/events",
            binaryMessenger: registrar.messenger()
        )

        let instance = AppBlockerPlugin()
        AppBlockerPlugin.shared = instance

        let shield = ShieldManager()
        instance.shieldManager = shield
        instance.scheduleManager = ScheduleManager()
        instance.profileManager = ProfileManager(shieldManager: shield)
        instance.permissionManager = PermissionManager()
        instance.activityPickerCoordinator = ActivityPickerCoordinator()

        instance.eventStreamHandler = BlockEventStreamHandler()
        eventChannel.setStreamHandler(instance.eventStreamHandler)

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    // MARK: - Method dispatch

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getCapabilities":     handleGetCapabilities(result: result)
        case "checkPermission":     handleCheckPermission(result: result)
        case "requestPermission":   handleRequestPermission(result: result)
        case "getApps":             handleGetApps(result: result)
        case "blockApps":           handleBlockApps(call: call, result: result)
        case "blockAll":            handleBlockAll(result: result)
        case "unblockApps":         handleUnblockApps(call: call, result: result)
        case "unblockAll":          handleUnblockAll(result: result)
        case "getBlockedApps":      handleGetBlockedApps(result: result)
        case "getAppStatus":        handleGetAppStatus(call: call, result: result)
        case "setBlockScreenConfig":
            result(FlutterError(
                code: "PLATFORM_UNSUPPORTED",
                message: "Block screen configuration is not supported on iOS.",
                details: nil
            ))
        case "addSchedule":         handleAddSchedule(call: call, result: result)
        case "updateSchedule":      handleUpdateSchedule(call: call, result: result)
        case "removeSchedule":      handleRemoveSchedule(call: call, result: result)
        case "getSchedules":        handleGetSchedules(result: result)
        case "enableSchedule":      handleEnableSchedule(call: call, result: result)
        case "disableSchedule":     handleDisableSchedule(call: call, result: result)
        case "createProfile":       handleCreateProfile(call: call, result: result)
        case "updateProfile":       handleUpdateProfile(call: call, result: result)
        case "deleteProfile":       handleDeleteProfile(call: call, result: result)
        case "getProfiles":         handleGetProfiles(result: result)
        case "activateProfile":     handleActivateProfile(call: call, result: result)
        case "deactivateProfile":   handleDeactivateProfile(call: call, result: result)
        case "getActiveProfile":    handleGetActiveProfile(result: result)
        default:                    result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - Capabilities

    private func handleGetCapabilities(result: @escaping FlutterResult) {
        result([
            "canBlockApps": true,
            "canCustomizeBlockScreen": false,
            "canUseSystemShield": true,
            "canSchedule": false,
            "canGetInstalledApps": false,
            "canShowActivityPicker": true,
        ] as [String: Any])
    }

    // MARK: - Permissions

    private func handleCheckPermission(result: @escaping FlutterResult) {
        guard let manager = permissionManager else {
            return result(unavailableError("Permission manager"))
        }
        result(manager.checkPermission())
    }

    private func handleRequestPermission(result: @escaping FlutterResult) {
        guard let manager = permissionManager else {
            return result(unavailableError("Permission manager"))
        }
        manager.requestPermission(result: result)
    }

    // MARK: - App Discovery

    private func handleGetApps(result: @escaping FlutterResult) {
        guard let coordinator = activityPickerCoordinator else {
            return result(unavailableError("Activity picker coordinator"))
        }
        guard let rootVC = Self.findRootViewController() else {
            return result(unavailableError("Root view controller"))
        }
        coordinator.showPicker(from: rootVC, result: result)
    }

    // MARK: - Blocking

    private func handleBlockApps(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let identifiers = args["identifiers"] as? [String] else {
            return result(invalidConfigError("Missing 'identifiers' argument."))
        }
        shield.blockApps(identifiers: identifiers)
        for id in identifiers {
            eventStreamHandler?.sendEvent(type: "blocked", packageName: id, scheduleId: nil)
        }
        result(nil)
    }

    private func handleBlockAll(result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        shield.blockAll()
        eventStreamHandler?.sendEvent(type: "blocked", packageName: nil, scheduleId: nil)
        result(nil)
    }

    private func handleUnblockApps(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let identifiers = args["identifiers"] as? [String] else {
            return result(invalidConfigError("Missing 'identifiers' argument."))
        }
        shield.unblockApps(identifiers: identifiers)
        for id in identifiers {
            eventStreamHandler?.sendEvent(type: "unblocked", packageName: id, scheduleId: nil)
        }
        result(nil)
    }

    private func handleUnblockAll(result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        if let manager = profileManager,
           let activeProfile = manager.getActiveProfile(),
           let profileId = activeProfile["id"] as? String {
            manager.deactivateProfile(id: profileId)
            emitProfileEvents(profileId: profileId, appIdentifiers: activeProfile["appIdentifiers"] as? [String] ?? [], activated: false)
        }
        shield.unblockAll()
        eventStreamHandler?.sendEvent(type: "unblocked", packageName: nil, scheduleId: nil)
        result(nil)
    }

    private func emitProfileEvents(profileId: String, appIdentifiers: [String], activated: Bool) {
        for identifier in appIdentifiers {
            eventStreamHandler?.sendEvent(type: activated ? "blocked" : "unblocked", packageName: identifier, scheduleId: nil, profileId: profileId)
        }
        eventStreamHandler?.sendEvent(type: activated ? "profileActivated" : "profileDeactivated", packageName: nil, scheduleId: nil, profileId: profileId)
    }

    private func handleGetBlockedApps(result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        result(shield.getBlockedApps())
    }

    private func handleGetAppStatus(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let shield = shieldManager else {
            return result(unavailableError("Shield manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let identifier = args["identifier"] as? String else {
            return result(invalidConfigError("Missing 'identifier' argument."))
        }
        let blocked = shield.getBlockedApps()
        if blocked.contains(identifier) {
            result("blocked")
        } else if let schedMgr = scheduleManager {
            let isScheduled = schedMgr.getSchedules().contains { schedule in
                (schedule["enabled"] as? Bool == true) &&
                (schedule["appIdentifiers"] as? [String] ?? []).contains(identifier)
            }
            result(isScheduled ? "scheduled" : "unblocked")
        } else {
            result("unblocked")
        }
    }

    // MARK: - Scheduling (unsupported on iOS)
    // Schedule enforcement requires time-based background wakeups that are not
    // available without the DeviceActivity framework. All schedule methods return
    // PLATFORM_UNSUPPORTED. Check canSchedule via getCapabilities() before use.

    private func schedulingUnsupportedError() -> FlutterError {
        FlutterError(
            code: "PLATFORM_UNSUPPORTED",
            message: "Schedule-based blocking is not supported on iOS.",
            details: nil
        )
    }

    private func handleAddSchedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    private func handleUpdateSchedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    private func handleRemoveSchedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    private func handleGetSchedules(result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    private func handleEnableSchedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    private func handleDisableSchedule(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(schedulingUnsupportedError())
    }

    // MARK: - Profiles

    private func handleCreateProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        guard let data = call.arguments as? [String: Any] else {
            return result(invalidConfigError("Invalid profile data."))
        }
        manager.createProfile(data: data)
        result(nil)
    }

    private func handleUpdateProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        guard let data = call.arguments as? [String: Any] else {
            return result(invalidConfigError("Invalid profile data."))
        }
        manager.updateProfile(data: data)
        result(nil)
    }

    private func handleDeleteProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let id = args["id"] as? String else {
            return result(invalidConfigError("Missing 'id' argument."))
        }
        manager.deleteProfile(id: id)
        result(nil)
    }

    private func handleGetProfiles(result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        result(manager.getProfiles())
    }

    private func handleActivateProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let id = args["id"] as? String else {
            return result(invalidConfigError("Missing 'id' argument."))
        }
        let appIdentifiers = (manager.getProfiles()
            .first { ($0["id"] as? String) == id }?["appIdentifiers"] as? [String]) ?? []
        if manager.activateProfile(id: id) {
            emitProfileEvents(profileId: id, appIdentifiers: appIdentifiers, activated: true)
            result(nil)
        } else {
            result(FlutterError(
                code: "PROFILE_NOT_FOUND",
                message: "Profile '\(id)' not found.",
                details: nil
            ))
        }
    }

    private func handleDeactivateProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        guard let args = call.arguments as? [String: Any],
              let id = args["id"] as? String else {
            return result(invalidConfigError("Missing 'id' argument."))
        }
        let appIdentifiers = (manager.getProfiles()
            .first { ($0["id"] as? String) == id }?["appIdentifiers"] as? [String]) ?? []
        manager.deactivateProfile(id: id)
        emitProfileEvents(profileId: id, appIdentifiers: appIdentifiers, activated: false)
        result(nil)
    }

    private func handleGetActiveProfile(result: @escaping FlutterResult) {
        guard let manager = profileManager else {
            return result(unavailableError("Profile manager"))
        }
        result(manager.getActiveProfile())
    }

    // MARK: - Error helpers

    private func unavailableError(_ component: String) -> FlutterError {
        FlutterError(
            code: "SERVICE_UNAVAILABLE",
            message: "\(component) is not available.",
            details: nil
        )
    }

    private func invalidConfigError(_ message: String) -> FlutterError {
        FlutterError(code: "INVALID_CONFIG", message: message, details: nil)
    }

    // MARK: - Utilities

    private static func findRootViewController() -> UIViewController? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
