/// A dev-time only server.
library services_dev;

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf;
import 'package:shelf_static/shelf_static.dart';

import 'src/common_server_api.dart';
import 'src/common_server_impl.dart';
import 'src/sdk.dart';
import 'src/server_cache.dart';
import 'src/shelf_cors.dart' as shelf_cors;

final Logger _logger = Logger('services');

const _hostname = '0.0.0.0';
const _defaultDoc = 'index.html';

Future<void> main(List<String> args) async {
  final parser = ArgParser();
  parser
    ..addOption('version', mandatory: true)
    ..addOption('port', abbr: 'p', defaultsTo: '8080')
    ..addOption('server-url', defaultsTo: 'http://localhost')
    ..addFlag('null-safety');

  final result = parser.parse(args);
  final port = int.tryParse(result['port'] as String);
  if (port == null) {
    stdout.writeln(
        'Could not parse port value "${result['port']}" into a number.');
    exit(1);
  }

  Logger.root.level = Level.FINER;
  Logger.root.onRecord.listen((LogRecord record) {
    print(record);
    if (record.stackTrace != null) print(record.stackTrace);
  });

  await EndpointsServer.serve(port, Sdk.create(result['version'] as String),
      result['null-safety'] as bool);
  _logger.info('Listening on port $port');

  String? defaultDoc = _defaultDoc;
  final webHandler = Pipeline()
      .addMiddleware(_createCustomCorsHeadersMiddleware())
      .addHandler(createStaticHandler('web',
          defaultDocument: defaultDoc, listDirectories: true));
  await shelf.serve(webHandler, _hostname, 8001).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });

  var pipeline = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_createCustomCorsHeadersMiddleware());
  final fairDirHandler = pipeline
      .addHandler(createStaticHandler('fairDir', listDirectories: true));
  await shelf.serve((request) {
    if (request.url.pathSegments.isNotEmpty &&
        request.url.pathSegments.first == 'resource') {
      request = request.change(path: 'resource');
    }
    return fairDirHandler.call(request);
  }, _hostname, 8002).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

Middleware _createCustomCorsHeadersMiddleware() {
  return shelf_cors.createCorsHeadersMiddleware(corsHeaders: <String, String>{
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Max-Age': '31536000', //解决跨域出现2次请求的问题，改为一百年校验一次
    'Access-Control-Allow-Headers':
        'Origin, X-Requested-With, Content-Type, Accept, x-goog-api-client, deviceId, projectName',
    'X-Frame-Options': '*' // 解决IFrame拒绝的问题
  });
}

class EndpointsServer {
  static Future<EndpointsServer> serve(
      int port, Sdk sdk, bool nullSafety) async {
    final endpointsServer = EndpointsServer._(sdk, nullSafety);
    await shelf.serve(endpointsServer.handler, InternetAddress.anyIPv4, port);
    return endpointsServer;
  }

  late final Pipeline pipeline;
  late final Handler handler;
  late final CommonServerApi commonServerApi;

  EndpointsServer._(Sdk sdk, bool nullSafety) {
    final commonServerImpl = CommonServerImpl(
      _ServerContainer(),
      _Cache(),
      sdk,
    );
    commonServerApi = CommonServerApi(commonServerImpl);
    commonServerImpl.init();

    pipeline = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_createCustomCorsHeadersMiddleware());

    handler = pipeline.addHandler(commonServerApi.router);
  }

  Middleware _createCustomCorsHeadersMiddleware() {
    return shelf_cors.createCorsHeadersMiddleware(corsHeaders: <String, String>{
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Max-Age': '31536000', //解决跨域出现2次请求的问题，改为一百年校验一次
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept, x-goog-api-client, deviceId, projectName'
    });
  }
}

class _ServerContainer implements ServerContainer {
  @override
  String get version => '1.0';
}

class _Cache implements ServerCache {
  @override
  Future<String?> get(String key) => Future<String?>.value(null);

  @override
  Future<void> set(String key, String value, {Duration? expiration}) =>
      Future<void>.value();

  @override
  Future<void> remove(String key) => Future<void>.value();

  @override
  Future<void> shutdown() => Future<void>.value();
}
