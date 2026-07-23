import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/stub.dart' // Default fallback
    if (dart.library.io) 'package:is_tv_ffi/src/platforms/platforms.dart';

/// Initializes the correct instance for the platform
IsTv get platformInstance => getIsTvInstance();
