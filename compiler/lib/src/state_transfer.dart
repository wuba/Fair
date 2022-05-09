import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

Future<void> stateTransfer() async {
  var jsonFile = File('fair_config.json');
  if (!jsonFile.existsSync()) {
    print('[fair] fair_config.json cannot be found');
    return;
  }
  print('[fair] fair_config file path=${jsonFile.path}');

  var configContent = jsonFile.readAsStringSync();
  var config = Map<String, dynamic>.from(jsonDecode(configContent));
  var toolPath = config['exportDir'];
  if (toolPath?.isNotEmpty != true) {
    print('[fair] please create "fair_config.json" in your root package '
        'and create set your tool_server path to the "exportDir" field');
    throw Exception('config error');
  }
  var toolProject = Directory(toolPath);
  var sourcePath = join('build', 'fair');
  if (!toolProject.existsSync()) {
    toolProject.createSync(recursive: true);
  }
  var sourceFile = Directory(sourcePath);

  print('[fair] Files is coping to targetPath...');
  await sourceFile.list(recursive: true).forEach((element) {
    //copy 文件夹中的所有文件
    var pathList = element.path.split(Platform.pathSeparator);
    var subList = pathList.sublist(pathList.indexOf('fair') + 1);
    var targetPath = '${toolProject.absolute.path}${Platform.pathSeparator}${joinAll(subList)}';
    var targetFile = File(targetPath);
    var sourceFile = File(element.path);
    //判断当前路径是否是文件
    if (sourceFile.existsSync() && !FileSystemEntity.isDirectorySync(sourceFile.path)) {
      if (!targetFile.parent.existsSync()) {
        targetFile.parent.createSync(recursive: true);
      }
      sourceFile.copySync(targetPath);
    }
  });
  print('[fair] files have bean copied');
}
