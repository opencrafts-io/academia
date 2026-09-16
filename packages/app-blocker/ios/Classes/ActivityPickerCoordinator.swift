import Foundation
import UIKit
import SwiftUI
import FamilyControls
import Flutter

class ActivityPickerCoordinator: NSObject {
    private var pendingResult: FlutterResult?
    private var hostingController: UIHostingController<ActivityPickerView>?

    func showPicker(from viewController: UIViewController, result: @escaping FlutterResult) {
        // Prevent multiple concurrent pickers
        if pendingResult != nil {
            result(FlutterError(
                code: "SERVICE_UNAVAILABLE",
                message: "Activity picker is already being shown.",
                details: nil
            ))
            return
        }

        pendingResult = result

        let pickerView = ActivityPickerView(
            onDone: { [weak self] selection in
                self?.onPickerDone(selection: selection, presenter: viewController)
            },
            onCancel: { [weak self] in
                self?.onPickerCancelled(presenter: viewController)
            }
        )

        let hosting = UIHostingController(rootView: pickerView)
        hosting.modalPresentationStyle = .fullScreen
        hostingController = hosting

        viewController.present(hosting, animated: true, completion: nil)
    }

    private func onPickerDone(selection: FamilyActivitySelection, presenter: UIViewController) {
        // Store tokens and get back their stable keys.
        // Do NOT apply the shield here — the caller decides whether to block or unblock.
        var apps: [[String: Any]] = []
        if let shieldManager = AppBlockerPlugin.shared?.shieldManager as? ShieldManager {
            let stored = shieldManager.storeTokensFromSelection(selection: selection)
            for (key, isApp) in stored {
                apps.append([
                    "packageName": key,
                    "appName": isApp ? "Selected App" : "Selected Category",
                    "isSystemApp": false,
                ])
            }
        }

        presenter.dismiss(animated: true) { [weak self] in
            self?.pendingResult?(apps)
            self?.pendingResult = nil
            self?.hostingController = nil
        }
    }

    private func onPickerCancelled(presenter: UIViewController) {
        presenter.dismiss(animated: true) { [weak self] in
            self?.pendingResult?([] as [Any])
            self?.pendingResult = nil
            self?.hostingController = nil
        }
    }
}
