import 'dart:convert';

/// Here is a demo for FairCommonPlugin.
///
///
/// The plugin name must be 'FairCommonPlugin'
///
/// class FairCommonPlugin extends IFairPlugin
///     with FairHttpPlugin, FairPermissionPlugin {
///   factory FairCommonPlugin() => _fairCommonPlugin;
///   FairCommonPlugin._();
///   static final FairCommonPlugin _fairCommonPlugin = FairCommonPlugin._();
///   @override
///   Map<String, Function> getRegisterMethods() {
///     return <String, Function>{
///       'http': http,
///       'requestPermission': requestPermission,
///     };
///   }
/// }
///
/// You only need to focus on the implementation of the specific business logic.
/// you can define method in FairCommonPlugin directly or define mixins to implements it.
/// mixins will make business logic more clearly.
///
/// mixin FairHttpPlugin implements FairCommonPluginMixin {
///   Future<dynamic> http(dynamic map) => request(map, _run);
///   Future<Map?> _run(Map requestMap) async {
///     // implements http here.
///   }
/// }
///
///
/// mixin FairPermissionPlugin implements FairCommonPluginMixin {
///   Future<dynamic> requestPermission(dynamic map) => request(map, _run);
///   Future<Map?> _run(Map requestMap) async {
///     // implements Permission here.
///   }
/// }
///
/// then add following into your plugin js
///
/// // The plugin name must be 'FairCommonPlugin'
///
/// let FairCommonPlugin = function () {
///     return {
///         // The same method name in FairCommonPlugin
///         http: function (resp) {
///             // The same method name in FairCommonPlugin
///             fairCommonPluginRequest(resp, 'http');
///         },
///         requestPermission: function (resp) {
///             fairCommonPluginRequest(resp, 'requestPermission');
///         },
///     }
/// }
///
///
/// Define it at runApplication
///
/// FairApp.runApplication(
///   FairApp(child: MaterialApp()),
///   plugins: <String, IFairPlugin>{
///     'FairCommonPlugin': FairCommonPlugin(),
///   },
/// );
///
///
///
/// Finally, use it like this:
///
/// FairCommonPlugin().http({
///   // if need, add a callback
///   'callback': (dynamic result) {
///     // result is map or null
///   },
///   // other parameters base on your case
///   'method': 'GET',
/// });
///
///
/// When you want to add a new business logic, you only need to add a new method in your plugin js and
/// add new method for FairCommonPlugin.
///
mixin FairCommonPluginMixin {
  /// common request method
  Future<dynamic> request(
    dynamic map,
    // do your business logic in this call back
    Future<Map?> Function(Map reqData) run,
  ) async {
    if (map == null) {
      return;
    }
    var req;
    bool isDart;
    if (map is Map) {
      isDart = true;
      req = map;
    } else {
      isDart = false;
      req = jsonDecode(map);
    }
    final pageName = req['pageName'] ?? '#FairKey#';
    var request = req['request'];
    if (isDart) {
      request = req;
    }

    final callId = request['callId'];

    final completeCallback = request['callback'];

    final response = await run(request);

    // 需要判断发起方的请求是dart端还是js端
    if (isDart) {
      completeCallback?.call(response);
      return Future.value();
    } else {
      final resp = {
        'callId': callId,
        'pageName': pageName,
        'response': response,
      };
      return Future.value(jsonEncode(resp));
    }
  }
}
