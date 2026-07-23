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
    'webos', // LG WebOS TVs
    'tizen', // Samsung Tizen TVs
    'googletv', // Google TV
    'android tv', // Android TV devices
    'smart-tv', // Generic term
    'appletv', // Apple TV
    'crkey', // Google Chromecast
    'aft', // Amazon Fire TV (e.g., 'aftb', 'aftt')
    'viera', // Panasonic Viera Cast
    'netcast', // LG NetCast TVs
    'dtv', // Digital TV
    'shield', // NVIDIA Shield
  ];

  /// Checks on the current user agent and returns true or false based on the contents of
  /// the list.
  bool isTv({@visibleForTesting String? userAgent}) {
    final finalUserAgent =
        userAgent ?? window.navigator.userAgent.toLowerCase();

    if (_tvWordPattern.hasMatch(finalUserAgent)) {
      return true;
    }

    return _tvKeywords.any(finalUserAgent.contains);
  }
}
