## 0.7.0

### Fixes

- **Android: fixed `isTv` throwing `UseAfterReleaseError` on every read after the first.** The application `Context` was cached and then released by `use`, so the second and later reads operated on a deleted JNI reference. Each read now acquires and releases its own reference
- iOS/macOS: a missing or stripped `is_tv` symbol is now reported when the library is resolved instead of surfacing as a bare `ArgumentError` on the first call, and the original stack trace is preserved
- Web: `shield` and `aft` are no longer matched as bare substrings. A Shield **Tablet** is no longer reported as a TV, and user agents that merely contain "aft" (for example "Craft") no longer match. Fire TV model codes are matched as whole words instead
- Linux/Windows: `FLUTTER_IS_TV` is now matched case-insensitively and also accepts `yes` and `on`, so `FLUTTER_IS_TV=TRUE` works as documented
- iOS/macOS: the `PrivacyInfo.xcprivacy` manifests are now actually bundled — `resource_bundles` had been left commented out, so they shipped with neither platform

### Changes

- Upgraded dependencies: `jni` to ^1.0.0, `mocktail` to ^1.0.5, `flutter_lints` to ^6.0.0, `jnigen` to ^0.16.0, and `ffigen` to ^20.1.1
- Added `jni_flutter` ^1.0.1 dependency; the Android application-context API moved there in `jni` 1.0.0
- Moved `mocktail` to `dev_dependencies` (it was incorrectly declared as a runtime dependency)
- Windows: removed the unreliable `USERNAME == "SYSTEM"` heuristic; TV detection on Windows now relies solely on the `FLUTTER_IS_TV` environment variable
- Web: detect Samsung/LG smart-TV platform globals (`tizen`, `webOS`, `webOSSystem`) in addition to the user agent, and broadened the TV user-agent keyword list (HbbTV, Bravia, VIDAA, Roku, Net TV, CE-HTML, Opera TV)
- Android: `UiModeManager` is now resolved with a safe cast, and detection falls back to the `FEATURE_LEANBACK` system feature for TV boxes that report a non-television UI mode
- Linux: Steam Big Picture detection now also recognises SteamOS sessions, gamescope sessions and the `SteamDeck` variable
- `IsTvFfi` now has a `const` constructor
- Raised the plugin's Android build toolchain to Gradle 8.14, Android Gradle Plugin 8.11.1, and Kotlin 2.2.20; building for Android now requires Gradle 8.13 or newer
- Raised `compileSdk` to 36, moved the `dependencies` block out of `android { }`, replaced the deprecated `kotlinOptions` with `kotlin { compilerOptions }`, and dropped the deprecated `package` attribute from the library manifest
- Raised the podspec deployment targets to iOS 13.0 and macOS 10.15, and replaced the placeholder podspec metadata (`A new Flutter plugin project.`, `http://example.com`, `Your Company`) with real values
- **Breaking:** Raised minimum Flutter to >=3.35.6 (required by `jni` 1.0.0)

### Internal

- Collapsed the four identical iOS/macOS/Linux/Windows FFI wrappers and their generated bindings into a single `IsTvNative` implementation and one `ffigen.yaml`; the platform lookup is now a `switch` instead of a mutable global factory map
- Web: replaced the test-only `userAgent` parameter on `isTv()` — which changed production behaviour and silently required a pre-lowercased string — with a pure `matchesTvUserAgent` matcher
- Platform implementations now resolve their native dependencies lazily, so constructing one never touches JNI or FFI
- CI now also runs the Kotlin unit tests, the Linux and Windows gtest suites, the example widget tests, a formatting check, an analyzer pass over the example, and a publish dry-run
- Added a `.pubignore` so generator configs and the Gradle wrapper are not published
- Rewrote the example app: it no longer wraps a synchronous getter in an `async` method with an unreachable `PlatformException` handler

## 0.6.0

### Changes

- Added Windows support

## 0.5.0

### Changes

- Added Linux support

## 0.4.0

### Changes

- Added Web support

## 0.3.0

### Changes

- Added MacOS support

## 0.2.0

### Changes

- Added IOS support

## 0.1.1

### Changes

- Removed unnecessary platform declarations in pubspec.yaml

## 0.1.0

### Features

- Added Android support for TV detection
