## 0.7.0

### Changes

- Upgraded dependencies: `jni` to ^1.0.0, `mocktail` to ^1.0.5, `flutter_lints` to ^6.0.0, `jnigen` to ^0.16.0, and `ffigen` to ^20.1.1
- Added `jni_flutter` ^1.0.1 dependency; the Android application-context API moved there in `jni` 1.0.0
- Moved `mocktail` to `dev_dependencies` (it was incorrectly declared as a runtime dependency)
- Windows: removed the unreliable `USERNAME == "SYSTEM"` heuristic; TV detection on Windows now relies solely on the `FLUTTER_IS_TV` environment variable
- Raised the plugin's Android build toolchain to Gradle 8.14, Android Gradle Plugin 8.11.1, and Kotlin 2.2.20; building for Android now requires Gradle 8.13 or newer
- **Breaking:** Raised minimum Flutter to >=3.35.6 (required by `jni` 1.0.0)

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
