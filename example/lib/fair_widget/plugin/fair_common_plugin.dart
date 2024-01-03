import 'package:example/fair_widget/plugin/fair_http_plugin.dart';
import 'package:fair/fair.dart';

/// 跟 js 交互的方法类
class FairCommonPlugin extends IFairPlugin with FairHttpPlugin //Http请求plugin
{
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
