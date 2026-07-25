# is_tv_ffi

A Flutter plugin to detect if the current device is a TV.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✅    | ✅  |   ✅   | ✅  |  ✅   |   ✅    |

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    is_tv_ffi: ^0.7.0
```

## Usage

```dart
import 'package:is_tv_ffi/is_tv_ffi.dart';

// Check if the device is a TV
final isTv = const IsTvFfi().isTv;
if (isTv) {
  print('Running on a TV');
} else {
  print('Not running on a TV');
}
```

`isTv` is a synchronous native call, so there is nothing to await.

### iOS and macOS: Swift Package Manager only

The iOS and macOS implementations ship as Swift packages (`ios/is_tv_ffi/`, `macos/is_tv_ffi/`) with no podspec, so they require **Flutter 3.44 or newer**, where Swift Package Manager is enabled by default.

If Swift Package Manager is disabled, your build stops with:

```
The following plugin(s) are only compatible with Swift Package Manager:
  - is_tv_ffi
```

To fix it, re-enable Swift Package Manager:

```bash
flutter config --enable-swift-package-manager
```

Make sure it is not disabled per-project either — check for this in your app's `pubspec.yaml` and remove it if present:

```yaml
flutter:
  config:
    enable-swift-package-manager: false
```

## Desktop Usage

For Linux and Windows, the plugin determines if it's a TV environment by checking for specific environment variables. This allows you to force "TV Mode" for your application when running on a media center PC, or for testing.

### Forcing TV Mode

Before running your app, set the following environment variable:

- **Variable:** `FLUTTER_IS_TV`
- **Value:** `1`, `true`, `yes` or `on` (matched case-insensitively)

#### Linux / macOS Terminal

```bash
FLUTTER_IS_TV=1 flutter run
```

#### Windows PowerShell

```powershell
$env:FLUTTER_IS_TV="1"
flutter run -d windows
```

#### Windows Command Prompt

```cmd
set FLUTTER_IS_TV=1
flutter run -d windows
```

On Linux the plugin additionally recognises Steam Big Picture and SteamOS gaming sessions. Windows has no such heuristic: `FLUTTER_IS_TV` is the only signal it uses.

## Implementation Details

### Android

Uses `UiModeManager` to check if the current OS is Android TV, falling back to the leanback system feature for TV boxes that report a non-television UI mode.

```kotlin
fun isTv(context: Context): Boolean {
  val uiModeManager = context.getSystemService(Context.UI_MODE_SERVICE) as? UiModeManager
  if (uiModeManager?.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION) {
    return true
  }

  return context.packageManager?.hasSystemFeature(PackageManager.FEATURE_LEANBACK) == true
}
```

### iOS / tvOS

Uses `UIDevice` to check if the current device's user interface idiom is `.tv`.

```swift
public func isTV() -> Bool {
  return device.userInterfaceIdiom == .tv
}
```

### macOS

Always returns `false`. macOS never reports a TV user interface idiom; the native symbol exists so that the FFI surface stays uniform across Apple platforms.

```swift
public func isTV() -> Bool {
    return false
}
```

### Linux

Checks the `FLUTTER_IS_TV` environment variable, then the variables that indicate a Steam Big Picture or SteamOS gaming session. Which of those is set depends on the distribution and compositor, so several are checked.

```cpp
bool is_tv() {
  return IsTruthy(std::getenv("FLUTTER_IS_TV")) || IsSteamBigPictureSession();
}

bool IsSteamBigPictureSession() {
  const char* session_desktop = std::getenv("XDG_SESSION_DESKTOP");
  const char* current_desktop = std::getenv("XDG_CURRENT_DESKTOP");

  return EqualsIgnoreCase(session_desktop, "steam") ||
         EqualsIgnoreCase(session_desktop, "steamos") ||
         EqualsIgnoreCase(current_desktop, "gamescope") ||
         IsTruthy(std::getenv("SteamDeck"));
}
```

### Windows

Checks the `FLUTTER_IS_TV` environment variable.

```cpp
bool is_tv() {
  char* env_value = nullptr;
  size_t len = 0;

  if (_dupenv_s(&env_value, &len, "FLUTTER_IS_TV") != 0) {
    return false;
  }

  const bool result = IsTruthy(env_value);
  free(env_value);

  return result;
}
```

### Web

Checks for the JavaScript globals that smart-TV runtimes inject (`tizen`, `webOS`, `webOSSystem`) — these are harder to spoof than a user agent — then falls back to matching the user agent against a list of TV keywords and patterns.

```dart
bool isTv() =>
    _hasTvPlatformGlobal() || matchesTvUserAgent(window.navigator.userAgent);

static bool matchesTvUserAgent(String userAgent) {
  final normalized = userAgent.toLowerCase();

  return _tvPatterns.any((pattern) => pattern.hasMatch(normalized)) ||
      _tvKeywords.any(normalized.contains);
}
```

The keyword list covers webOS, Tizen, Google TV, Chromecast, Fire TV, Apple TV, Bravia, VIDAA, Roku, HbbTV, NetCast, Net TV, CE-HTML and Opera TV. Patterns are used where a bare substring would misfire — Fire TV model codes (`AFTB`, `AFTMM`) are matched as whole words so that ordinary user agents containing "aft" are not treated as TVs.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
