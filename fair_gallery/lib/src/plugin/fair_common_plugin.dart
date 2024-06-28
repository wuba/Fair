// 由 bin/fair_common_plugin.dart 生成
import 'package:fair/fair.dart';
import 'launch_url.dart';
import 'photo.dart';
import 'future.dart';
import 'navigator.dart';
import 'listenable_scope.dart';
import 'totast.dart';
import 'debug.dart';
import 'http.dart';

/// 跟 js 交互的方法类
class FairCommonPlugin extends IFairPlugin
    with
        CompleterPlugin,
        LaunchUrlPlugin,
        PhotoPlugin,
        FuturePlugin,
        NavigatorPlugin,
        ListenableScopePlugin,
        ToastPlugin,
        DebugPlugin,
        HttpPlugin {
  factory FairCommonPlugin() => _fairCommonPlugin;
  FairCommonPlugin._();
  static final FairCommonPlugin _fairCommonPlugin = FairCommonPlugin._();
  @override
  Map<String, Function> getRegisterMethods() {
    return <String, Function>{
      'futureComplete': futureComplete,
      'launchUrl': launchUrl,
      'savePhoto': savePhoto,
      'futureDelayed': futureDelayed,
      'navigate': navigate,
      'scrollController': scrollController,
      'animationController': animationController,
      'tabController': tabController,
      'valueNotifier': valueNotifier,
      'showToast': showToast,
      'jsPrint': jsPrint,
      'http': http,
    };
  }
}
