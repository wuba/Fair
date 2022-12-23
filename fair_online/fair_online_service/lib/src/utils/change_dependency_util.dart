import 'dart:io';

class ChangeDependencyUtil {

  static Future<void> editDependency(String filePath, String name, String version) async {
    File file = File(filePath);
    var result = StringBuffer();
    file.readAsLinesSync().forEach((line) {
      if(line.startsWith("  $name:")) {
        //这里是要编辑的
        result.writeln("  $name: $version");
      } else {
        result.writeln(line);
      }
    });
    file.writeAsStringSync(result.toString());
  }

  static Future<void> addDependency(String filePath, String name, String version) async {
    File file = File(filePath);
    var result = StringBuffer();
    file.readAsLinesSync().forEach((line) {
      if(line.startsWith("dev_dependencies:")) {
        result.writeln("  $name: $version");
      }
      result.writeln(line);
    });
    file.writeAsStringSync(result.toString());
  }

  static Future<void> deleteDependency(String filePath, String name, String version) async {
    File file = File(filePath);
    var result = StringBuffer();
    file.readAsLinesSync().forEach((line) {
      if(line.startsWith("  $name:")) {
      } else {
        result.writeln(line);
      }
    });
    file.writeAsStringSync(result.toString());
  }



}