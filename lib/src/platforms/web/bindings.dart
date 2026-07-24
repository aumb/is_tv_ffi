import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/web/is_tv_web.dart';
import 'package:web/web.dart';

/// Bindings for Web isTv check.
class IsTvFfiWebPlugin {
  /// Bindings for Web isTv check.
  const IsTvFfiWebPlugin();

  /// Registers this implementation as the web-specific instance.
  static void registerWith(Registrar registrar) {
    IsTv.setInstance(IsTvWeb());
  }

  /// Matches the standalone word "tv" in a user agent string.
  static final RegExp _tvWordPattern = RegExp(r'\btv\b');

  /// Lowercase keywords that indicate a TV platform.
  static const List<String> _tvKeywords = [
    'webos', // LG webOS TVs
    'tizen', // Samsung Tizen TVs
    'googletv', // Google TV
    'android tv', // Android TV devices
    'smart-tv', // Generic smart TV token
    'appletv', // Apple TV
    'crkey', // Google Chromecast
    'aft', // Amazon Fire TV (e.g. 'aftb', 'aftt')
    'viera', // Panasonic Viera Cast
    'netcast', // LG NetCast TVs
    'dtv', // Digital TV
    'shield', // NVIDIA Shield
    'hbbtv', // HbbTV (hybrid broadcast broadband TV)
    'bravia', // Sony Bravia TVs
    'vidaa', // Hisense VIDAA OS
    'roku', // Roku streaming devices
    'nettv', // Philips Net TV
    'ce-html', // CE-HTML TV browsers
    'opera tv', // Opera TV Store
  ];

  /// Names of JavaScript globals injected by smart-TV web runtimes. Detecting
  /// these is more reliable than user-agent sniffing, since the UA string can
  /// be altered but the platform object cannot.
  static const List<String> _tvGlobals = [
    'tizen', // Samsung Tizen
    'webOS', // LG webOS
    'webOSSystem', // LG webOS (newer runtime)
  ];

  /// Returns true if the current device is a TV.
  ///
  /// At runtime this first checks for smart-TV platform globals on `window`,
  /// then falls back to inspecting the user agent. Pass [userAgent] to exercise
  /// the user-agent logic in isolation (the global check is skipped in that
  /// case so tests stay deterministic).
  bool isTv({@visibleForTesting String? userAgent}) {
    if (userAgent == null && _hasTvPlatformGlobal()) {
      return true;
    }

    final finalUserAgent =
        userAgent ?? window.navigator.userAgent.toLowerCase();

    if (_tvWordPattern.hasMatch(finalUserAgent)) {
      return true;
    }

    return _tvKeywords.any(finalUserAgent.contains);
  }

  /// Whether any known smart-TV platform global is present on `window`.
  static bool _hasTvPlatformGlobal() =>
      _tvGlobals.any((name) => globalContext.has(name));
}
