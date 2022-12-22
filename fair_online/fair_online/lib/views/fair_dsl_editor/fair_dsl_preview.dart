import 'package:flutter/material.dart';

import '../../models/fair_dsl_model.dart';
import 'fair_dsl_preview_view.dart';
import 'package:provider/provider.dart';

/**
 * Flutter预览页面
 */
class FairDslPreview extends StatefulWidget {
  @override
  FairDslPreviewState createState() => FairDslPreviewState();
}

class FairDslPreviewState extends State<FairDslPreview> {
  @override
  Widget build(BuildContext context) {
    return FairDslPreviewView(this);
  }

  void handleCompilePressed() {
    final fairDslModel = context.read<FairDslModel>();
    fairDslModel.handleFairCompile(context);
  }

  Future<void> handleRunPressed() async {
    final fairDslModel = context.read<FairDslModel>();
    var url = await fairDslModel.handleFairRun();
    fairDslModel.fairDslPreviewUrl = url;
  }
}
