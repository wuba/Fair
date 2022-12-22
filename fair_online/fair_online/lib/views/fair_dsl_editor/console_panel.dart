import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/editor/component/flutter_editor_controller.dart';
import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsolePanel extends StatefulWidget {
  @override
  State<ConsolePanel> createState() => _ConsolePanelState();
}

class _ConsolePanelState extends State<ConsolePanel>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late ScrollController _scrollController;
  ConsoleMessageList? _consoleMessageList;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
    _controller.addListener(() => _onTabChanged());
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
                  controller: _controller,
                  tabs: [
                    Tab(
                      text: "Console",
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 34,
                height: 34,
                child: MaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    FairDslModel model = context.read();
                    model.isConsolePanelShow = !model.isConsolePanelShow;
                  },
                  child: Selector<FairDslModel, bool>(
                    selector: (context, model) => model.isConsolePanelShow,
                    builder: (context, value, child) {
                      return Icon(
                        value
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 18,
                        color: theme.txt,
                      );
                    },
                  ),
                ),
              ),
            ),
            Align()
          ],
        ),
        _controller.index == 0
            ? Flexible(
                child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Selector<FairDslModel, ConsoleMessageList>(
                  selector: (context, model) => model.consoleMessageList,
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
    if (_controller.indexIsChanging) {
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
