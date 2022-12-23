import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:fair_online_service/src/common_server_impl.dart';
import 'package:fair_online_service/src/visitor/preview_component_visitor.dart';
import 'package:fair_online_service/src/visitor/preview_page_visitor.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

final Logger _logger = Logger('compile_ddc_code');

String kCompileDDCMainCode(String projectPath) {
  final pageClassList = getPageClassNameList(projectPath);
  return '''
/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
import 'plugins/net/fair_net_plugin.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'src/module.fair.dart' as g;
${_importCode(pageClassList.classPathList)}

void main() {
  runApp(
    FairApp(
      generated: g.FairAppModule(),
      child: DevicePreview(
        backgroundColor: const Color(0xff15181B),
        enabled: true,
        tools: const [
          ...DevicePreview.defaultTools,
        ],
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: '在线预览',
      routes: {
        ${_routesCode(pageClassList.classNameList)}    
      },
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget{

  final itemList = [
    ${_itemListCode(pageClassList.classNameList)}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在线预览'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(item.routePath);
                },
                child: Container(
                  height: 50,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 0.5,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

}

class RouteItem {
  final name;
  final routePath;

  RouteItem(this.name, this.routePath);
}  
  ''';
}

/// 获取page目录下所有被@FairPreviewPage注解的widget
PageClassResult getPageClassNameList(String projectPath) {
  final classNameList = <NameData>[];
  final classPathList = <NameData>[];
  final pagePath = path.join(projectPath, 'lib', 'page');
  final pageDirectory = Directory(pagePath);
  var prefixIndex = 0;
  for (var directoryEntity in pageDirectory.listSync()) {
    for (var fileEntity in Directory(directoryEntity.path).listSync()) {
      final filePath = fileEntity.path;
      //如果传入的source是有错误的，可能会导致抽象语法树转换失败
      ParseStringResult? parseResult;
      try {
        final src = File(filePath).readAsStringSync();
        parseResult = parseString(content: src, path: filePath);
      } catch (e) {
        _logger.warning('getPageClassNameList parseString error ===>$e');
      }

      if (parseResult != null) {
        var compilationUnit = parseResult.unit;
        final visitor = PreviewPageVisitor();
        //遍历AST
        compilationUnit.accept(visitor);
        if (visitor.pages.isNotEmpty) {
          var prefixData = 'p$prefixIndex';
          classNameList.addAll(visitor.pages
              .map((e) => NameData(name: e, prefix: prefixData))
              .toList());
          classPathList.add(NameData(
              name: filePath
                  .replaceFirst(path.join(projectPath, 'lib'), '')
                  .substring(1),
              prefix: prefixData));
          prefixIndex++;
        }
      }
    }
  }
  return PageClassResult(
      classNameList: classNameList, classPathList: classPathList);
}

class PageClassResult {
  List<NameData> classNameList = [];
  List<NameData> classPathList = [];

  PageClassResult({required this.classNameList, required this.classPathList});
}

class NameData {
  String name = '';
  String prefix = '';

  NameData({required this.name, required this.prefix});
}

String _importCode(List<NameData> classPathList) {
  return classPathList.map((e) {
    return 'import \'${e.name}\' as ${e.prefix};\n';
  }).join();
}

String _routesCode(List<NameData> pageClassNameList) {
  return pageClassNameList.map((e) {
    return '\'/${e.prefix}_${e.name}\' : (context) => ${e.prefix}.${e.name}(),\n';
  }).join();
}

String _itemListCode(List<NameData> pageClassNameList) {
  return pageClassNameList.map((e) {
    return 'RouteItem(\'${e.prefix}_${e.name}\', \'/${e.prefix}_${e.name}\'),\n';
  }).join();
}

String kCompileDDCTempFileCode(String source) {
  return '''
import 'package:flutter/material.dart';
import 'temp/temp.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html;

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      screenshotController
          .capture(delay: Duration(milliseconds: 10))
          .then((capturedImage) async {
        final message = {
          'command': 'CapturedWidget',
          'data': capturedImage,
        };
        html.window.parent?.postMessage(message, '*');
      }).catchError((onError) {
        print(onError);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child:${getTempClassName(source)}(),
        ),
      ),
    );
  }
}

  ''';
}

/// 获取临时文件中第一个被@FairPreviewComponent()修饰的类名
String getTempClassName(String source) {
  //如果传入的source是有错误的，可能会导致抽象语法树转换失败
  ParseStringResult? parseResult;
  try {
    parseResult = parseString(content: source);
  } catch (e) {
    _logger.warning('getPageClassNameList parseString error ===>$e');
  }

  if (parseResult != null) {
    var compilationUnit = parseResult.unit;
    final visitor = PreviewComponentVisitor();
    //遍历AST
    compilationUnit.accept(visitor);
    if (visitor.pages.isEmpty) {
      throw BadRequest('自定义组件的Widget需要用@FairPreviewComponent()注解修饰!');
    }
    return visitor.pages.first;
  }
  return '';
}

String kCompileDDCSingleFileCode(String filePath, String projectPath) {
  String importPath =
      filePath.split(projectPath).last.replaceFirst('/lib/', '');
  return '''
import 'package:flutter/material.dart';
import '$importPath';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html;

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      screenshotController
          .capture(delay: Duration(milliseconds: 10))
          .then((capturedImage) async {
        final message = {
          'command': 'CapturedWidget',
          'data': capturedImage,
        };
        html.window.parent?.postMessage(message, '*');
      }).catchError((onError) {
        print(onError);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child:${getComponentClassName(filePath)}(),
        ),
      ),
    );
  }
}
  ''';
}

/// 获取文件中第一个被@FairPreviewComponent()修饰的类名
String getComponentClassName(String filePath) {
  //如果传入的source是有错误的，可能会导致抽象语法树转换失败
  ParseStringResult? parseResult;
  try {
    final src = File(filePath).readAsStringSync();
    parseResult = parseString(content: src, path: filePath);
  } catch (e) {
    _logger.warning('getPageClassNameList parseString error ===>$e');
  }

  if (parseResult != null) {
    var compilationUnit = parseResult.unit;
    final visitor = PreviewComponentVisitor();
    //遍历AST
    compilationUnit.accept(visitor);
    if (visitor.pages.isEmpty) {
      throw BadRequest('自定义组件的Widget需要用@FairPreviewComponent()注解修饰!');
    }
    return visitor.pages.first;
  }
  return '';
}
