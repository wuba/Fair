import 'dart:convert';
import 'dart:io';

import 'package:fair_online_service/src/common.dart';
import 'package:fair_online_service/src/customcode/customcode_anno_checker.dart';
import 'package:fair_online_service/src/project/fair_project.dart';
import 'package:fair_online_service/src/protos/dart_services.pb.dart';
import 'package:logging/logging.dart';

import 'package:path/path.dart' as path;
import 'package:path/path.dart';

final Logger _logger = Logger('custom_code');

enum CustomCodeEditType { create, modify }

class CustomCode {
  static const String typeEditCreate = "create";
  static const String typeEditModify = "modify";

  void saveConfig(String editType, String targetPath, String name,
      Map<String, dynamic> map) async {
    File configFile = _checkConfig(targetPath);
    final content = await configFile.readAsString();
    Map configJson = jsonDecode(content);
    if (!configJson.containsKey(name)) {
      configJson[name] = <String, dynamic>{};
    }
    map.forEach((key, value) {
      configJson[name][key] = value;
    });
    configFile.writeAsStringSync(jsonEncode(configJson));
  }

  Future<Map<String, dynamic>> getConfig(String targetPath) async {
    File configFile = _checkConfig(targetPath);
    final content = await configFile.readAsString();
    return jsonDecode(content);
  }

  File _checkConfig(String targetPath) {
    String configPath = path.join(targetPath, 'config.json');
    var configJson = File(configPath);
    if (!configJson.existsSync()) {
      configJson.createSync(recursive: true);
      configJson.writeAsStringSync('{}');
    }
    return configJson;
  }

  ///创建自定义组件
  Future<CreateCustomComponentResponse> createCustomComponent(
      String projectName,
      String userId,
      String name,
      String desc,
      String content,
      List<int> screenshot,
      String editType) async {
    //代码路径
    String codePath = path.join(FairProject.userProjectDir(), userId,
        projectName, "lib", "code", 'component');
    var codeDir = Directory(codePath);
    if (!codeDir.existsSync()) {
      //不存在，创建目录
      codeDir.createSync(recursive: true);
    }
    File codeFile = File(codePath + "/" + name + ".dart");

    //创建组件做重名检测，已存在则返回错误码
    if (editType == CustomCodeEditType.create.name) {
      if (codeFile.existsSync()) {
        return CreateCustomComponentResponse(
            error: ErrorMessage(message: "已存在同名组件"));
      }
    }

    //创建组件做FairPatch注解检测，无注解则返回错误码
    if (!isValidCustomComponent(content)) {
      return CreateCustomComponentResponse(
          error: ErrorMessage(message: "自定义组件缺乏 @FairPatch 注解"));
    }

    //保存代码
    codeFile.writeAsStringSync(content);
    codeFile.createSync(recursive: true);

    //保存截图
    if (screenshot.isNotEmpty) {
      var previewPicDir = path.join(FairProject.userProjectDir(), userId,
          projectName, "previewPic", 'component');
      var screenshotFile = File(path.join(previewPicDir, '$name.png'));
      if (!screenshotFile.existsSync()) {
        screenshotFile.createSync(recursive: true);
      }
      screenshotFile.writeAsBytesSync(screenshot);
    }

    //保存其他信息
    saveConfig(editType, codePath, name, {'desc': desc});
    return CreateCustomComponentResponse(status: 0);
  }

  void updateComponentConfig() {}

