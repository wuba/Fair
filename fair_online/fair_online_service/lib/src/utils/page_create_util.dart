class PageCreateUtil {
  ///创建页面内容
  static String createPageContent(String pageName, String projectName) {
    String pageState = '_${pageName}State';
    String pageStateReturn = '_${pageName}State()';
    var content = '''
import 'package:fair/fair.dart';
import 'package:flutter/material.dart'; 
import 'package:$projectName/fair_preview_annotation.dart';   

@FairPreviewPage()
@FairPatch()
class $pageName extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return $pageStateReturn;
  }

}

class $pageState extends State<$pageName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$pageName')),
      body: Container(
        child: Center(
          child: Text(
            "This is $pageName"
          ),
        ),
      ),
    );
  }
}
''';
    return content;
  }
}
