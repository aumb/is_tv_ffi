import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/web/bindings.dart';
import 'package:is_tv_ffi/src/platforms/web/is_tv_web.dart';
import 'package:mocktail/mocktail.dart';

class _MockRegistrar extends Mock implements Registrar {}

void main() {
  tearDown(() {
    IsTv.setInstance(null);
  });

  group('IsTvFfiWebPlugin.registerWith', () {
    test('sets the instance to IsTvWeb', () {
      IsTvFfiWebPlugin.registerWith(_MockRegistrar());

      expect(IsTv.instance, isA<IsTvWeb>());
    });
  });

  group('IsTvFfiWebPlugin.isTv', () {
    const plugin = IsTvFfiWebPlugin();

    test('returns true for user agent containing "webos"', () {
      const userAgent = 'Mozilla/5.0 (WebOS; Linux/SmartTV) AppleWebKit/537.36';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isTrue);
    });

    test('returns true for user agent containing "tizen"', () {
      const userAgent = 'Mozilla/5.0 (SMART-TV; LINUX; Tizen 2.4.0)';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isTrue);
    });

    test('returns true for user agent containing "googletv"', () {
      const userAgent =
          'Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 CrKey/1.54.248666 GoogleTV';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isTrue);
    });

    test('returns true for user agent containing "crkey" (Chromecast)', () {
      const userAgent =
          'Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 CrKey/1.54.248666';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isTrue);
    });

    test('returns true for user agent containing the word "tv"', () {
      const userAgent = 'some kind of android tv device';
      expect(plugin.isTv(userAgent: userAgent), isTrue);
    });

    test('returns false for a standard Chrome desktop user agent', () {
      const userAgent =
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isFalse);
    });

    test('returns false for a standard mobile user agent', () {
      const userAgent =
          'Mozilla/5.0 (iPhone; CPU iPhone OS 16_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/20B101';
      expect(plugin.isTv(userAgent: userAgent.toLowerCase()), isFalse);
    });
  });
}
