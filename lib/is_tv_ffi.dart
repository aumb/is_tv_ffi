import 'package:is_tv_ffi/src/is_tv.dart';

class IsTvFfi {
  IsTv get _platform => IsTv.instance;

  bool get isTv => _platform.isTv;
}
