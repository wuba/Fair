import 'dart:ffi';
import 'package:ffi/ffi.dart';

class FairUtf8 {
  static String fromUtf8(Pointer<Utf8> data) {
    return data.toDartString();
  }

  static dynamic toUtf8(String data) {
    return data.toNativeUtf8();
  }
}
