import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:url_launcher/url_launcher.dart';

class FairUrlLauncher extends IFairPlugin {
  static final FairUrlLauncher _fairUrlLauncher = FairUrlLauncher._internal();

  FairUrlLauncher._internal();

  factory FairUrlLauncher() {
    return _fairUrlLauncher;
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    var launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendSMS({
    required String phoneNumber,
    String? message,
  }) async {
    var launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent(message ?? ''),
      },
    );
    await launchUrl(launchUri);
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> sendMail({
    required String email,
    String? message,
  }) async {
    var launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': message ?? '',
      }),
    );
    await launchUrl(launchUri);
  }

  static Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchInWebViewOrVC(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'header_key': 'header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchInWebViewWithoutJavaScript(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchInWebViewWithoutDomStorage(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchUniversalLinkIos(String url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  static Future<void> _makePhoneCall(dynamic map) async {
    return makePhoneCall(_getArgs(map));
  }

  static Future<void> _sendSMS(dynamic map) async {
    var args = _getArgs(map);
    var phoneNumber = args['phoneNumber'];
    var message = args['message'];
    return sendSMS(phoneNumber: phoneNumber, message: message);
  }

  static Future<void> _sendMail(dynamic map) async {
    var args = _getArgs(map);
    var email = args['email'];
    var message = args['message'];
    return sendMail(email: email, message: message);
  }

  static Future<void> _launchInBrowser(dynamic map) async {
    return launchInBrowser(_getArgs(map));
  }

  static Future<void> _launchInWebViewOrVC(dynamic map) async {
    return launchInWebViewOrVC(_getArgs(map));
  }

  static Future<void> _launchInWebViewWithoutJavaScript(dynamic map) async {
    return launchInWebViewWithoutJavaScript(_getArgs(map));
  }

  static Future<void> _launchInWebViewWithoutDomStorage(dynamic map) async {
    return launchInWebViewWithoutDomStorage(_getArgs(map));
  }

  static Future<void> _launchUniversalLinkIos(dynamic map) async {
    return launchUniversalLinkIos(_getArgs(map));
  }

  static dynamic _getArgs(dynamic map) {
    if (map == null) {
      return '';
    }
    var req;
    if (map is Map) {
      req = map;
    } else {
      req = jsonDecode(map);
    }
    var args = req['args'];
    return args;
  }

  @override
  Map<String, Function> getRegisterMethods() {
    var functions = <String, Function>{};
    functions.putIfAbsent('makePhoneCall', () => _makePhoneCall);
    functions.putIfAbsent('sendSMS', () => _sendSMS);
    functions.putIfAbsent('sendMail', () => _sendMail);
    functions.putIfAbsent('launchInBrowser', () => _launchInBrowser);
    functions.putIfAbsent('launchInWebViewOrVC', () => _launchInWebViewOrVC);
    functions.putIfAbsent('launchInWebViewWithoutJavaScript',
        () => _launchInWebViewWithoutJavaScript);
    functions.putIfAbsent('launchInWebViewWithoutDomStorage',
        () => _launchInWebViewWithoutDomStorage);
    functions.putIfAbsent(
        'launchUniversalLinkIos', () => _launchUniversalLinkIos);
    return functions;
  }
}
