import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/utils/device_utils.dart';
import 'package:fair_online/utils/project_utils.dart';

class DependencyFileModel extends AbsModel {
  static String TYPE_ADD = "1";
  static String TYPE_DELETE = "2";
  static String TYPE_EDIT = "3";

  bool isLoading = true;
  DependencyPathResponse componentsResponse = DependencyPathResponse();
  ChangeDependencyResponse changeDependencyResponse =
      ChangeDependencyResponse();

  Future<void> initialized() async {
    getDependencyFilePath();
  }

  void getDependencyFilePath() async {
    final request = DependencyPathRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response = await dartServices
          .getDependencyFilePath(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      componentsResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void changeDependency(String type, String name, String version) async {
    final request = ChangeDependencyRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    request.type = type;
    request.name = name;
    request.version = version;
    try {
      final response = await dartServices
          .changeDependency(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      changeDependencyResponse = response;
      getDependencyFilePath();
    } catch (e) {
      print(e);
    }
  }

  Future<DoPubGetResponse?> doPubGet() async {
    final request = DoPubGetRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response =
          await dartServices.doPubGet(request).timeout(longServiceCallTimeout);
      isLoading = false;
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return DoPubGetResponse()..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }
}
