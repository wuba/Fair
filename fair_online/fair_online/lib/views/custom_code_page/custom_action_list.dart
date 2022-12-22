import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/models/custom_code_model.dart';
import 'package:fair_online/views/custom_code_page/custom_code_list_view.dart';
import 'package:fair_online/views/custom_code_page/item/custom_action_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomActionList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CustomActionListState();
  }

}

class CustomActionListState extends State<CustomActionList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomCodeModel model = context.watch<CustomCodeModel>();
    final list = model.actionsResponse.result;
    return CustomCodeListView<CustomActionInfo>(
      list: list,
      builder: (context, info) {
        return CustomActionItemWidget(info);
      },
    );
  }

}