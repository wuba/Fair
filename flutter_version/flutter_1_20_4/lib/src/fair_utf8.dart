import 'dart:ffi';
import 'package:ffi/ffi.dart';

class FairUtf8 {

  static String fromUtf8(Pointer<Utf8> data) {
    return Utf8.fromUtf8(data);
  }

  static dynamic toUtf8(String data) {
    return Utf8.toUtf8(data);
  }

}