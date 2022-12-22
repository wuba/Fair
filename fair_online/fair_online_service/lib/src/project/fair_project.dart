import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fair_online_service/src/analysis_server.dart';
import 'package:fair_online_service/src/common.dart';
import 'package:fair_online_service/src/project/page_template_config.dart';
import 'package:fair_online_service/src/protos/dart_services.pb.dart';
import 'package:fair_online_service/src/sdk.dart';
import 'package:fair_online_service/src/utils.dart';
import 'package:fair_online_service/src/utils/change_dependency_util.dart';
import 'package:fair_online_service/src/utils/page_create_util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

final Logger log = Logger('common_server');

final gFlutterAnalysisWrapper = <String, FlutterAnalysisServerWrapper>{};

class FairProject {
  static String _userProjectDir() =>
      path.join(Directory.current.path, 'fairDir', 'userProject');
  static String userProjectDir() => _userProjectDir();

  static String _templateDir() =>
      path.join(Directory.current.path, 'fairDir', 'template');

  static String _templateProjectDir() => path.join(_templateDir(), 'project');

  static String _templatePageDir() => path.join(_templateDir(), 'page');

  static String _toolDir() =>
      path.join(Directory.current.path, 'fairDir', 'tools');

  static String _emptyDir() =>
      path.join(Directory.current.path, 'fairDir', 'empty');

  static String _emptyProjectDir() => path.join(_emptyDir(), 'project');

  static String _emptyPageDir() => path.join(_emptyDir(), 'page');

  static String _emptyProject() =>
      path.join(_emptyProjectDir(), 'empty_project');

  final Sdk _sdk;

  FairProject(Sdk sdk) : this._(sdk);

  FairProject._(this._sdk);

