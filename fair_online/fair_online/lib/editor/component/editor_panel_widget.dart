import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///编辑器面板
class EditorPanel extends StatefulWidget {
  FlutterEditorController controller;

  VoidCallback? onArrowPressed;

  bool isExpandEnabled = false;

  bool isExpand = false;

  EditorPanel(
      {required this.controller,
      this.onArrowPressed,
      this.isExpand = false,
      this.isExpandEnabled = false});

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel>
    with SingleTickerProviderStateMixin {
  late FlutterEditorController _flutterEditorController;
  late TabController _tabController;
  late ScrollController _scrollController;
  ConsoleMessageList? _consoleMessageList;

  @override
  void initState() {
    super.initState();
    _flutterEditorController = widget.controller;
    _tabController = TabController(length: 1, vsync: this);
    //TabBar监听器
    _tabController.addListener(() => _onTabChanged());
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 36,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "Console",
                    ),
                    // Tab(
                    //   text: "Documentation",
                    // )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 34,
                height: 34,
                child: Builder(
                  builder: (context) {
                    if (widget.isExpandEnabled) {
                      return MaterialButton(
                        shape: CircleBorder(),
                        onPressed: () {
                          if (widget.onArrowPressed != null) {
                            widget.onArrowPressed!();
                          }
                        },
                        child: Icon(
                          widget.isExpand
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          size: 18,
                          color: theme.txt,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Align()
          ],
        ),
        _tabController.index == 0
            ? Flexible(
                child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: ValueListenableBuilder<ConsoleMessageList>(
                  valueListenable: _flutterEditorController.consoleMessageList,
                  builder: (context, consoleMessageList, child) {
                    final value = consoleMessageList.value;
                    if (_consoleMessageList != consoleMessageList &&
                        value.length > 0) {
                      Future.delayed(Duration(milliseconds: 50), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                    }
                    _consoleMessageList = consoleMessageList;
                    return ListView.builder(
                        itemCount: value.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final consoleMessage = value[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              consoleMessage.message,
                              style: TextStyles.Body1.textColor(
                                      consoleMessage.isError
                                          ? theme.error
                                          : theme.txt)
                                  .letterSpace(.7),
                            ),
                          );
                        });
                  },
                ),
              ))
            : Container()
      ],
    );
  }

  _onTabChanged() {
    if (_tabController.indexIsChanging) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
