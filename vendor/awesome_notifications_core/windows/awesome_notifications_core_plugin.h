#ifndef FLUTTER_PLUGIN_AWESOME_NOTIFICATIONS_CORE_PLUGIN_H_
#define FLUTTER_PLUGIN_AWESOME_NOTIFICATIONS_CORE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace awesome_notifications_core {

class AwesomeNotificationsCorePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AwesomeNotificationsCorePlugin();

  virtual ~AwesomeNotificationsCorePlugin();

  // Disallow copy and assign.
  AwesomeNotificationsCorePlugin(const AwesomeNotificationsCorePlugin&) = delete;
  AwesomeNotificationsCorePlugin& operator=(const AwesomeNotificationsCorePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace awesome_notifications_core

#endif  // FLUTTER_PLUGIN_AWESOME_NOTIFICATIONS_CORE_PLUGIN_H_
