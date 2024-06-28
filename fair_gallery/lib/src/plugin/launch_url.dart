// ignore_for_file: depend_on_referenced_packages

import 'package:fair/fair.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

mixin LaunchUrlPlugin implements FairCommonPluginMixin {
  Future<dynamic> launchUrl(dynamic map) => request(
        map,
        (dynamic requestMap) async {
          final url = requestMap['url'];
          url_launcher.launchUrl(Uri.parse(url));
          return null;
        },
      );
}
