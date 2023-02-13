import 'dart:convert';

import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:file_selector/file_selector.dart';
import 'package:tuple/tuple.dart';

class ApiCallModel extends AbsModel {
  //切换展示的视图
  bool showAddView = false;

  //表示是否列表页item编辑
  bool isEdit = false;

  //被编辑的api
  ApiCallInfo? beEditApi;

  //添加api call的model
  ApiCallAddModel apiCallAddModel = ApiCallAddModel(params: []);

  //获取api call结果
  GetApiCallResponse apiCalls = GetApiCallResponse();

  void changeAddView(bool value,
      {bool isEdit = false, ApiCallInfo? editApiCallInfo}) {
    //false表示从添加api页面切到api call列表页
    if (!value) {
      _reset();
    }
    if (showAddView != value) {
      showAddView = value;
      this.isEdit = isEdit;
      this.beEditApi = editApiCallInfo;
      //如果是编辑行为
      if (isEdit && editApiCallInfo != null) {
        updateApiContent(
            name: editApiCallInfo.name,
            method: editApiCallInfo.method,
            url: editApiCallInfo.url);
        if (editApiCallInfo.params.isNotEmpty) {
          apiCallAddModel.params = editApiCallInfo.params
              .map((param) => Tuple3<String, String, String>(
                  param.key, param.type, param.value))
              .toList();
        }
      }
      notifyListeners();
    }
  }

  //更新api内容
  void updateApiContent({String? name, String? method, String? url}) {
    if (name != null) {
      apiCallAddModel.name = name;
    }

    if (method != null) {
      apiCallAddModel.method = method;
    }

    if (url != null) {
      apiCallAddModel.url = url;
    }
    notifyListeners();
  }

  //重置添加api页面的参数
  void _reset() {
    apiCallAddModel = ApiCallAddModel(params: []);
  }

  void importJson({Function? onError}) async {
    final typeGroup = XTypeGroup(label: 'json', extensions: ['json']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) {
      return;
    }

    try {
      final jsonStr = await file.readAsString();
      print('Blues ===> read json:$jsonStr');
      final importedModel = ApiCallAddModel().fromJson(jsonStr);

      //校验是否有效的json
      if (importedModel.isInvalidate()) {
        onError?.call();
        return;
      }

      updateApiContent(
          name: importedModel.name,
          method: importedModel.method,
          url: importedModel.url);

      if (importedModel.params.isNotEmpty) {
        apiCallAddModel.params = importedModel.params;
      }
    } catch (e) {
      print('importJson error:$e');
      onError?.call();
    }
  }

  void updateParamsValue(int index, Tuple3<String, String, String> newTuple) {
    print('Blues ===>更新params index:$index newValue:$newTuple');
    if (index != -1) {
      apiCallAddModel.params[index] = newTuple;
    } else {
      apiCallAddModel.params.add(newTuple);
    }

    print('Blues ===>更新后的params${apiCallAddModel.params}');
    notifyListeners();
  }

  //api call页面添加空的param项
  void addEmptyParamsItem() {
    apiCallAddModel.params.add(Tuple3('', 'String', ''));
    print('Blues ===>添加一个空的params:${apiCallAddModel.params}');
    notifyListeners();
  }

  //删除api call页面所有的param项
  void deleteAllParamsItem() {
    print('Blues ===>删除所有的params');
    //清除全部param item时也需要清除容器
    apiCallAddModel.params.clear();
    notifyListeners();
  }

  //删除添加api call页面的param项
  void deleteParamsItem(int index) {
    //清除对应param item时也需要清除对应index
    apiCallAddModel.params.removeAt(index);
    notifyListeners();
  }

  ///获取所有api call
  Future<void> getAllApiCall() async {
    try {
      final request = CommonApiCallRequest();
      final response = await dartServices
          .getApiCall(request)
          .timeout(longServiceCallTimeout);

      apiCalls = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  ///添加一个api call
  Future<CommonApiCallResponse?> addApiCall(String name, String method,
      String url, Iterable<ApiCallParamsInfo> params) async {
    try {
      final request = CommonApiCallRequest(
        api: ApiCallInfo(name: name, method: method, url: url, params: params),
      );
      final response = await dartServices
          .addApiCall(request)
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CommonApiCallResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print('addApiCall ==>$e');
      return null;
    }
  }

  ///删除一个api call
  Future<CommonApiCallResponse?> deleteApiCall(String name) async {
    try {
      final request = CommonApiCallRequest(api: ApiCallInfo(name: name));
      final response = await dartServices
          .deleteApiCall(request)
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CommonApiCallResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }
}

//添加api call 数据模型
class ApiCallAddModel {
  //api name
  String name;

  //api method => Get/Post
  String method;

  //api url
  String url;

  //api return type
  String returnType;

  //用于记录params
  List<Tuple3<String, String, String>> params;

  ApiCallAddModel({
    this.name = '',
    this.method = 'GET',
    this.url = '',
    this.returnType = 'JSON',
    this.params = const [],
  });

  ApiCallAddModel fromJson(dynamic rawJson) {
    final js = json.decode(rawJson);
    var tempName = '';
    var tempMethod = '';
    var tempUrl = '';
    var tempParams = <Tuple3<String, String, String>>[];
    if (js is Map) {
      if (js.containsKey('name')) {
        tempName = js['name'] ?? '';
      }

      if (js.containsKey('method')) {
        tempMethod = js['method'] ?? '';
      }

      if (js.containsKey('url')) {
        tempUrl = js['url'] ?? '';
      }

      if (js.containsKey('params')) {
        final tempList = js['params'] ?? [];
        print('Blues ===> parse params:$tempList');
        if (tempList is List) {
          tempParams = tempList
              .map((param) => Tuple3<String, String, String>(
                    param['key'],
                    param['type'],
                    param['value'],
                  ))
              .toList();
        }
      }
    }
    return ApiCallAddModel()
      ..name = tempName
      ..method = tempMethod
      ..url = tempUrl
      ..params = tempParams;
  }

  //校验json是否无效效
  bool isInvalidate() => name.isEmpty && method.isEmpty && url.isEmpty;
}
