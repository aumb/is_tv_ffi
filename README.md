# is_tv_ffi

A Flutter plugin to detect if the current device is a TV.

## Platform Support

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   ✅    | 🚧  |  🚧   | 🚧  |  🚧   |   🚧    |

> Note: Support for other platforms is planned for future releases.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
    is_tv_ffi: ^0.1.0
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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the
