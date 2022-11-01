import 'package:best_flutter_ui_templates/fair/component/my_diary/mediterranean_diet.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import '../component/fair_uiview/title_view.dart';

@FairPatch()
class MyDiaryPage extends StatefulWidget {
  const MyDiaryPage({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyDiaryPageState createState() => _MyDiaryPageState();
}

class _MyDiaryPageState extends State<MyDiaryPage> {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    super.initState();
    addAllListData();
  }

  void addAllListData() {
    listViews.add(
      TitleView(titleTxt: 'Mediterranean diet', subTxt: 'Details'),
    );
    listViews.add(
        FairWidget(
          name: 'mediterranean_diet_view',
          path: 'assets/bundle/lib_fair_component_my_diary_mediterranean_diet.fair.json',
        )
    );
    listViews.add(
      TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Customize'
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getAppBarUI(),
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: FitnessAppTheme.white.withOpacity(1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: FitnessAppTheme.grey
                  .withOpacity(0.4),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16 - 8.0,
                bottom: 12 - 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'My Diary',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        letterSpacing: 1.2,
                        color: FitnessAppTheme.darkerText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  width: 38,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(32.0)),
                    onTap: () {},
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: FitnessAppTheme.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.calendar_today,
                          color: FitnessAppTheme.grey,
                          size: 18,
                        ),
                      ),
                      Text(
                        '15 May',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          letterSpacing: -0.2,
                          color: FitnessAppTheme.darkerText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 38,
                  width: 38,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(32.0)),
                    onTap: () {},
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: FitnessAppTheme.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController?.forward();
        return listViews[index];
      },
    );
  }
}
