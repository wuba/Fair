import 'package:fair/fair.dart';
import 'package:fair_example/src/page/plugins/http.dart';
import 'package:fair_example/src/page/plugins/permission.dart';
import 'package:fair_example/src/page/plugins/photo.dart';

class FairCommonPlugin extends IFairPlugin
    with HttpPlugin, PermissionPlugin, PhotoPlugin {
  factory FairCommonPlugin() => _fairCommonPlugin;
  FairCommonPlugin._();
  static final FairCommonPlugin _fairCommonPlugin = FairCommonPlugin._();
  @override
  Map<String, Function> getRegisterMethods() {
    return <String, Function>{
      'http': http,
      'requestPermission': requestPermission,
      'selectPhoto': selectPhoto,
    };
  }
}
