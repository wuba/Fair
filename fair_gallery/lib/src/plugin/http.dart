import 'dart:async';
import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:http_client_helper/http_client_helper.dart';

mixin HttpPlugin implements FairCommonPluginMixin {
  Future<dynamic> http(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final method = requestMap['method'];
          final url = requestMap['url'];
          final headers = requestMap['headers'];
          final body = requestMap['body'];
          switch (method) {
            case 'GET':
              final Response result =
                  await HttpClientHelper.get(Uri.parse(url)) as Response;
              return {
                'json': jsonDecode(result.body),
                // 'bodyBytes': result.bodyBytes,
                'statusCode': result.statusCode,
              };
            case 'POST':
              final Response result = await HttpClientHelper.post(
                Uri.parse(url),
                headers: headers,
                body: body,
              ) as Response;
              return {
                'json': jsonDecode(result.body),
                // 'bodyBytes': result.bodyBytes,
                'statusCode': result.statusCode,
              };
            default:
          }

          return null;
        },
      );
}
