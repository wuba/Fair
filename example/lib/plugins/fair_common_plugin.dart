import 'package:example/plugins/http.dart';
import 'package:fair/fair.dart';

class FairCommonPlugin extends IFairPlugin with HttpPlugin {
  factory FairCommonPlugin() => _fairCommonPlugin;
  FairCommonPlugin._();
  static final FairCommonPlugin _fairCommonPlugin = FairCommonPlugin._();
  @override
  Map<String, Function> getRegisterMethods() {
    return <String, Function>{
      'http': http,
    };
  }
}
