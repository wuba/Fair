// ignore_for_file: avoid_print

import 'dart:io';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import '../util/binding.dart';
import '../util/utils.dart';

// import 'package:flutter/widgets.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/semantics.dart';
// import 'package:flutter/animation.dart';
Set<String> _imports = <String>{
  'import \'package:extended_text_library/extended_text_library.dart\' as extended_text_library;',
  'import \'package:flutter/material.dart\';',
  'import \'package:extended_image/extended_image.dart\';',
};

String _codes = '''

''';

Map<String, String> _fixes = <String, String>{};

void main(List<String> args) async {
  Directory projectDirectory = getProjectDirectory();
  final File file = File(path.join(
      projectDirectory.path, 'bin', 'generated_module', 'binding.dart'));
  assert(file.existsSync());

  final result = parseFile(
    path: file.path,
    featureSet: FeatureSet.latestLanguageVersion(),
  );
  var packageConfig = await findPackageConfig(projectDirectory);
  if (packageConfig == null) {
    return;
  }
  List<String> includedPaths = <String>[];
  for (var child in result.unit.directives) {
    if (child is ImportDirective) {
      var uriString = child.uri.toString();
      // 去掉引号
      uriString = uriString.substring(1, uriString.length - 1);
      assert(uriString.startsWith('package:'));
      var resolve = packageConfig.resolve(Uri.parse(uriString));
      // 项目里面文件

      if (resolve!
          .toFilePath(windows: Platform.isWindows)
          .startsWith(projectDirectory.path)) {
        var resolve = packageConfig.resolve(Uri.parse(uriString));
        if (resolve != null) {
          final path = resolve.toFilePath(windows: Platform.isWindows);
          final result = parseFile(
            path: path,
            featureSet: FeatureSet.latestLanguageVersion(),
          );

          for (final child in result.unit.directives) {
            if (child is NamespaceDirective) {
              var uri = child.uri.toString();
              uri = uri.substring(1, uri.length - 1);
              if (child is ExportDirective) {
                final resolve = packageConfig.resolve(Uri.parse(uri));

                if (resolve != null) {
                  final path1 = resolve.toFilePath(windows: Platform.isWindows);
                  includedPaths.add(path1);
                }
              }
            }
          }

          includedPaths.add(path);
          _imports.add(child.toString());
        }
      }
    }
  }

  await createBindings(
    projectDirectory: projectDirectory,
    includedPaths: includedPaths,
    fileName: 'App',
    imports: _imports.join('\n'),
    componentSkips: {},
    codes: _codes,
    fixes: _fixes,
    functionDomainImports: _imports.join('\n'),
    functionDomainFixes: {
      'T Function(dynamic)': 'dynamic Function(dynamic)',
      'T Function(T, dynamic)': 'dynamic Function(dynamic, dynamic)',
      'Widget Function(BuildContext, T, int)':
          'Widget Function(BuildContext, dynamic, int)',
      'T Function()': 'dynamic Function()',
      'T Function(dynamic, dynamic)': 'dynamic Function(dynamic, dynamic)',
    },
    // FunctionType 的 fullElement
    // 有些是不会用的，特别是一些泛型
    functionDomainSkips: {},
  );
  // dartFix();
}
