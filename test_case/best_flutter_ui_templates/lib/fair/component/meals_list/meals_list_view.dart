import 'package:best_flutter_ui_templates/fair/component/meals_list/meals_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/meals_list_data.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class MealsListView extends StatefulWidget {
  const MealsListView({Key? key}) : super(key: key);

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      width: 400,
      child: ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
        // itemCount: mealsListData.length,
        scrollDirection: Axis.horizontal,
        // itemBuilder: (BuildContext context, int index) {
        //   return MealsView(mealsListData: mealsListData[index]);
        // },

        children: [
          MealsView(mealsListData: MealsListData.icon1),
          MealsView(mealsListData: MealsListData.icon2),
          MealsView(mealsListData: MealsListData.icon3),
          MealsView(mealsListData: MealsListData.icon4),
        ],

        // children: [
        //   Container(color: Colors.red,width: 50,height: 100),
        //   Container(color: Colors.yellow,width: 50,height: 100),
        //   Container(color: Colors.blueAccent,width: 50,height: 100),
        // ],
      ),
    );
  }
}


