import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fair_extension_method_channel.dart';

abstract class FairExtensionPlatform extends PlatformInterface {
  /// Constructs a FairExtensionPlatform.
  FairExtensionPlatform() : super(token: _token);

  static final Object _token = Object();

  static FairExtensionPlatform _instance = MethodChannelFairExtension();

  /// The default instance of [FairExtensionPlatform] to use.
  ///
  /// Defaults to [MethodChannelFairExtension].
  static FairExtensionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FairExtensionPlatform] when
  /// they register themselves.
  static set instance(FairExtensionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
