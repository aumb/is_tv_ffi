import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/native/bindings.dart';

/// Resolves the [DynamicLibrary] that exports the native `is_tv` symbol.
typedef LibraryResolver = DynamicLibrary Function();

/// FFI-backed implementation of [IsTv] for iOS, macOS, Linux and Windows.
///
/// All four platforms export the same `bool is_tv()` C symbol, so they differ
/// only in how the library is resolved: Apple platforms link the plugin into
/// the application binary and look the symbol up in the running process, while
/// Linux and Windows load a shared library by name.
///
/// The library is resolved lazily on the first [isTv] read, so constructing an
/// instance never touches the native world.
class IsTvNative extends IsTv {
  /// Creates an instance that resolves its library with [resolveLibrary].
  IsTvNative({
    required LibraryResolver resolveLibrary,
    @visibleForTesting IsTvFfiNativePlugin? plugin,
  }) : _resolveLibrary = resolveLibrary,
       _plugin = plugin;

  /// Looks `is_tv` up in the running process.
  ///
  /// Used on iOS and macOS, where the plugin is statically linked into the
  /// application binary.
  IsTvNative.process() : this(resolveLibrary: DynamicLibrary.process);

  /// Loads the shared library named [libraryName] and looks `is_tv` up there.
  ///
  /// Used on Linux and Windows, where the plugin ships as its own library.
  IsTvNative.open(String libraryName)
    : this(resolveLibrary: () => DynamicLibrary.open(libraryName));

  final LibraryResolver _resolveLibrary;
  final IsTvFfiNativePlugin? _plugin;

  late final IsTvFfiNativePlugin _bindings = _plugin ?? _load();

  IsTvFfiNativePlugin _load() {
    try {
      final library = _resolveLibrary();
      // Resolve the symbol eagerly. The generated bindings look it up lazily,
      // so without this a missing or stripped `is_tv` would surface as a bare
      // ArgumentError on the first call rather than as a diagnosable failure
      // here.
      library.lookup<NativeFunction<Bool Function()>>('is_tv');
      return IsTvFfiNativePlugin(library);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        StateError('Unable to resolve the native is_tv symbol: $error'),
        stackTrace,
      );
    }
  }

  @override
  bool get isTv => _bindings.is_tv();
}
