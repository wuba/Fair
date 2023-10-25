import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:collection/collection.dart';

import 'utils/time_record.dart';

final Map<String, FairChangeNotifier> _fairModelPool = {};

class FairProviderPlugin {
  static T find<T>(String className) {
    return _fairModelPool[className] as T;
  }

  static printObject(dynamic obj) {}
}

class FairChangeNotifier extends ChangeNotifier {
  FairChangeNotifier();

  String? fairRuntimeTypeKey;
  final Runtime _runtime = Runtime();

  dynamic operator [](String key) {
    final record = TimeRecord("FairChangeNotifier取值")..start();
    final jsResult = _runtime
        .invokeMethodSync("FairProviderPlugin", "find", [fairRuntimeTypeKey]);
    record.done();
    final jsResultObj = jsonDecode(jsResult);
    final jsModel = jsResultObj["result"]["result"];
    return jsModel[key];
  }

  dynamic evaluation(String expression) {
    final record = TimeRecord("FairChangeNotifier执行表达式")..start();
    final jsResult = _runtime.invokeMethodSync(
        "FairProviderPlugin", "evaluation", [fairRuntimeTypeKey, expression]);
    record.done();
    final jsResultObj = jsonDecode(jsResult);
    final jsModel = jsResultObj["result"]["result"];
    return jsModel;
  }

  void notify() {
    notifyListeners();
  }

  void print() {
    //impl in js plugin
  }
}

class FairContext {
  String id = "FairContext";
  List<String> treeModelKeyRecords = [];

  FairContext(this.treeModelKeyRecords);

  Map toJson() {
    Map map = {};
    map["id"] = id;
    map["treeModelKeyRecords"] = treeModelKeyRecords;
    return map;
  }

  T read<T>(String className) {
    return _fairModelPool[className] as T;
  }
}

typedef FairContextWidgetBuilder = Widget Function(FairContext context);
typedef FairContextWidgetBuilder2 = Widget Function(String context);

class FairContextBuilder extends StatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const FairContextBuilder({
    super.key,
    required this.builder,
  }) : assert(builder != null);

  /// Called to obtain the child widget.
  ///
  /// This function is called whenever this widget is included in its parent's
  /// build and the old widget (if any) that it synchronizes with has a distinct
  /// object identity. Typically the parent's build method will construct
  /// a new tree of widgets and so a new Builder child will not be [identical]
  /// to the corresponding old one.
  final FairContextWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    //构建FairContext将整颗树的信息录入
    final fairContext = FairContext(
        (context as FairContextBuilderElement).getTreeModelKeyRecords());
    return builder(fairContext);
  }

  @override
  StatelessElement createElement() {
    return FairContextBuilderElement(this);
  }
}

class FairContextBuilderElement extends StatelessElement {
  FairContextBuilderElement(FairContextBuilder widget) : super(widget);

  FairContextBuilder get widget => super.widget as FairContextBuilder;

  List<String> getTreeModelKeyRecords() {
    List<String> treeModelKeyRecords = [];
    visitAncestorElements((parent) {
      if (parent.runtimeType.toString() ==
          '_InheritedProviderScopeElement<FairChangeNotifier?>') {
        final grandParent = _findGrandParent(parent);
        if (grandParent != null &&
            grandParent is FairChangeNotifierProviderElement) {
          treeModelKeyRecords.add(grandParent.widget.modelKey);
        }
      }
      return true;
    });
    return treeModelKeyRecords;
  }

  Element? _findGrandParent(Element child) {
    int count = 0;
    Element? grandParent;
    child.visitAncestorElements((parent) {
      if (++count == 2) {
        grandParent = parent;
        return false;
      }
      return true;
    });
    return grandParent;
  }
}

typedef FairConsumerBuilder = Widget Function(
    BuildContext context,
    dynamic value,
    Widget? child,
    );

typedef FairSelectorSelector = dynamic Function(
    BuildContext context,
    dynamic value,
    );

class FairSugarProvider {
  FairSugarProvider._();

  /// Provider消费者Builder，用于Consumer
  static FairConsumerBuilder consumerBuilder(FairConsumerBuilder builder) =>
      builder;

