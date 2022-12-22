
import 'package:fair_online/utils/project_utils.dart';

class CodeTemplateInitUtils {

  static String getTemplateCode() {
    return '''
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:${ProjectUtils.projectName}/fair_preview_annotation.dart';

//自定义组件的目标widget需要以下注解，注意不要误删
@FairPreviewComponent()
@FairPatch()
class XXXPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return XXXPageState();
  }
}

class XXXPageState extends State<XXXPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
''';
  }
}