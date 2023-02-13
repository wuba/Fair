import 'dart:typed_data';

import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/utils/device_utils.dart';
import 'package:fair_online/utils/project_utils.dart';

const TYPE_COMPONENT = "component";
const TYPE_ACTION = "action";
enum CustomCodeEditType { create, modify }


class CustomCodeModel extends AbsModel {

  bool isLoading = true;
  GetCustomComponentsResponse componentsResponse = GetCustomComponentsResponse();
  GetCustomActionsResponse actionsResponse = GetCustomActionsResponse();
  CreateCustomComponentResponse createComponentResponse = CreateCustomComponentResponse();
  CreateCustomActionResponse createCustomActionResponse = CreateCustomActionResponse();
  DeleteCustomCodeItemResponse deleteResponse = DeleteCustomCodeItemResponse();

  Future<void> initialized() async {
    getComponents();
    getActions();
  }

  void startGetItems(String type) {
    switch (type) {
      case TYPE_COMPONENT:
        getComponents();
        break;
      case TYPE_ACTION:
        getActions();
        break;
    }
  }

  //获取组件列表
  Future<void> getComponents() async {
    final request = GetCustomComponentsRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response = await dartServices
          .getCustomComponents(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      componentsResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //获取action列表
  Future<void> getActions() async {
    final request = GetCustomActionsRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response = await dartServices
          .getCustomActions(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      actionsResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //创建新的组件
  Future<CreateCustomComponentResponse> createCustomComponent(CustomCodeEditType editType, String name, String desc, String content,
      Uint8List? previewScreenshot) async {
    final request = CreateCustomComponentRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    request.name = name;
    request.desc = desc;
    request.content = content;
    request.editType = editType.name;
    if (previewScreenshot != null) {
      request.screenshots.addAll(previewScreenshot.toList(growable: false));
    }
    try {
      final response = await dartServices
          .createCustomComponent(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      createComponentResponse = response;
      if (createComponentResponse.status == 0) {
        getComponents();
      }
      return response;
    } catch (e) {
      print(e);
      final message = e is ApiRequestError ? e.message : '$e';
      return CreateCustomComponentResponse(
          status: -1, error: ErrorMessage(message: message));
    }
  }

  //创建新的Action
  Future<CreateCustomActionResponse> createCustomAction(CustomCodeEditType editType,String name, String desc, String content) async {
    final request = CreateCustomActionRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    request.name = name;
    request.desc = desc;
    request.content = content;
    request.editType = editType.name;
    try {
      final response = await dartServices
          .createCustomAction(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      createCustomActionResponse = response;
      if (createCustomActionResponse.status == 0) {
        getActions();
      }
      return response;
    } catch (e) {
      print(e);
      final message = e is ApiRequestError ? e.message : '$e';
      return CreateCustomActionResponse(
          status: -1, error: ErrorMessage(message: message));
    }
  }

  //删除
  Future<void> deleteCodeFile(String path, String type) async {
    final request = DeleteCustomCodeItemRequest();
    request.path = path;
    request.type = type;
    try {
      final response = await dartServices
          .deleteCustomCodeItem(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      deleteResponse = response;
      getComponents();
      getActions();
    } catch (e) {
      print(e);
    }
  }
}