  /// Provider消费者Builder，用于Selector
  static FairConsumerBuilder selectorBuilder(FairConsumerBuilder builder) =>
      builder;

  /// 用于Selector中指定监听字段的selector
  static FairSelectorSelector selector(FairSelectorSelector selector) =>
      selector;

  ///用于从
  static dynamic valueReader(
    FairChangeNotifier model,
    String key,
  ) =>
      model[key] ?? 'null';

  static String stringValueReader(
    FairChangeNotifier model,
    String key,
  ) =>
      (model[key] ?? 'null').toString();

  static dynamic anyToString(dynamic value) {
    return value.toString();
  }

  static String evaluationToString(
    FairChangeNotifier model,
    String expression,
  ) =>
      (model.evaluation(expression) ?? 'null').toString();

  static FairContextWidgetBuilder widgetBuilder(
          FairContextWidgetBuilder builder) =>
      builder;

  static FairContextWidgetBuilder2 widgetBuilder2(
          FairContextWidgetBuilder2 builder) =>
      builder;
}

class FairChangeNotifierProvider<T extends FairChangeNotifier>
    extends StatefulWidget
{
  FairChangeNotifierProvider({Key? key, required this.child, this.initialJson})
      : super(key: key);

  Widget child;

  String? initialJson;

  late String modelKey;

  final Runtime _runtime = Runtime();

  String? fairRuntimeTypeKey;

  List<dynamic>? typeArgumentList;

  void setTypeArgumentList(List<dynamic> typeArgumentList) {
    this.typeArgumentList = typeArgumentList;
    fairRuntimeTypeKey = typeArgumentList[0];
  }

  @override
  State<FairChangeNotifierProvider> createState() =>
      FairChangeNotifierProviderState();

  @override
  StatefulElement createElement() {
    return FairChangeNotifierProviderElement(this);
  }
}

class FairChangeNotifierProviderElement extends StatefulElement {
  FairChangeNotifierProviderElement(this.widget) : super(widget);
  FairChangeNotifierProvider widget;
}

class FairChangeNotifierProviderState
    extends State<FairChangeNotifierProvider> {
  static int _counter = 0;

  late FairChangeNotifier fairModel;

  @override
  void initState() {
    super.initState();
    _createModelInJs();
  }

  /// 通知js侧创建model，然后counter++
  void _createModelInJs() {
    final record = TimeRecord("FairChangeNotifierProvider创建jsModel")..start();
    widget.modelKey = "${widget.fairRuntimeTypeKey}_${_counter++}";
    final jsResult = widget._runtime.invokeMethodSync(
        "FairProviderPlugin", "create", [widget.modelKey, widget.initialJson]);
    record.done();
    final jsResultObj = jsonDecode(jsResult);
    final jsModel = jsResultObj["result"]["result"];
    fairModel = _fairModelPool[widget.modelKey] = FairChangeNotifier()
      ..fairRuntimeTypeKey = widget.modelKey;
  }

  @override
  void dispose() {
    super.dispose();
    _fairModelPool.remove(widget.modelKey);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => fairModel,
      lazy: false,
      child: widget.child,
    );
  }
}

class FairConsumer<T extends FairChangeNotifier>
    extends SingleChildStatelessWidget // with GenericsReceiver
{
  FairConsumer({Key? key, required this.builder, Widget? child})
      : super(key: key, child: child);

  String? fairRuntimeTypeKey;

  late String modelKey;

  FairChangeNotifier get fairModel {
    return _fairModelPool[modelKey] as FairChangeNotifier;
  }

  List<dynamic>? typeArgumentList;

  void setTypeArgumentList(List<dynamic> typeArgumentList) {
    this.typeArgumentList = typeArgumentList;
    fairRuntimeTypeKey = typeArgumentList[0];
  }

  final Widget Function(
    BuildContext context,
    FairChangeNotifier value,
    Widget? child,
  ) builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    //绑定观察者 updateDependents
    (context as FairConsumerElement).bindDependents();
    return builder(
      context,
      fairModel,
      child,
    );
  }

  @override
  SingleChildStatelessElement createElement() {
    return FairConsumerElement(this);
  }
}

