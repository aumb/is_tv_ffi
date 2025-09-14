import 'package:is_tv_ffi/src/is_tv.dart';
import 'package:is_tv_ffi/src/platforms/android/bindings.dart';
import 'package:jni/jni.dart';

class IsTvAndroid extends IsTv {
  IsTvAndroid();

  Context get _context =>
      Context.fromReference(Jni.getCachedApplicationContext());

  @override
  bool get isTv => _context.use((context) => IsTvFfiPlugin.isTv(context));
}
