import 'package:fair_online/app/app_initializer.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/fair_logo.dart';
import 'package:fair_online/base/components/popup_menu.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/page_routes.dart';
import 'package:fair_online/base/widget_view.dart';
import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/views/project/project_page.dart';
import 'package:fair_online/views/top_panel/top_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TopPanelView extends WidgetView<TopPanel, TopPanelState> {
  TopPanelView(TopPanelState state) : super(state);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    var currentPage =
        context.select<AppModel, MainPage>((value) => value.currentMainPage);
    var currentFlutterEditorPage = context.select<AppModel, FlutterEditorPage>(
        (value) => value.currentFlutterEditorPage);
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TransparentBtn(
                downColor: Colors.transparent,
                hoverColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                onPressed: () => Navigator.pushAndRemoveUntil<void>(
                  context,
                  PageRoutes.fade(() => ProjectPage(),
                      Durations.slow.inMilliseconds * .001),
                  ModalRoute.withName('/'),
                ),
                child: Row(
                  children: [
                    if (widget.showTab)
                      Container(
                        height: double.infinity,
                        width: 65,
                        child: Icon(
                          Icons.home_filled,
                          size: 22,
                          color: theme.txt,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 2, color: theme.divider),
                          ),
                        ),
                      ),
                    HSpace(Insets.sm),
                    FairLogo(50, theme.accent1Darker),
                    HSpace(Insets.sm),
                    Text("Fair 云开发平台",
                        style: TextStyles.T1.textColor(theme.txt)),
                  ],
                ),
              ),
              Row(
                children: [
                  if (widget.showTab)
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: TransparentBtn(
                        onPressed: () => state.onQrCode(),
                        downColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/images/ic_qr_code.png",
                          width: 20,
                          height: 20,
                          color: theme.txt,
                        ),
                      ),
                    ),
                  if (widget.showTab)
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: PopupMenu(
                          content: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                "assets/images/ic_function_more.png",
                                width: 25,
                                height: 25,
                                color: theme.txt,
                              )),
                          popup: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: 150,
                                child: TransparentBtn(
                                  onPressed: () {
                                    Navigator.pop(state.context);
                                    state.onPluginUpload();
                                  },
                                  downColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("上传补丁",
                                            style: TextStyles.T1
                                                .textColor(theme.txt)),
                                      ),
                                      Container(
                                          child: Image.asset(
                                        "assets/images/ic_upload_plugin.png",
                                        width: 20,
                                        height: 20,
                                        color: theme.txt,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: 150,
                                child: TransparentBtn(
                                  onPressed: () {
                                    Navigator.pop(state.context);
                                    state.onProjectDownload();
                                  },
                                  downColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("工程导出",
                                            style: TextStyles.T1
                                                .textColor(theme.txt)),
                                      ),
                                      Container(
                                          child: Image.asset(
                                        "assets/images/ic_download_project.png",
                                        width: 20,
                                        height: 20,
                                        color: theme.txt,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: TransparentBtn(
                      onPressed: () => launch(join(
                          kDebugMode ? DEBUG_RES_URL : RELEASE_RES_URL,
                          'doc/fair_online_help.pdf')),
                      downColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(5),
                      child: Image.asset(
                        "assets/images/ic_help.png",
                        width: 25,
                        height: 25,
                        color: theme.txt,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          (widget.showTab && currentPage == MainPage.FlutterEditor)
              ? Center(
                  child: Container(
                    width: 200,
                    child: TabBar(
                      controller: this.state.controller
                        ..index = currentFlutterEditorPage ==
                                FlutterEditorPage.Flutter
                            ? 0
                            : 1,
                      tabs: [
                        Tab(
                          text: "Flutter",
                        ),
                        Tab(
                          text: "Fair DSL",
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