  ///创建自定义Action
  Future<CreateCustomActionResponse> createCustomAction(
      String projectName,
      String userId,
      String name,
      String desc,
      String content,
      String editType) async {
    String codePath = path.join(FairProject.userProjectDir(), userId,
        projectName, "lib", "code", 'action');
    var codeDir = Directory(codePath);
    if (!codeDir.existsSync()) {
      //不存在，创建目录
      codeDir.createSync(recursive: true);
    }
    File codeFile = File(codePath + "/" + name + ".dart");

    //创建Action做重名检测，已存在则返回错误码
    if (editType == CustomCodeEditType.create.name) {
      if (codeFile.existsSync()) {
        return CreateCustomActionResponse(error: ErrorMessage(message: "已存在同名Action"));
      }
    }
    print(codePath);

    //开始创建文件
    codeFile.writeAsStringSync(content);
    codeFile.createSync(recursive: true);

    //保存其他信息
    saveConfig(editType, codePath, name, {'desc': desc});
    return CreateCustomActionResponse(status: 0);
  }

  ///获取自定义组件
  Future<GetCustomComponentsResponse> getCustomComponents(
      String projectName, String userId) async {
    GetCustomComponentsResponse response = GetCustomComponentsResponse();
    String itemsPath = path.join(FairProject.userProjectDir(), userId,
        projectName, "lib", "code", 'component');
    var itemsDir = Directory(itemsPath);
    var previewPicDir = path.join(FairProject.userProjectDir(), userId,
        projectName, "previewPic", 'component');
    Map config = await getConfig(itemsPath);
    if (itemsDir.existsSync()) {
      //文件夹存在，遍历
      //从目标文件夹下拿到所有子文件夹
      itemsDir.listSync().forEach((element) {
        String elementPath = element.path;
        if (!elementPath.endsWith('.dart')) {
          return;
        }
        String name =
            elementPath.replaceAll(itemsPath + "/", "").replaceAll(".dart", "");

        var basename = basenameWithoutExtension(elementPath);
        var screenshotFile = File(path.join(previewPicDir, '$basename.png'));
        var screenshotUrl = '';
        if (screenshotFile.existsSync()) {
          screenshotUrl = path.join(resourceHost, 'userProject', userId,
              projectName, "previewPic", 'component', '$basename.png');
        }
        String desc = '';
        try {
          desc = config[name]['desc'];
        } catch (e, st) {
          _logger.warning('Compiler failed: $e\n$st');
        }
        response.result.add(CustomComponentInfo(
            name: name,
            desc: desc,
            path: elementPath,
            fairWidgetCode: '''
FairWidget(
  name: 'lib_code_component_$name',
  path: 'assets/fair/lib_code_component_$name.fair.json',
)
            ''',
            screenshot: screenshotUrl));
      });
    }
    return response;
  }

  ///获取自定义Action
  Future<GetCustomActionsResponse> getCustomActions(
      String projectName, String userId) async {
    GetCustomActionsResponse response = GetCustomActionsResponse();
    String itemsPath = path.join(FairProject.userProjectDir(), userId,
        projectName, "lib", "code", 'action');
    var itemsDir = Directory(itemsPath);
    Map config = await getConfig(itemsPath);
    if (itemsDir.existsSync()) {
      //文件夹存在，遍历
      //从目标文件夹下拿到所有子文件夹
      itemsDir.listSync().forEach((element) {
        String elementPath = element.path;
        if (!elementPath.endsWith('.dart')) {
          return;
        }
        String name =
            elementPath.replaceAll(itemsPath + "/", "").replaceAll(".dart", "");
        String desc = '';
        try {
          desc = config[name]['desc'];
        } catch (e, st) {
          _logger.warning('Compiler failed: $e\n$st');
        }
        response.result.add(CustomActionInfo(
          name: name,
          desc: desc,
          path: elementPath,
        ));
      });
    }
    return response;
  }

  ///删除自定义代码
  Future<DeleteCustomCodeItemResponse> deleteCustomCodeItem(String projectName,
      String userId, String name, String elementPath, String type) async {
    DeleteCustomCodeItemResponse response = DeleteCustomCodeItemResponse();
    var file = File(elementPath);
    print(file.path);
    if (file.existsSync()) {
      file.deleteSync(recursive: true);
    } else {
      response.error = ErrorMessage(message: "文件不存在，删除失败");
    }
    return response;
  }
}
