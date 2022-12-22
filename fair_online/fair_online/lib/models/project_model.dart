import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/utils/device_utils.dart';
import 'package:fair_online/utils/log.dart';

class ProjectModel extends AbsModel {
  bool isLoading = true;
  GetProjectResponse projectResponse = GetProjectResponse();
  GetProjectResponse templateProjectResponse = GetProjectResponse();

  Future<void> initialized() async {
    getProjects();
  }

  Future<void> getProjects() async {
    var fingerId = DeviceUtils.getFingerId();
    Log.d('getProjects()::userId::$fingerId');
    final request = GetProjectRequest()..userId = fingerId;
    try {
      final response =
          await dartServices.getProjects(request).timeout(serviceCallTimeout);
      isLoading = false;
      projectResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getTemplateProjects() async {
    var fingerId = DeviceUtils.getFingerId();
    final request = GetProjectRequest()..userId = fingerId;
    try {
      final response = await dartServices
          .getTemplateProjects(request)
          .timeout(serviceCallTimeout);
      templateProjectResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<CreateProjectResponse?> createProject(
      String projectName, String? templateProject) async {
    var fingerId = DeviceUtils.getFingerId();
    var request = CreateProjectRequest()
      ..userId = fingerId
      ..projectName = projectName
      ..templateProject = templateProject ?? '';
    try {
      final response = await dartServices
          .createProject(request)
          .timeout(Duration(seconds: 3 * 60));
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CreateProjectResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<DeleteProjectResponse?> deleteProject(String projectName) async {
    var fingerId = DeviceUtils.getFingerId();
    var request = DeleteProjectRequest()
      ..userId = fingerId
      ..projectName = projectName;
    try {
      final response = await dartServices
          .deleteProject(request)
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return DeleteProjectResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<ExportProjectResponse?> exportProject() async {
    try {
      final response = await dartServices
          .exportProject(CommonRequest())
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return ExportProjectResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<UploadPluginResponse?> uploadPlugin(
      String appId, String bundleName, String patchUrl) async {
    try {
      var request = UploadPluginRequest()
        ..appId = appId
        ..bundleName = bundleName
        ..patchUrl = patchUrl;

      final response = await dartServices
          .uploadPlugin(request)
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return UploadPluginResponse()..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }
}
