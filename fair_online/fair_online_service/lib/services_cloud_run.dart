/// A server for Cloud Run.
library services_cloud_run;

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf;

import 'src/common_server_api.dart';
import 'src/common_server_impl.dart';
import 'src/sdk.dart';
import 'src/server_cache.dart';
import 'src/shelf_cors.dart' as shelf_cors;

final Logger _logger = Logger('services');

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('channel', mandatory: true)
    ..addOption('port', abbr: 'p')
    ..addOption('redis-url');
  final results = parser.parse(args);

  final channel = results['channel'] as String;
  final sdk = Sdk.create(channel);

  // Cloud Run supplies the port to bind to in the environment.
  // Allow command line arg to override environment.
  final port = int.tryParse(results['port'] as String? ?? '') ??
      int.tryParse(Platform.environment['PORT'] ?? '');
  if (port == null) {
    stdout.writeln('Could not parse port value from either environment '
        '"PORT" or from command line argument "--port".');
    exit(1);
  }

  final redisServerUri = results['redis-url'] as String;

  Logger.root.level = Level.FINER;
  Logger.root.onRecord.listen((LogRecord record) {
    print(record);
    if (record.stackTrace != null) print(record.stackTrace);
  });

  final cloudRunEnvVars = Platform.environment.entries
      .where((entry) => entry.key.startsWith('K_'))
      .map((entry) => '${entry.key}: ${entry.value}')
      .join('\n');

  _logger.info('''Initializing dart-services:
    port: $port
    sdkPath: ${sdk.dartSdkPath}
    redisServerUri: $redisServerUri
    Cloud Run Environment variables:
    $cloudRunEnvVars''');

  await EndpointsServer.serve(port, redisServerUri, sdk);
  _logger.info('Listening on port $port');
}

class EndpointsServer {
  static Future<EndpointsServer> serve(
      int port, String redisServerUri, Sdk sdk) async {
    final endpointsServer = EndpointsServer._(redisServerUri, sdk);

    await endpointsServer.init();
    endpointsServer.server = await shelf.serve(
      endpointsServer.handler,
      InternetAddress.anyIPv4,
      port,
    );
    return endpointsServer;
  }

  late final HttpServer server;

  late final Pipeline pipeline;
  late final Handler handler;

  late final CommonServerApi commonServerApi;
  late final CommonServerImpl _commonServerImpl;

  EndpointsServer._(String? redisServerUri, Sdk sdk) {
    _commonServerImpl = CommonServerImpl(
      _ServerContainer(),
      redisServerUri == null
          ? InMemoryCache()
          : RedisCache(
              redisServerUri,
              sdk,
              // The name of the Cloud Run revision being run, for more detail please see:
              // https://cloud.google.com/run/docs/reference/container-contract#env-vars
              Platform.environment['K_REVISION'],
            ),
      sdk,
    );
    commonServerApi = CommonServerApi(_commonServerImpl);

    pipeline = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_createCustomCorsHeadersMiddleware());

    handler = pipeline.addHandler(commonServerApi.router);
  }

  Future<void> init() => _commonServerImpl.init();

  Middleware _createCustomCorsHeadersMiddleware() {
    return shelf_cors.createCorsHeadersMiddleware(corsHeaders: <String, String>{
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept, x-goog-api-client'
    });
  }
}

class _ServerContainer implements ServerContainer {
  @override
  String get version => '1.0';
}
