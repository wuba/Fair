import 'package:fair_online/app/themes.dart';
import 'package:fair_online/models/api_call_model.dart';
import 'package:fair_online/views/api_call_page/api_call_add_page_view.dart';
import 'package:fair_online/views/api_call_page/api_call_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * 网络请求配置页面
 */
class ApiCallPage extends StatefulWidget {
  @override
  ApiCallPageState createState() => ApiCallPageState();
}

class ApiCallPageState extends State<ApiCallPage> {
  @override
  void initState() {
    super.initState();
    context.read<ApiCallModel>().getAllApiCall();
  }

  @override
  Widget build(BuildContext context) {
    final showAddView =
        context.select<ApiCallModel, bool>((value) => value.showAddView);
    final width = (MediaQuery.of(context).size.width - 70) * 4 / 5;
    final height = (MediaQuery.of(context).size.height - 70) * 4 / 5;
    AppTheme theme = context.watch();

    return showAddView
        ? ApiCallAddPageView(
            this,
            requiredWidth: width,
            requiredHeight: height,
            theme: theme,
          )
        : ApiCallPageView(
            this,
            requiredWidth: width,
            requiredHeight: height,
            theme: theme,
          );
  }
}