  Future<GetProjectResponse> getProjects(String user) async {
    try {
      GetProjectResponse result = GetProjectResponse();
      var userProjectDir = Directory(path.join(_userProjectDir(), user));
      if (!userProjectDir.existsSync()) {
        userProjectDir.createSync(recursive: true);
        return result;
      }
      for (final entity in userProjectDir.listSync(recursive: false)) {
        if (entity is Directory) {
          var modifiedTime = entity.statSync().modified.microsecondsSinceEpoch;
          result.result.add(ProjectInfo(
              name: basename(entity.path),
              modifiedTime: modifiedTime.toString()));
        }
      }
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during getProjects on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<GetProjectResponse> getTemplateProjects(String user) async {
    try {
      GetProjectResponse result = GetProjectResponse();
      var templateProjectDir = Directory(_templateProjectDir());
      if (!templateProjectDir.existsSync()) {
        templateProjectDir.createSync(recursive: true);
        return result;
      }
      for (final entity in templateProjectDir.listSync(recursive: false)) {
        if (entity is Directory) {
          var projectDesc = '';
          var projectScreenshot = '';
          var pubspecFile = File(path.join(entity.path, 'pubspec.yaml'));
          if (pubspecFile.existsSync()) {
            try {
              YamlMap yamlData = loadYaml(pubspecFile.readAsStringSync());
              projectDesc = yamlData['project_desc'];
              var screenshotName = yamlData['project_screenshot'];
              var screenshotFile = File(path.join(entity.path, screenshotName));
              if (screenshotFile.existsSync()) {
                projectScreenshot = path.join(resourceHost, 'template',
                    'project', basename(entity.path), screenshotName);
              }
            } catch (e) {
              log.severe('Error during getTemplateProjects on "$user"', e);
            }
          }
          result.result.add(ProjectInfo(
              name: basename(entity.path),
              desc: projectDesc,
              screenshot: projectScreenshot));
        }
      }
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during getTemplateProjects on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<CreateProjectResponse> createProject(
      String user, String projectName, String? template) async {
    try {
      CreateProjectResponse result = CreateProjectResponse();
      String templateDir;
      String templateProjectPackage,
          templateProjectAppName,
          templateProjectName;
      if (template?.isNotEmpty ?? false) {
        var templateProject =
            Directory(path.join(_templateProjectDir(), template));
        if (!templateProject.existsSync()) {
          result.error = ErrorMessage(message: '创建失败，模板工程不存在~');
          return result;
        }
        templateDir = templateProject.path;
        if (template == 'fair_samples') {
          templateProjectPackage = 'com.example.fair_samples';
          templateProjectAppName = 'app_name';
          templateProjectName = 'fair_samples';
        } else {
          templateProjectPackage = 'fair.example';
          templateProjectAppName = 'app_name';
          templateProjectName = 'fair_example';
        }
      } else {
        var emptyProject = Directory(_emptyProject());
        if (!emptyProject.existsSync()) {
          result.error = ErrorMessage(message: '创建失败，空工程不存在~');
          return result;
        }
        templateDir = emptyProject.path;
        templateProjectPackage = 'com.example.empty_project';
        templateProjectAppName = 'app_name';
        templateProjectName = 'empty_project';
      }

      var projectDirPath = path.join(_userProjectDir(), user, projectName);
      var projectDir = Directory(projectDirPath);
      if (projectDir.existsSync()) {
        result.error = ErrorMessage(message: '创建失败，该工程已存在~');
        return result;
      } else {
        projectDir.createSync(recursive: true);
      }
      await copyPath(templateDir, projectDir.path);

      /// modify project name
      var runResult = await Process.run(
          '/bin/sh',
          [
            'project_rename.sh',
            projectName,
            projectDirPath,
            templateProjectPackage,
            templateProjectAppName,
            templateProjectName
          ],
          workingDirectory: _toolDir());
      if (runResult.exitCode != 0) {
        result.error = ErrorMessage(
            message:
                'Rename project failed. \n${runResult.stdout} \n${runResult.stderr}');
        return result;
      }
      await Process.run('/bin/sh', ['modify_project_name.sh', projectName],
          workingDirectory: projectDirPath);

      /// run flutter pub get
      await Process.run(_sdk.flutterToolPath, ['pub', 'get'],
          workingDirectory: projectDirPath);
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during createProject on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<DeleteProjectResponse> deleteProject(
      String user, String projectName) async {
    try {
      DeleteProjectResponse result = DeleteProjectResponse();
      var projectDir =
          Directory(path.join(_userProjectDir(), user, projectName));
      if (!projectDir.existsSync()) {
        result.error = ErrorMessage(message: '删除失败，该工程不存在~');
        return result;
      }
      await projectDir.delete(recursive: true);

      final uniqueId = user + projectName;

      ///analysis_server_lib.dart在创建AnalysisServer的时候传入l process.kill操作，调用dispose就能执行
      gFlutterAnalysisWrapper.remove(uniqueId)?.dispose();

      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during deleteProject on "$user"', e, st);
      }
      rethrow;
    }
  }

  ///上传补丁
  Future<UploadPluginResponse> uploadPlugin(String user, String projectName,
      String appId, String bundleName, String patchUrl) async {
    try {
      UploadPluginResponse result = UploadPluginResponse();
      var patchFilePath = path.join(_userProjectDir(), user, projectName,
          "build", "fair", "fair_patch.zip");
      var patchFile = File(patchFilePath);
      if (!patchFile.existsSync()) {
        result.error = ErrorMessage(message: '上传失败，补丁不存在~');
        return result;
      }

      final uploadUrl = 'https://xx.xx.xx.xx/app/create_patch';
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      final params = {
        'appId': appId,
        'bundleName': bundleName,
        'patchUrl': patchUrl,
        'bundleVersion': '1.0.0',
        'status': '1',
        'remark': ' '
      };
      request.fields.addAll(params);
      request.files.add(await http.MultipartFile.fromPath(
          'fair_patch.zip', patchFilePath,
          contentType: MediaType.parse('application/zip')));
      final response = await request.send();
      if (response.statusCode != 200) {
        result.error = ErrorMessage(message: '上传失败，请稍后再试~');
        return result;
      }
      String res = await response.stream.bytesToString();
      final resJson = json.decode(res);
      final code = resJson['code'];
      final msg = resJson['msg'];
      if ((code != -1) == true) {
        result.result = "上传成功";
      } else {
        result.result = "上传失败:$msg";
      }
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during uploadPlugin on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<ExportProjectResponse> exportProject(
      String user, String projectName) async {
    try {
      ExportProjectResponse result = ExportProjectResponse();
      var projectDirPath = path.join(_userProjectDir(), user, projectName);
      var projectDir = Directory(projectDirPath);
      if (!projectDir.existsSync()) {
        result.error = ErrorMessage(message: '导出失败，该工程不存在~');
        return result;
      }
      var runResult = await Process.run(
          '/bin/sh', ['compress_project.sh', projectDirPath, projectName],
          workingDirectory: _toolDir());
      if (runResult.exitCode != 0) {
        print('${runResult.stdout}');
        print('${runResult.stderr}');
        result.error = ErrorMessage(message: '导出失败，请稍后再试~');
        return result;
      }
      var url =
          path.join(resourceHost, 'userProject', user, '$projectName.zip');
      result.result = url;
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during exportProject on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<GetQrCodeResponse> getQrCode(String user, String projectName) async {
    try {
      GetQrCodeResponse result = GetQrCodeResponse();
      var projectDirPath = path.join(_userProjectDir(), user, projectName);
      var projectDir = Directory(projectDirPath);
      if (!projectDir.existsSync()) {
        result.error = ErrorMessage(message: '生成二维码失败，该工程不存在~');
        return result;
      }
      var fairPatchFile =
          File(path.join(projectDirPath, 'build/fair/fair_patch.zip'));
      if (fairPatchFile.existsSync()) {
        var url = path.join(resourceHost, 'userProject', user, projectName,
            'build/fair/fair_patch.zip');
        result.result = jsonEncode({'url': url});
      } else {
        result.error = ErrorMessage(message: '生成二维码失败，请先切换到Fair DSL进行编译~');
        return result;
      }
      return result;
    } catch (e, st) {
      if (e is! BadRequest) {
        log.severe('Error during getQrCode on "$user"', e, st);
      }
      rethrow;
    }
  }

  Future<GetProjectPagesResponse> getProjectsPages(
      String user, String projectName) async {
    //异步执行就行，不用耽误接口返回数据
    warmup(user, projectName);

    try {
      GetProjectPagesResponse result = GetProjectPagesResponse();
      String projectPagePath =
          path.join(_userProjectDir(), user, projectName, 'lib', 'page');
      var projectPageDir = Directory(projectPagePath);
      if (!projectPageDir.existsSync()) {
        result.error = ErrorMessage(message: '获取目录失败，该工程不存在~');
        return result;
      }
      projectPageDir.listSync(recursive: false).forEach((element) {
        if (element is Directory) {
          var path = element.path;
          var dir = path.replaceAll(projectPagePath, '').substring(1);
          var projectPageInfo = ProjectPageInfo();
          projectPageInfo.dir = dir;
          element.listSync(recursive: false).forEach((file) {
            if (extension(file.path) == '.dart') {
              var baseName = basename(file.path);
              projectPageInfo.files
                  .add(FileInfo(name: baseName, path: file.path));
            }
          });
          if (projectPageInfo.files.isNotEmpty) {
            result.result.add(projectPageInfo);
          }
        }
      });
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<CommonResponse> copyProjectPage(
      String user, String projectName, String dir, String pagePath) async {
    try {
      CommonResponse result = CommonResponse();
      String projectPagePath =
          path.join(_userProjectDir(), user, projectName, 'lib', 'page', dir);
      var pageDir = Directory(projectPagePath);
      if (!pageDir.existsSync()) {
        result.error = ErrorMessage(message: '页面不存在，复制失败');
        return result;
      }
      if (pagePath.isEmpty) {
        /// copy dir
        var copyDirPath = '';
        var copyDir = '';
        for (var i = 1; i <= 10; i++) {
          var newCopyDir = '${dir}_copy$i';
          var newDirPath = path.join(pageDir.parent.path, newCopyDir);
          if (!Directory(newDirPath).existsSync()) {
            copyDirPath = newDirPath;
            copyDir = newCopyDir;
            break;
          }
        }
        if (copyDirPath.isEmpty) {
          result.error = ErrorMessage(message: '复制失败，最多复制10次哦');
          return result;
        }
        await copyPath(projectPagePath, copyDirPath);
        result.result = copyDir;
      } else {
        /// copy file
        var pageFile = File(path.join(projectPagePath, pagePath));
        if (!pageFile.existsSync()) {
          result.error = ErrorMessage(message: '文件不存在，复制失败');
          return result;
        }
        var copyFilePath = '';
        var extension = path.extension(pagePath);
        var basename = path.withoutExtension(pagePath);
        for (var i = 1; i <= 10; i++) {
          var newFilePath =
              path.join(projectPagePath, '${basename}_copy$i$extension');
          if (!File(newFilePath).existsSync()) {
            copyFilePath = newFilePath;
            break;
          }
        }
        if (copyFilePath.isEmpty) {
          result.error = ErrorMessage(message: '复制失败，最多复制10次哦');
          return result;
        }
        pageFile.copySync(copyFilePath);
      }
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<DeleteProjectPageResponse> deleteProjectPage(
      String projectName, String pageName, String userId) async {
    try {
      DeleteProjectPageResponse result = DeleteProjectPageResponse();
      String projectPagePath = path.join(
          _userProjectDir(), userId, projectName, 'lib', 'page', pageName);
      if (FileSystemEntity.isFileSync(projectPagePath)) {
        var pageFile = File(projectPagePath);
        if (pageFile.existsSync()) {
          pageFile.deleteSync();
          if (pageFile.parent.listSync().isEmpty) {
            pageFile.parent.deleteSync();
          }
        } else {
          result.error = ErrorMessage(message: '页面不存在，删除失败');
        }
        return result;
      }
      var pageDir = Directory(projectPagePath);
      if (pageDir.existsSync()) {
        pageDir.deleteSync(recursive: true);
        return result;
      } else {
        result.error = ErrorMessage(message: '页面不存在，删除失败');
        return result;
      }
    } catch (e, _) {
      rethrow;
    }
  }

  //获取自定义组件
  Future<GetCustomComponentsResponse> getCustomComponents(
      String projectName, String userId) async {
    GetCustomComponentsResponse response = GetCustomComponentsResponse();
    String itemsPath = path.join(
        _userProjectDir(), userId, projectName, "lib", "code", 'component');
    var itemsDir = Directory(itemsPath);
    var previewPicDir = path.join(
        _userProjectDir(), userId, projectName, "previewPic", 'component');
    if (itemsDir.existsSync()) {
      //文件夹存在，遍历
      //从目标文件夹下拿到所有子文件夹
      itemsDir.listSync().forEach((element) {
        String elementPath = element.path;
        String name =
            elementPath.replaceAll(itemsPath + "/", "").replaceAll(".dart", "");

        var basename = basenameWithoutExtension(elementPath);
        var screenshotFile = File(path.join(previewPicDir, '$basename.png'));
        var screenshotUrl = '';
        if (screenshotFile.existsSync()) {
          screenshotUrl = path.join(resourceHost, 'userProject', userId,
              projectName, "previewPic", 'component', '$basename.png');
        }
        response.result.add(CustomComponentInfo(
            name: name,
            path: elementPath,
            fairWidgetCode: '',
            screenshot: screenshotUrl));
      });
    }
    return response;
  }

  //获取自定义Action
  Future<GetCustomActionsResponse> getCustomActions(
      String projectName, String userId) async {
    GetCustomActionsResponse response = GetCustomActionsResponse();
    String itemsPath = path.join(
        _userProjectDir(), userId, projectName, "lib", "code", 'action');
    var itemsDir = Directory(itemsPath);
    if (itemsDir.existsSync()) {
      //文件夹存在，遍历
      //从目标文件夹下拿到所有子文件夹
      itemsDir.listSync().forEach((element) {
        String elementPath = element.path;
        String name =
            elementPath.replaceAll(itemsPath + "/", "").replaceAll(".dart", "");

        var basename = basenameWithoutExtension(elementPath);
        response.result.add(CustomActionInfo(
          name: name,
          path: elementPath,
        ));
      });
    }
    return response;
  }

  //删除自定义代码
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

  //获取依赖文件路径
  Future<DependencyPathResponse> getDependencyFilePath(
      String userId, String projectName) async {
    DependencyPathResponse response = DependencyPathResponse();
    String codePath =
        path.join(_userProjectDir(), userId, projectName, "pubspec.yaml");
    response.filePath = File(codePath).readAsStringSync();
    return response;
  }

  //更改依赖
  Future<ChangeDependencyResponse> changeDependency(String type, String name,
      String version, String userId, String projectName) async {
    ChangeDependencyResponse response = ChangeDependencyResponse();
    var filePath =
        path.join(_userProjectDir(), userId, projectName, "pubspec.yaml");
    switch (type) {
      case "1":
        //新增依赖
        await ChangeDependencyUtil.addDependency(filePath, name, version);
        break;
      case "2":
        //删除依赖
        await ChangeDependencyUtil.deleteDependency(filePath, name, version);
        break;
      case "3":
        //编辑依赖
        await ChangeDependencyUtil.editDependency(filePath, name, version);
        break;
    }
    return response;
  }

  Future<DoPubGetResponse> doPubGet(String userId, String projectName) async {
    var projectPath = path.join(_userProjectDir(), userId, projectName);
    DoPubGetResponse response = DoPubGetResponse();
    var runResult = await Process.run(_sdk.flutterToolPath, ['pub', 'get'],
        workingDirectory: projectPath);
    if (runResult.exitCode != 0) {
      response.error = ErrorMessage(
          message:
              'Pub get failed. \n${runResult.stdout} \n${runResult.stderr}');
    }
    return response;
  }



  Future<GetTemplatePagesResponse> getTemplatePages(
      String projectName, String userId) async {
    try {
      GetTemplatePagesResponse result = GetTemplatePagesResponse();
      var templatePageDir = Directory(_templatePageDir());
      if (!templatePageDir.existsSync()) {
        templatePageDir.createSync(recursive: true);
        return result;
      }
      var pageConfigFile =
          File(path.join(_templatePageDir(), 'page_config.json'));
      var pageTemplateConfig = PageTemplateConfig.fromJson(
          jsonDecode(pageConfigFile.readAsStringSync()));

      pageTemplateConfig.templates?.forEach((element) {
        var dir =
            Directory(path.join(path.join(_templatePageDir(), element.path)));
        if (dir.existsSync()) {
          var pageScreenshot = '';
          if ((element.screenshot?.isNotEmpty ?? false) &&
              (element.screenshot!.startsWith('https://') ||
                  element.screenshot!.startsWith('http://'))) {
            pageScreenshot = element.screenshot!;
          } else {
            var screenshotFile = File(path.join(dir.path, element.screenshot));
            if (screenshotFile.existsSync()) {
              pageScreenshot = path.join(resourceHost, 'template', 'page',
                  element.path, element.screenshot);
            }
          }
          result.result.add(TemplatePageInfo(
              pageName: element.path,
              pagePath: element.path,
              screenshot: pageScreenshot));
        }
      });
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<CreateProjectPageResponse> createProjectPage(String projectName,
      String pagePath, String pageName, String userId) async {
    try {
      CreateProjectPageResponse result = CreateProjectPageResponse();
      String projectPagePath = path.join(
          _userProjectDir(), userId, projectName, 'lib', 'page', pagePath);
      var pageDir = Directory(projectPagePath);
      var pageFile = File(path.join(projectPagePath, '$pageName.dart'));
      if (pageFile.existsSync()) {
        result.error = ErrorMessage(message: '创建失败，该页面已存在~');
        return result;
      }
      if (!pageDir.existsSync()) {
        pageDir.createSync(recursive: true);
      }
      pageFile.createSync(recursive: true);
      pageFile.writeAsStringSync(
          PageCreateUtil.createPageContent(pageName, projectName));
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<CreateTemplatePageResponse> createTemplatePage(
      String projectName,
      String pagePath,
      String pageName,
      String userId,
      String templatePage) async {
    try {
      CreateTemplatePageResponse result = CreateTemplatePageResponse();
      String pageDirPath = path.join(
          _userProjectDir(), userId, projectName, 'lib', 'page', pagePath);
      var pageDir = Directory(pageDirPath);
      if (pageDir.existsSync()) {
        result.error = ErrorMessage(message: '创建失败，该页面路径已存在~');
        return result;
      }

      /// 页面模板
      var templatePageDirPath = path.join(_templatePageDir(), templatePage);
      var templatePageDir = Directory(templatePageDirPath);
      if (!templatePageDir.existsSync()) {
        result.error = ErrorMessage(message: '创建失败，页面模板不存在~');
        return result;
      }

      /// 临时文件夹
      var tempPrefix = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      var tempDir = templatePageDir.parent.createTempSync(tempPrefix);
      var tempDirPath = tempDir.path;

      /// 拷贝到临时文件夹
      await for (final file in templatePageDir.list(recursive: true)) {
        final relativePath = path
            .relative(file.path, from: templatePageDirPath)
            .replaceFirst(templatePage, pagePath);
        final copyTo = path.join(tempDirPath, relativePath);
        if (file is Directory) {
          await Directory(copyTo).create(recursive: true);
        } else if (file is File) {
          if (path.extension(file.path) == '.dart') {
            await File(file.path).copy(copyTo);
          }
        }
      }

      /// 修改类名
      var runResult = await Process.run(
          '/bin/sh',
          [
            'page_rename.sh',
            pageName,
            '@@PageName@@',
            projectName,
            '@@ProjectName@@',
            tempDirPath
          ],
          workingDirectory: _toolDir());
      if (runResult.exitCode != 0) {
        result.error = ErrorMessage(
            message:
                'Rename page failed. \n${runResult.stdout} \n${runResult.stderr}');
        return result;
      }
      await copyPath(tempDirPath, pageDirPath);
      tempDir.deleteSync(recursive: true);
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<void> warmup(String user, String projectName) async {
    var projectDirPath = path.join(_userProjectDir(), user, projectName);
    final key = user + projectName;
    final flutterWrapper = gFlutterAnalysisWrapper[key] ??
        FlutterAnalysisServerWrapper(
            dartSdkPath: _sdk.dartSdkPath, userProjectPath: projectDirPath);
    gFlutterAnalysisWrapper[key] = flutterWrapper;
    await flutterWrapper.warmup();
    unawaited(flutterWrapper.onExit.then((int code) {
      log.severe(
          'AnalysisServer:${_sdk.dartSdkPath.hashCode} exited, code: $code');
    }));
  }

  Future<GetPageResponse> getPage(
      String userId, String projectName, String pagePath) async {
    try {
      GetPageResponse result = GetPageResponse();
      String projectPagePath = path.join(
          _userProjectDir(), userId, projectName, 'lib', 'page', pagePath);
      result.result = await File(projectPagePath).readAsString();
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<GetFairDslListResponse> getFairDslList(
      String userId, String projectName) async {
    try {
      GetFairDslListResponse result = GetFairDslListResponse();
      final projectDir = path.join(_userProjectDir(), userId, projectName);
      final fairDslDirPath = path.join(projectDir, 'assets', 'fair');
      var fairDslDir = Directory(fairDslDirPath);
      if (!fairDslDir.existsSync()) {
        result.error = ErrorMessage(message: '没有找到Fair DSL~');
        return result;
      }
      fairDslDir.listSync().forEach((element) {
        String path = element.path;
        if (path.endsWith('.json')) {
          var jsFilePath = setExtension(path, '.js');
          var jsPath = '';
          if (File(jsFilePath).existsSync()) {
            jsPath = basename(jsFilePath);
          }
          result.result
              .add(FairDslInfo(jsonPath: basename(path), jsPath: jsPath));
        }
      });
      return result;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<GetFairDslResponse> getFairDsl(String userId, String projectName,
      String pageName, String jsonPath, String jsPath) async {
    try {
      GetFairDslResponse result = GetFairDslResponse();
      final projectDir = path.join(_userProjectDir(), userId, projectName);
      final fairDslDirPath = path.join(projectDir, 'assets', 'fair');
      if (jsonPath.isNotEmpty) {
        final jsonFile = File(path.join(fairDslDirPath, jsonPath));
        if (jsonFile.existsSync()) {
          result.json = await jsonFile.readAsString();
        }
      }

      if (jsPath.isNotEmpty) {
        final jsFile = File(path.join(fairDslDirPath, jsPath));
        if (jsFile.existsSync()) {
          result.js = await jsFile.readAsString();
        }
      }
      return result;
    } catch (e, _) {
      rethrow;
    }
  }
}
