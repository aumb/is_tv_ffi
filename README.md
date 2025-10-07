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
    is_tv_ffi: ^0.6.0
```

## Usage

```dart
import 'package:is_tv_ffi/is_tv_ffi.dart';

// Check if the device is a TV
final isTv = IsTvFfi().isTv;
if (isTv) {
  print('Running on a TV');
} else {
  print('Not running on a TV');
}
```

## Desktop Usage

For Linux and Windows, the plugin determines if it's a TV environment by checking for specific environment variables. This allows you to force "TV Mode" for your application when running on a media center PC, or for testing.

### Forcing TV Mode

Before running your app, set the following environment variable:

- **Variable:** `FLUTTER_IS_TV`
- **Value:** `1` or `true`

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

The plugin also automatically detects TV mode if it recognizes a Steam Big Picture session on Linux, or a potential Xbox environment on Windows.

## Implementation Details

### Android

Uses `UiModeManager` to check if the current OS is Android TV.

```kotlin
fun isTv(context: Context): Boolean {
  val uiModeManager =
    context.getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
  return uiModeManager.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION
}
```

### iOS / tvOS

Uses `UIDevice` to check if the current device's user interface idiom is `.tv`.

```swift
public func isTV() -> Bool {
  return UIDevice.current.userInterfaceIdiom == .tv
}
```

### macOS

Always returns `false`. This implementation checks the device's `userInterfaceIdiom`, which will not be `.tv` on a macOS device.

```swift
public func isTV() -> Bool {
    return false
}
```

### Linux

Checks for the `FLUTTER_IS_TV` environment variable, or for variables indicating a Steam Big Picture session.

```cpp
bool is_tv() {
    const char* env_is_tv = std::getenv("FLUTTER_IS_TV");
    if (env_is_tv != nullptr && (strcmp(env_is_tv, "1") == 0 || strcmp(env_is_tv, "true") == 0)) {
        return true;
    }

    const char* env_xdg_desktop = std::getenv("XDG_SESSION_DESKTOP");
    if (env_xdg_desktop != nullptr && strcmp(env_xdg_desktop, "steam") == 0) {
        return true;
    }

    return false;
}
```

### Windows

Checks for the `FLUTTER_IS_TV` environment variable, or if the `USERNAME` is `SYSTEM` (a heuristic for Xbox environments).

```cpp
bool is_tv() {
    char* env_value;
    size_t len;

    if (_dupenv_s(&env_value, &len, "FLUTTER_IS_TV") == 0 && env_value != nullptr) {
        bool is_tv_flag = (strcmp(env_value, "1") == 0 || strcmp(env_value, "true") == 0);
        free(env_value);
        if (is_tv_flag) {
            return true;
        }
    }

    if (_dupenv_s(&env_value, &len, "USERNAME") == 0 && env_value != nullptr) {
        bool is_system_user = (strcmp(env_value, "SYSTEM") == 0);
        free(env_value);
        if (is_system_user) {
            return true;
        }
    }

    return false;
}
```

### Web

Evaluates the browser's user agent string against a pre-defined list of keywords common to TV devices (e.g., WebOS, Tizen, Chromecast).

```dart
bool get isTv {
  final userAgent = window.navigator.userAgent.toLowerCase();

  const tvKeywords = [
    'webos',      // LG WebOS TVs
    'tizen',      // Samsung Tizen TVs
    'googletv',   // Google TV
    'android tv', // Android TV devices
    'smart-tv',   // Generic term
    'appletv',    // Apple TV
    'crkey',      // Google Chromecast
    'aft',        // Amazon Fire TV
    'viera',      // Panasonic Viera Cast
    'netcast',    // LG NetCast TVs
    'dtv',        // Digital TV
    'shield',     // NVIDIA Shield
  ];

  if (RegExp(r'\btv\b').hasMatch(userAgent)) {
    return true;
  }

  return tvKeywords.any((keyword) => userAgent.contains(keyword));
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.