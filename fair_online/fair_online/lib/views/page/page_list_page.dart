import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/page_model.dart';
import 'package:fair_online/utils/project_utils.dart';
import 'package:fair_online/views/page/page_list_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 页面列表
class PageListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageListPageState();
  }
}

class PageListPageState extends State<PageListPage> {
  bool hasInitialLoad = false;

  @override
  Widget build(BuildContext context) {
    return PageListPageView(this);
  }

  void setSelectedPage(int index, int innerIndex) {
    hasInitialLoad = true;
    var pageListModel = context.read<PageListModel>();
    pageListModel.selectedPageIndex = PageIndex(index, innerIndex);
    pageListModel.openCurrentEditFile(context);
  }

  Future<void> getPageList() {
    return context.read<PageListModel>().getPageList();
  }

  Future<void> selectPage(String pagePath) async {
    return context.read<PageListModel>().selectPage(context, pagePath);
  }

  Future<void> openCurrentEditFile() async {
    return context.read<PageListModel>().openCurrentEditFile(context);
  }

  Future<DeleteProjectPageResponse?> deletePage(String pageName) {
    return context
        .read<PageListModel>()
        .deletePage(ProjectUtils.projectName, pageName);
  }

  Future<CommonResponse?> copyPage(String dir, String path) {
    return context.read<PageListModel>().copyProjectPage(dir, path);
  }
}
