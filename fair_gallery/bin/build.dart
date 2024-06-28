// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:dart_style/dart_style.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'util/utils.dart';
import 'package:analyzer/dart/ast/visitor.dart';

DartFormatter _dartFormatter = DartFormatter();
// Map<String, String> _fixes = <String, String>{

// };
void main() async {
  Directory projectDirectory = getProjectDirectory(pubGet: false);

  var bunldes = <String>[];

  final result = parseFile(
    path: path.join(projectDirectory.path, 'lib', 'assets.dart'),
    featureSet: FeatureSet.latestLanguageVersion(),
  );
  var assetsArray =
      (result.unit.childEntities.elementAt(1) as TopLevelVariableDeclaration)
          .childEntities
          .elementAt(0)
          .toString();
  assetsArray = assetsArray.substring(
      assetsArray.indexOf('[') + 1, assetsArray.indexOf(']'));
  var assets = assetsArray
      .split(',')
      .map((e) => e.trim())
      .where((element) =>
          element.endsWith('_fair_bin') || element.endsWith('_fair_json'))
      .toList();

  final result1 = parseFile(
    path: path.join(projectDirectory.path, 'lib', 'fair_gallery_route.dart'),
    featureSet: FeatureSet.latestLanguageVersion(),
  );

  List<SwitchCase> scList = <SwitchCase>[];
  result1.unit.visitChildren(_SwitchCaseGeneralizingAstVisitor(scList));

  for (var sc in scList) {
    List<MapLiteralEntry> mapLiteralEntryList = <MapLiteralEntry>[];
    for (var statement in sc.statements) {
      statement.visitChildren(
          _MapLiteralEntryGeneralizingAstVisitor(mapLiteralEntryList));
    }
    if (mapLiteralEntryList.isNotEmpty) {
      for (var mapLiteralEntry in mapLiteralEntryList) {
        var key = mapLiteralEntry.key.toString();
        var value = mapLiteralEntry.value.toString();
        if (key == 'ExtendedFairWidget.tag' && value == 'true') {
          for (var map in mapLiteralEntryList) {
            if (map != mapLiteralEntry &&
                map.key.toString() == '\'ffRouteFileImport\'') {
              var fileImport = map.value.toString();
              fileImport = fileImport.substring(1, fileImport.length - 1);

              var uriPath = Uri.parse(fileImport).path;
              uriPath = path.withoutExtension(uriPath);
              var pathList = uriPath.split('/');
              pathList.removeAt(0);
              var formatPath = pathList.join('_');

              var bin = formatPath + '_fair_bin';
              var json = formatPath + '_fair_json';

              var asset = assets.where((element) => element.endsWith(bin));
              if (asset.isEmpty) {
                asset = assets.where((element) => element.endsWith(json));
              }

              assert(asset.length == 1);
              var pageName = sc.expression.toString();
              var comment = '';
              if (asset.first.endsWith('json')) {
                // json 嵌套层数过多，会导致 flatbuffers 生成 bin 文件失败(https://github.com/google/flatbuffers/issues/7895)
                comment =
                    '''\n  // json 嵌套层数过多，会导致 flatbuffers 生成 bin 文件失败(https://github.com/google/flatbuffers/issues/7895)\n''';
              }
              bunldes.add('$comment$pageName:${asset.first}');
            }
          }

          break;
        }
      }
    }
  }

  File file = File(path.join(
    projectDirectory.path,
    'lib',
    'src',
    'utils',
    'asset_bunldes.dart',
  ));

  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }

  file.writeAsStringSync(
      _dartFormatter.format(_template.replaceAll('{0}', bunldes.join(','))));

  // final File file = File(path.join(
  //   projectDirectory.path,
  //   'lib',
  //   'src',
  //   'generated.fair.dart',
  // ));
  // if (file.existsSync()) {
  //   file.deleteSync();
  // }

  // // flutter pub run build_runner build --delete-conflicting-outputs

  // processRun(
  //   executable: 'flutter',
  //   arguments: 'pub run build_runner build --delete-conflicting-outputs',
  //   workingDirectory: projectDirectory.path,
  // );

  // if (file.existsSync()) {
  //   String content = file.readAsStringSync();
  //   for (final String key in _fixes.keys) {
  //     content = content.replaceAll(key, _fixes[key]!);
  //   }
  //   file.writeAsStringSync(_dartFormatter.format(content));
  // }

  // // cp -r build/fair assets/

  // // processRun(
  // //   executable: 'cp',
  // //   arguments: '-r build/fair assets/',
  // //   workingDirectory: projectDirectory.path,
  // // );

  // processRun(
  //   executable: 'rm',
  //   arguments: '-rf assets/fair',
  //   workingDirectory: projectDirectory.path,
  // );

  // processRun(
  //   executable: 'mkdir',
  //   arguments: 'assets/fair',
  //   workingDirectory: projectDirectory.path,
  // );

  // Directory buildFair = Directory(path.join('build', 'fair'));

  // for (var file in buildFair.listSync()) {
  //   var name = path.basename(file.path);
  //   if (file is File &&
  //       (name.endsWith('.js') ||
  //           name.endsWith('.bin') ||
  //           name.endsWith('.json'))) {
  //     // copy to assets/fair
  //     file.copySync(path.join(projectDirectory.path, 'assets', 'fair', name));
  //   }
  // }
}

void processRun({
  required String executable,
  required String arguments,
  bool runInShell = false,
  String? workingDirectory,
}) {
  final ProcessResult result = Process.runSync(
    executable,
    arguments.split(' '),
    runInShell: runInShell,
    workingDirectory: workingDirectory,
  );
  if (result.exitCode != 0) {
    print('${result.stdout}\n');
    // print(ansi.red.wrap('${result.stderr}'));

    //throw Exception(result.stderr);
  }
  print('${result.stdout}\n');
}

String _template = '''
// 由 fair_gallery/bin/build.dart 生成
import 'package:fair_gallery/assets.dart';

final Map<String, String> _bundles = <String, String>{
 {0}
};

extension FairBundleE on String {
  String? get fairBundle => _bundles[this];
}
''';

class _SwitchCaseGeneralizingAstVisitor extends GeneralizingAstVisitor<void> {
  _SwitchCaseGeneralizingAstVisitor(this.sc);
  final List<SwitchCase> sc;

  @override
  void visitSwitchCase(SwitchCase node) {
    // super.visitSwitchCase(node);
    sc.add(node);
  }
}

class _MapLiteralEntryGeneralizingAstVisitor
    extends GeneralizingAstVisitor<void> {
  // MapLiteralEntry
  _MapLiteralEntryGeneralizingAstVisitor(this.mapLiteralEntryList);
  final List<MapLiteralEntry> mapLiteralEntryList;

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    mapLiteralEntryList.add(node);
  }
}
