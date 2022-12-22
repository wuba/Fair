import 'dart:io';

import 'package:fair_online_service/src/sdk.dart';

// This tool is used to manually update the `flutter-sdk/` Flutter SDK to match
// the current configuration information in the `flutter-sdk-version.yaml` file.

void main(List<String> args) async {
  if (args.length != 1) {
    print('Usage: update_sdk.dart [CHANNEL]');
    exitCode = 1;
    return;
  }

  final channel = args.single;
  final sdkManager = DownloadingSdkManager(channel);
  print('Flutter version: ${sdkManager.flutterVersion}');
  final flutterSdkPath = await sdkManager.createFromConfigFile();

  print('\nSDK setup complete ($flutterSdkPath).');
}
