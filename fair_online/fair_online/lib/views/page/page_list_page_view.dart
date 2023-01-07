import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/popup_menu.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_dialogs.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/editor/src/protos/dart_services.pb.dart';
import 'package:fair_online/models/page_model.dart';
import 'package:fair_online/utils/color_utils.dart';
import 'package:fair_online/views/page/page_list_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PageListPageView extends WidgetView<PageListPage, PageListPageState> {
  List<ProjectPageInfo> pages = [];

  PageListPageView(PageListPageState state) : super(state);

  @override
  Widget build(BuildContext context) {
    PageListModel model = context.watch<PageListModel>();
    AppTheme theme = context.watch();
    pages = model.projectPagesResponse.result;
    if (pages.length > model.selectedPageIndex.pageIndex &&
        !state.hasInitialLoad) {
      //延迟一秒加载页面，否则会报错
      Future.delayed(Duration(milliseconds: 1), () {
        _selectItem(model.selectedPageIndex.pageIndex,
            model.selectedPageIndex.innerIndex);
      });
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: theme.divider))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 25, bottom: 10),
            child: Text(
              '页面列表',
              style: TextStyles.T1,
            ),
          ),
          Expanded(
              child: Selector<PageListModel, PageIndex>(
                  selector: (context, model) => model.selectedPageIndex,
                  builder: (context, selectedPageIndex, child) {
                    return ListView.builder(
                        itemCount: pages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _getItemWidget(
                              context, pages, theme, index, selectedPageIndex);
                        });
                  }))
        ],
      ),
    );
  }

  Widget _getItemWidget(BuildContext context, List<ProjectPageInfo> list,
      AppTheme theme, int index, PageIndex selectedPageIndex) {
    ProjectPageInfo info = list[index];
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {
          _selectItem(index, 0);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Corners.s5Border,
            border: Border.all(
                color: index == selectedPageIndex.pageIndex
                    ? theme.accent1Dark
                    : ColorUtils.shiftHsl(theme.divider, .2),
                width: 1),
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  HSpace(20),
                  Expanded(
                      child: Text(
                    info.dir,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: theme.accentTxt),
                  )),
                  _itemMoreWidget(theme, info.dir, ''),
                ],
              ),
            ]..addAll(index == selectedPageIndex.pageIndex
                ? info.files.map(
                    (file) {
                      int currentIndex = info.files.indexOf(file);
                      bool isInnerSelected =
                          selectedPageIndex.innerIndex == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          _selectItem(index, currentIndex);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 3),
                          height: 50,
                          decoration: BoxDecoration(
                              color: theme.divider,
                              borderRadius: Corners.s5Border),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                decoration: BoxDecoration(
                                  color: isInnerSelected
                                      ? theme.accent1Dark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Corners.s8Radius),
                                ),
                              ),
                              HSpace(7),
                              Expanded(
                                  child: Text(
                                file.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: theme.accentTxt),
                              )),
                              _itemMoreWidget(theme, info.dir, file.name)
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList()
                : []),
          ),
        ),
      ),
    );
  }

  _selectItem(int index, int innerIndex) {
    state.setSelectedPage(index, innerIndex);
  }

  Widget _itemMoreWidget(AppTheme theme, String dir, String name) {
    var fullPath = join(dir, name);
    return PopupMenu(
      dx: -100,
      content: Container(
        width: 39,
        height: 39,
        child: Center(
            child: Image.asset(
          "assets/images/ic_page_main_item_more.png",
          width: 20,
          height: 20,
        )),
      ),
      popup: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.pop(state.context);
              var result = await state.copyPage(dir, name);
              if (result == null || result.error.message.isNotEmpty) {
                Dialogs.show(
                  OkCancelDialog(
                    message: result?.error.message ?? '复制失败，请稍后再试~',
                    onOkPressed: () => Navigator.pop(state.context),
                  ),
                );
              } else {
                await state.getPageList();
                if (result.result.isNotEmpty && result.result != dir) {
                  state.selectPage(result.result);
                }
              }
            },
            child: Container(
              width: 200,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: ColorUtils.shiftHsl(theme.divider, .05),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          name.isEmpty ? '复制页面' : '复制文件',
                          style: TextStyles.T1.textColor(theme.txt),
                        ),
                      ),
                      Icon(
                        Icons.copy,
                        size: 20,
                        color: theme.txt,
                      )
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(state.context);
              Dialogs.show(
                OkCancelDialog(
                  message: '确定要删除：\"${name.isEmpty ? dir : name}\" ？',
                  onCancelPressed: () => Navigator.pop(state.context),
                  onOkPressed: () async {
                    Navigator.pop(state.context);
                    var result = await state.deletePage(fullPath);
                    if (result == null || result.error.message.isNotEmpty) {
                      Dialogs.show(
                        OkCancelDialog(
                          message: result?.error.message ?? '删除失败，请稍后再试~',
                          onOkPressed: () => Navigator.pop(state.context),
                        ),
                      );
                    } else {
                      await state.getPageList();
                      state.openCurrentEditFile();
                    }
                  },
                ),
              );
            },
            child: Container(
              width: 200,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: ColorUtils.shiftHsl(theme.divider, .05),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          name.isEmpty ? '删除页面' : '删除文件',
                          style: TextStyles.T1.textColor(theme.txt),
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: theme.txt,
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
