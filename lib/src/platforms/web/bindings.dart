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

  /// Patterns that indicate a TV platform.
  ///
  /// These are anchored on purpose: matched as bare substrings they produce
  /// false positives on ordinary user agents.
  static final List<RegExp> _tvPatterns = [
    // The standalone word "tv", as in "Apple TV" or "SHIELD Android TV".
    RegExp(r'\btv\b'),
    // Amazon Fire TV device models: AFTB, AFTS, AFTMM and friends. A bare
    // "aft" would also match words such as "raft" or "craft".
    RegExp(r'\baft[a-z]{1,3}\b'),
  ];

  /// Lowercase keywords that indicate a TV platform.
  static const List<String> _tvKeywords = [
    'webos', // LG webOS TVs
    'tizen', // Samsung Tizen TVs
    'googletv', // Google TV
    'android tv', // Android TV devices
    'smart-tv', // Generic smart TV token
    'appletv', // Apple TV
    'crkey', // Google Chromecast
    'viera', // Panasonic Viera Cast
    'netcast', // LG NetCast TVs
    'dtv', // Digital TV
    'shield android tv', // NVIDIA Shield TV; the Shield Tablet is not a TV
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
  /// Checks for smart-TV platform globals on `window` first, then falls back to
  /// inspecting the browser's user agent.
  bool isTv() =>
      _hasTvPlatformGlobal() || matchesTvUserAgent(window.navigator.userAgent);

  /// Whether [userAgent] looks like it belongs to a TV.
  ///
  /// Exposed separately so the matching rules can be exercised without a
  /// browser; callers should use [isTv], which also checks for platform
  /// globals. [userAgent] is matched case-insensitively.
  @visibleForTesting
  static bool matchesTvUserAgent(String userAgent) {
    final normalized = userAgent.toLowerCase();

    return _tvPatterns.any((pattern) => pattern.hasMatch(normalized)) ||
        _tvKeywords.any(normalized.contains);
  }

  /// Whether any known smart-TV platform global is present on `window`.
  static bool _hasTvPlatformGlobal() =>
      _tvGlobals.any((name) => globalContext.has(name));
}
