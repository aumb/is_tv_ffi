@TestOn('browser')
library;

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

  group('IsTvFfiWebPlugin.matchesTvUserAgent', () {
    const tvUserAgents = <String, String>{
      'webOS': 'Mozilla/5.0 (WebOS; Linux/SmartTV) AppleWebKit/537.36',
      'Tizen': 'Mozilla/5.0 (SMART-TV; LINUX; Tizen 2.4.0)',
      'Google TV':
          'Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like '
          'Gecko) Chrome/53.0.2785.143 Safari/537.36 CrKey/1.54.248666 '
          'GoogleTV',
      'Chromecast':
          'Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like '
          'Gecko) Chrome/53.0.2785.143 Safari/537.36 CrKey/1.54.248666',
      'Sony Bravia':
          'Mozilla/5.0 (Linux; SmartTV; BRAVIA 4K GB) AppleWebKit/537.36',
      'HbbTV':
          'Mozilla/5.0 (Web0S; Linux/SmartTV) AppleWebKit/537.36 HbbTV/1.4.1',
      'Fire TV':
          'Mozilla/5.0 (Linux; Android 9; AFTMM Build/PS7233) AppleWebKit/'
          '537.36 (KHTML, like Gecko) Silk/87.3.9 Safari/537.36',
      'NVIDIA Shield TV':
          'Mozilla/5.0 (Linux; Android 11; SHIELD Android TV Build/RQ1A) '
          'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0 Safari/537.36',
      'the standalone word "tv"': 'some kind of android tv device',
    };

    tvUserAgents.forEach((device, userAgent) {
      test('returns true for a $device user agent', () {
        expect(IsTvFfiWebPlugin.matchesTvUserAgent(userAgent), isTrue);
      });
    });

    const nonTvUserAgents = <String, String>{
      'desktop Chrome':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      'mobile Safari':
          'Mozilla/5.0 (iPhone; CPU iPhone OS 16_1_1 like Mac OS X) '
          'AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/20B101',
      // The Shield Tablet is a tablet, not a TV.
      'NVIDIA Shield Tablet':
          'Mozilla/5.0 (Linux; Android 7.0; SHIELD Tablet K1 Build/NRD90M) '
          'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0 Safari/537.36',
      // "aft" must not match as a bare substring.
      'an app with "craft" in its user agent':
          'Mozilla/5.0 (Linux; Android 13) CraftBrowser/2.1 Safari/537.36',
    };

    nonTvUserAgents.forEach((device, userAgent) {
      test('returns false for a $device user agent', () {
        expect(IsTvFfiWebPlugin.matchesTvUserAgent(userAgent), isFalse);
      });
    });

    test('matches case-insensitively', () {
      const userAgent = 'Mozilla/5.0 (SMART-TV; LINUX; TIZEN 2.4.0)';

      expect(IsTvFfiWebPlugin.matchesTvUserAgent(userAgent), isTrue);
      expect(
        IsTvFfiWebPlugin.matchesTvUserAgent(userAgent.toLowerCase()),
        isTrue,
      );
      expect(
        IsTvFfiWebPlugin.matchesTvUserAgent(userAgent.toUpperCase()),
        isTrue,
      );
    });
  });

  group('IsTvFfiWebPlugin.isTv', () {
    test('returns false in the browser running these tests', () {
      // Neither a TV platform global nor a TV user agent is present here, so
      // this exercises the real `window.navigator` path end to end.
      expect(const IsTvFfiWebPlugin().isTv(), isFalse);
    });
  });
}
