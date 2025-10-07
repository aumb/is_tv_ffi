#include "include/is_tv_ffi/is_tv_ffi_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "is_tv_ffi_plugin.h"

void IsTvFfiPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  is_tv_ffi::IsTvFfiPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
