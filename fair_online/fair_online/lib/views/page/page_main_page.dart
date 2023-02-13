import 'package:fair_online/models/page_model.dart';
import 'package:fair_online/views/page/page_main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 页面主页
class PageMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return PageMainPageState();
  }
}

class PageMainPageState extends State<PageMainPage> {
  @override
  void initState() {
    var model = context.read<PageListModel>();
    model.initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageMainPageView(this);
  }

}
