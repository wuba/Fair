library shelf_cors;

import 'dart:async';
import 'package:shelf/shelf.dart';

/// Middleware which adds [CORS headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
/// to shelf responses. Also handles preflight (OPTIONS) requests.
///
/// By default, allows access from everywhere.
Middleware createCorsHeadersMiddleware(
    {Map<String, String> corsHeaders = const {
      'Access-Control-Allow-Origin': '*'
    }}) {
  // Handle preflight (OPTIONS) requests by just adding headers and an empty
  // response.
  FutureOr<Response?> handleOptionsRequest(Request request) {
    if (request.method == 'OPTIONS') {
      return Response.ok(null, headers: corsHeaders);
    } else {
      return null;
    }
  }

  FutureOr<Response> addCorsHeaders(Response response) =>
      response.change(headers: corsHeaders);

  return createMiddleware(
      requestHandler: handleOptionsRequest, responseHandler: addCorsHeaders);
}
