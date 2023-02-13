import 'package:fair_online/models/fair_dsl_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fair_dsl_editor_view.dart';

/**
 * Fair DSL 查看及预览效果页面
 */
class FairDslEditor extends StatefulWidget {
  @override
  FairDslEditorState createState() => FairDslEditorState();
}

class FairDslEditorState extends State<FairDslEditor> {
  static const String fairDslPreviewViewType = 'fair-dsl-preview';

  @override
  void initState() {
    super.initState();
    final fairDslModel = context.read<FairDslModel>();
    fairDslModel.initFairDslPreviewFrame(fairDslPreviewViewType);
  }

  @override
  Widget build(BuildContext context) {
    return FairDslEditorView(this);
  }
}
