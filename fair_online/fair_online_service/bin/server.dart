library services.bin;

import 'dart:async';

import 'package:fair_online_service/services_dev.dart' as services_dev;

Future<void> main(List<String> args) async {
  print('server main args::: ${args.join(' ')}');
  await services_dev.main(args);
}
