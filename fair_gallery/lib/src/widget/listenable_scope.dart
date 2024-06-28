// ignore_for_file: prefer_function_declarations_over_variables

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class ListenableScopeConfig {
  ListenableScopeConfig({
    required this.type,
    this.addListener = false,
    this.tag = '',
  });
  final String type;
  final bool addListener;

  /// 区分多个相同类型
  final String tag;
}

class ListenableScope extends StatefulWidget {
  const ListenableScope({
    super.key,
    required this.configs,
    required this.onCreate,
    this.addListener,
    required this.uniqueKey,
    required this.onCreateKey,
    required this.builder,
  });
  //  ScrollController, AnimationController, TabController, ValueNotifier
  final List<ListenableScopeConfig> configs;
  final Listenable? Function(String key, TickerProvider vsync) onCreate;
  // List
  // 2个值，一个是 对应的 key ，一个是对应的 值，放在一个map里面
  // [key,map]
  final void Function(dynamic)? addListener;

  //  标识唯一
  final String uniqueKey;

  // 生成带后缀的唯一标识，防止重复
  // 给 js 中使用的，通过 这个 key 获取到 _ListenableScopeState
  // 再 通过 _ListenableScopeState 获取到想要的 type
  final void Function(String key) onCreateKey;

  final WidgetBuilder builder;

  @override
  State<ListenableScope> createState() => _ListenableScopeState();

  static final Map<String, _ListenableScopeState> _scopes =
      <String, _ListenableScopeState>{};

  /// type 带后缀的
  /// 比如 [configs] = ['ScrollController','AnimationController']
  /// 这里的 type 就为 'ScrollController0', 'AnimationController1'
  /// 给 build 方法体里面使用的
  static T of<T extends Listenable>(BuildContext context, String type) {
    return context
        .findAncestorStateOfType<_ListenableScopeState>()
        ?._listenables[type] as T;
  }

  /// 方便 ListenableScopePlugin 获取 Listenable
  static Listenable? get(String uniqueKey, String type) {
    var scope = _scopes[uniqueKey];
    return scope?._listenables[type];
  }
}

class _ListenableScopeState extends State<ListenableScope>
    with TickerProviderStateMixin {
  final Map<String, Listenable> _listenables = <String, Listenable>{};
  final Map<String, void Function()> _listeners = <String, void Function()>{};

  late String _uniqueKey;
  // Function listener
  @override
  void initState() {
    super.initState();
    _uniqueKey = widget.uniqueKey + '${DateTime.now().microsecondsSinceEpoch}';
    widget.onCreateKey(_uniqueKey);
    ListenableScope._scopes[_uniqueKey] = this;
    _create();
  }

  void _create() {
    for (var config in widget.configs) {
      var type = config.type;
      var key = type + config.tag;
      assert(!_listenables.containsKey(key), '有重复的类型$type,请用 tag 区分');

      var addListener = widget.addListener;
      switch (type) {
        case 'ScrollController':
        case 'SyncScrollController':
        case 'LinkScrollController':
        case 'AnimationController':
        case 'ValueNotifier':
        case 'TabController':
        case 'PageController':
        case 'LinkPageController':
          var listenable = widget.onCreate(key, this);
          if (listenable == null) {
            continue;
          }
          _listenables[key] = listenable;
          if (addListener != null && config.addListener) {
            void Function() listener = () {
              addListener.call([
                key,
                Sugar.dartObjectToMap(listenable),
              ]);
            };
            listenable.addListener(listener);
            _listeners[key] = listener;
          }
          break;
        default:
          assert(false, '不支持的类型$type');
      }
    }
  }

  @override
  void didUpdateWidget(covariant ListenableScope oldWidget) {
    _dispose();
    _create();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _dispose();
    ListenableScope._scopes.remove(_uniqueKey);
    super.dispose();
  }

  void _dispose() {
    for (var key in _listenables.keys) {
      var listenable = _listenables[key];
      var listener = _listeners[key];
      if (listener != null) {
        listenable?.removeListener(listener);
      }

      if (listenable is ChangeNotifier) {
        listenable.dispose();
      }
    }
    _listenables.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return widget.builder(context);
    });
  }
}
