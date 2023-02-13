import 'package:fair_online/models/app_model.dart';
import 'package:fair_online/views/main/main_scaffold_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainScaffold extends StatefulWidget {
  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  List<MainPage> pages = [
    MainPage.None,
    MainPage.FlutterEditor,
    MainPage.ApiCall,
    MainPage.CustomCode,
    MainPage.EditorExample,
    MainPage.Dependency
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      context.read<AppModel>().currentMainPage = MainPage.FlutterEditor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffoldView(this);
  }

  int getSelectedIndex(MainPage currentPage){
    return pages.indexOf(currentPage);
  }

}
