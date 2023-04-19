import 'package:flutter_test/flutter_test.dart';
import 'package:fair_extension/fair_extension.dart';
import 'package:fair_extension/fair_extension_platform_interface.dart';
import 'package:fair_extension/fair_extension_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFairExtensionPlatform
    with MockPlatformInterfaceMixin
    implements FairExtensionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FairExtensionPlatform initialPlatform = FairExtensionPlatform.instance;

  test('$MethodChannelFairExtension is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFairExtension>());
  });
}
