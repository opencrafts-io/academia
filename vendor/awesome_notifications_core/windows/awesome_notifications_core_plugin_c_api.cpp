#include "include/awesome_notifications_core/awesome_notifications_core_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "awesome_notifications_core_plugin.h"

void AwesomeNotificationsCorePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  awesome_notifications_core::AwesomeNotificationsCorePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
