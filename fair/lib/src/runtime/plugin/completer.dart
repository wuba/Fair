import 'dart:async';

import 'package:fair/fair.dart';

 
mixin CompleterPlugin implements FairCommonPluginMixin {
  Future<dynamic> futureComplete(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final id = requestMap['futureId'];
          final value = requestMap['futureValue'];
          _completers.remove(id)?.complete(value);
          return null;
        },
      );

  static final Map<String, Completer> _completers = <String, Completer>{};

  static Completer<T> createCompleter<T>(String futureId) =>
      _completers.putIfAbsent(
        futureId,
        () => Completer<T>(),
      ) as Completer<T>;

  static Future<T> createFuture<T>({
    String? futureId,
    Function? function,
    dynamic argument,
    Function? callback, 
  }) {
    futureId ??= DateTime.now().millisecondsSinceEpoch.toString();
    if (function != null) {
      function.call({
        'futureId': futureId,
        if(argument!=null)
        'argument': argument,
      });
    }
    return createCompleter<T>(futureId).future..then((value) {
      callback?.call(value);
    });
  }
}
