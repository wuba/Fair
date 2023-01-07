import 'package:fair_online/editor/fair_online.dart';
import 'package:fair_online/editor/services/common.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/models/dart_editor_model.dart';
import 'package:fair_online/utils/device_utils.dart';
import 'package:fair_online/utils/project_utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class PageListModel extends AbsModel {
  bool isLoading = true;
  late GetProjectPagesResponse projectPagesResponse;
  GetTemplatePagesResponse getTemplatePagesResponse =
      GetTemplatePagesResponse();
  PageIndex _selectedPageIndex = PageIndex(0, 0);

  PageIndex get selectedPageIndex => _selectedPageIndex;

  set selectedPageIndex(PageIndex value) {
    _selectedPageIndex = value;
    notifyListeners();
  }

  Future<void> initialized() async {
    projectPagesResponse = GetProjectPagesResponse();
    getPageList();
  }

  void openCurrentEditFile(BuildContext context) {
    if (projectPagesResponse.result.isEmpty) {
      return;
    }
    if (projectPagesResponse.result.length <= selectedPageIndex.pageIndex) {
      selectedPageIndex = PageIndex(projectPagesResponse.result.length - 1, 0);
    }
    var pageInfo = projectPagesResponse.result[selectedPageIndex.pageIndex];
    var innerIndex = selectedPageIndex.innerIndex;
    if (innerIndex >= pageInfo.files.length) {
      innerIndex = 0;
    }
    context
        .read<DartEditorModel>()
        .getCodeByPage(p.join(pageInfo.dir, pageInfo.files[innerIndex].path));
  }

  void selectPage(BuildContext context, String pageDir) {
    if (projectPagesResponse.result.isEmpty) {
      return;
    }
    var selectedIndex = projectPagesResponse.result
        .indexWhere((element) => element.dir == pageDir);
    if (selectedIndex >= 0) {
      selectedPageIndex = PageIndex(selectedIndex, 0);
    }
    openCurrentEditFile(context);
  }

  Future<void> getPageList() async {
    final request = GetProjectPagesRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response = await dartServices
          .getProjectPages(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      projectPagesResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<CreateProjectPageResponse?> createEmptyPage(
      String pagePath, String pageName) async {
    final request = CreateProjectPageRequest();
    request.pagePath = pagePath;
    request.pageName = pageName;
    try {
      final response = await dartServices
          .createProjectPage(request)
          .timeout(serviceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CreateProjectPageResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<CommonResponse?> copyProjectPage(String dir, String pagePath) async {
    var request = CopyPageRequest()
      ..dir = dir
      ..path = pagePath;
    try {
      final response = await dartServices
          .copyProjectPage(request)
          .timeout(longServiceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CommonResponse()..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<DeleteProjectPageResponse?> deletePage(
      String projectName, String pageName) async {
    final request = DeleteProjectPageRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = projectName;
    request.pageName = pageName;
    try {
      final response = await dartServices
          .deleteProjectPage(request)
          .timeout(serviceCallTimeout);
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return DeleteProjectPageResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }

  Future<void> getTemplatePageList() async {
    final request = GetTemplatePagesRequest();
    request.userId = DeviceUtils.getFingerId();
    request.projectName = ProjectUtils.projectName;
    try {
      final response = await dartServices
          .getTemplatePages(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      getTemplatePagesResponse = response;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<CreateTemplatePageResponse?> createTemplatePage(
      String pagePath, String pageName, String templatePage) async {
    final request = CreateTemplatePageRequest();
    request.pagePath = pagePath;
    request.pageName = pageName;
    request.templatePage = templatePage;
    try {
      final response = await dartServices
          .createTemplatePage(request)
          .timeout(serviceCallTimeout);
      isLoading = false;
      return response;
    } catch (e) {
      if (e is ApiRequestError) {
        return CreateTemplatePageResponse()
          ..error = ErrorMessage(message: e.message);
      }
      print(e);
      return null;
    }
  }
}

class PageIndex {
  final int pageIndex;
  final int innerIndex;

  PageIndex(this.pageIndex, this.innerIndex);
}
