#ifndef FLUTTER_PLUGIN_IS_TV_FFI_PLUGIN_H_
#define FLUTTER_PLUGIN_IS_TV_FFI_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace is_tv_ffi {

class IsTvFfiPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  IsTvFfiPlugin();

  virtual ~IsTvFfiPlugin();

  // Disallow copy and assign.
  IsTvFfiPlugin(const IsTvFfiPlugin&) = delete;
  IsTvFfiPlugin& operator=(const IsTvFfiPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace is_tv_ffi

#endif  // FLUTTER_PLUGIN_IS_TV_FFI_PLUGIN_H_