class FairConsumerElement extends SingleChildStatelessElement {
  FairConsumerElement(FairConsumer widget) : super(widget);

  FairConsumer get widget => super.widget as FairConsumer;

  void bindDependents() {
    visitAncestorElements((parent) {
      if (parent.runtimeType.toString() ==
          '_InheritedProviderScopeElement<FairChangeNotifier?>') {
        final grandParent = _findGrandParent(parent);
        if (grandParent != null &&
            grandParent is FairChangeNotifierProviderElement &&
            grandParent.widget.fairRuntimeTypeKey ==
                widget.fairRuntimeTypeKey) {
          widget.modelKey = grandParent.widget.modelKey;
          dependOnInheritedElement(parent as InheritedElement);
          return false;
        }
      }
      return true;
    });
  }

  Element? _findGrandParent(Element child) {
    int count = 0;
    Element? grandParent;
    child.visitAncestorElements((parent) {
      if (++count == 2) {
        grandParent = parent;
        return false;
      }
      return true;
    });
    return grandParent;
  }
}

class FairSelector<A extends FairChangeNotifier, T>
    extends SingleChildStatefulWidget {
  FairSelector({
    Key? key,
    required this.builder,
    required this.selector,
    ShouldRebuild<T>? shouldRebuild,
    Widget? child,
  })  : _shouldRebuild = shouldRebuild,
        super(key: key, child: child);

  String? fairRuntimeTypeKey;

  late String modelKey;

  FairChangeNotifier get fairModel {
    return _fairModelPool[modelKey] as FairChangeNotifier;
  }

  List<dynamic>? typeArgumentList;

  void setTypeArgumentList(List<dynamic> typeArgumentList) {
    this.typeArgumentList = typeArgumentList;
    fairRuntimeTypeKey = typeArgumentList[0];
  }

  final ValueWidgetBuilder<T> builder;

  final FairSelectorSelector selector;

  final ShouldRebuild<T>? _shouldRebuild;

  @override
  _FairSelectorState<A, T> createState() => _FairSelectorState<A, T>();

  @override
  SingleChildStatefulElement createElement() {
    return FairSelectorElement(this);
  }
}

class _FairSelectorState<A extends FairChangeNotifier, T>
    extends SingleChildState<FairSelector<A, T>> {
  T? value;
  Widget? cache;
  Widget? oldWidget;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    (context as FairSelectorElement).bindDependents();
    final selected = widget.selector(context, widget.fairModel);

    final shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null &&
            widget._shouldRebuild!(value as T, selected)) ||
        (widget._shouldRebuild == null &&
            !const DeepCollectionEquality().equals(value, selected));
    if (shouldInvalidateCache) {
      value = selected;
      oldWidget = widget;
      cache = widget.builder(
        context,
        selected,
        child,
      );
    }
    return cache!;
  }
}

class FairSelectorElement extends SingleChildStatefulElement {
  FairSelectorElement(FairSelector widget) : super(widget);

  FairSelector get widget => super.widget as FairSelector;

  void bindDependents() {
    visitAncestorElements((parent) {
      if (parent.runtimeType.toString() ==
          '_InheritedProviderScopeElement<FairChangeNotifier?>') {
        final grandParent = _findGrandParent(parent);
        //如果grandParent是FairChangeNotifierProviderElement
        if (grandParent != null &&
            grandParent is FairChangeNotifierProviderElement &&
            grandParent.widget.fairRuntimeTypeKey ==
                widget.fairRuntimeTypeKey) {
          widget.modelKey = grandParent.widget.modelKey;
          dependOnInheritedElement(parent as InheritedElement);
          return false;
        }
      }
      return true;
    });
  }

  Element? _findGrandParent(Element child) {
    int count = 0;
    Element? grandParent;
    child.visitAncestorElements((parent) {
      if (++count == 2) {
        grandParent = parent;
        return false;
      }
      return true;
    });
    return grandParent;
  }
}
