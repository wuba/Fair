// ignore_for_file: avoid_print

import 'dart:io';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

String processRun({
  required String executable,
  required String arguments,
  bool runInShell = true,
  String? workingDirectory,
}) {
  final ProcessResult result = Process.runSync(
    executable,
    arguments.split(' '),
    runInShell: runInShell,
    workingDirectory: workingDirectory,
  );
  print(executable + ' ' + arguments);
  if (result.exitCode != 0) {
    print('${result.stdout}\n');
    // print(ansi.red.wrap('${result.stderr}'));

    //throw Exception(result.stderr);
  }
  print('${result.stdout}\n');
  return result.stdout;
}

void copyAndPackageGet({
  required Directory projectDirectory,
  required String packageName,
  required String copyForm,
}) {
  final destination = Directory(
    path.join(
      projectDirectory.path,
      '.dart_tool',
      packageName,
    ),
  );
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }
  Directory(copyForm).copyTo(
    destination,
    ignoreDirList: <String>[
      'example',
      'test',
    ],
  );
  // processRun(
  //     executable: 'cp',
  //     arguments: '-r $copyForm ${path.join(
  //       projectDirectory.path,
  //       '.dart_tool',
  //       packageName,
  //     )}');

  processRun(
    executable: 'flutter',
    arguments: 'packages get ${destination.path}',
  );
}

Directory getProjectDirectory({bool pubGet = true}) {
  Directory projectDirectory = Directory.current;
  String projectName = 'example';
  while (!projectDirectory.path.endsWith(projectName)) {
    projectDirectory = projectDirectory.parent;
  }
  if (pubGet) {
    processRun(
      executable: 'flutter',
      arguments: 'clean ${projectDirectory.path}',
    );
    processRun(
      executable: 'flutter',
      arguments: 'packages get ${projectDirectory.path}',
    );
  }

  return projectDirectory;
}

extension DirectoryHelper on Directory {
  /// Recursively copies a directory + subdirectories into a target directory.
  /// Similar to Copy-Item in PowerShell.
  void copyTo(
    final Directory destination, {
    final List<String> ignoreDirList = const [],
    final List<String> ignoreFileList = const [],
  }) =>
      listSync().forEach((final entity) {
        if (entity is Directory) {
          if (ignoreDirList.contains(path.basename(entity.path))) {
            return;
          }
          final newDirectory = Directory(
            path.join(destination.absolute.path, path.basename(entity.path)),
          )..createSync();
          entity.absolute.copyTo(
            newDirectory,
            ignoreDirList: ignoreDirList,
            ignoreFileList: ignoreFileList,
          );
        } else if (entity is File) {
          if (ignoreFileList.contains(path.basename(entity.path))) {
            return;
          }
          entity.copySync(
            path.join(destination.path, path.basename(entity.path)),
          );
        }
      });
}

void dartFix() {
  processRun(executable: 'dart', arguments: 'fix --apply');
}

Future<void> getIncludedPaths({
  required String filePath,
  required List<String> includedPaths,
  required int depth,
  required Set<String> imports,
  required String packageName,
  required String packageRoot,
  required PackageConfig packageConfig,
  required Directory projectDirectory,
}) async {
  if (depth == 0) {
    return;
  }

  includedPaths.add(filePath);

  final result = parseFile(
    path: filePath,
    featureSet: FeatureSet.latestLanguageVersion(),
  );

  for (var child in result.unit.directives) {
    if (child is NamespaceDirective) {
      var uri = child.uri.toString();
      // 去掉引号
      uri = uri.substring(1, uri.length - 1);
      var isDartSdk = uri.startsWith('dart:');
      if (child is ExportDirective) {
        if (uri.startsWith('package:')) {
          var resolve = packageConfig.resolve(Uri.parse(uri));
          var resolvePackage =
              packageConfig[Uri.parse(uri).path.split('/').first];
          if (resolvePackage != null && resolve != null) {
            if (!resolve.toString().contains('.dart_tool')) {
              await resolveCopyPackage(
                projectDirectory,
                resolvePackage,
                depth - 1,
                includedPaths,
                resolve,
                imports,
              );
            } else {
              await getIncludedPaths(
                depth: depth - 1,
                includedPaths: includedPaths,
                imports: imports,
                filePath: resolve.toFilePath(windows: Platform.isWindows),
                packageName: resolvePackage.name,
                packageRoot:
                    resolvePackage.root.toFilePath(windows: Platform.isWindows),
                packageConfig: packageConfig,
                projectDirectory: projectDirectory,
              );
            }
            imports.add('import \'$uri\';');
          }
        } else if (!isDartSdk) {
          var fullName =
              path.normalize(path.absolute(path.dirname(filePath), uri));
          await getIncludedPaths(
            depth: depth - 1,
            includedPaths: includedPaths,
            imports: imports,
            filePath: fullName,
            packageName: packageName,
            packageRoot: packageRoot,
            packageConfig: packageConfig,
            projectDirectory: projectDirectory,
          );
        }
      } else if (child is ImportDirective) {
        if (uri.startsWith('package:') || isDartSdk) {
          imports.add(child.toString());
        } else {
          var fullName =
              path.normalize(path.absolute(path.dirname(filePath), uri));

          fullName = fullName
              .substring(
                  fullName.indexOf('.dart_tool') + '.dart_tool'.length + 1)
              .replaceAll(path.separator, '/');
          fullName = fullName.replaceAll('$packageName/lib', packageName);
          imports.add('import \'package:$fullName\';');
        }
      }
    } else if (child is PartDirective) {
      var uri = child.uri.toString();
      // 去掉引号
      uri = uri.substring(1, uri.length - 1);
      var isDartSdk = uri.startsWith('dart:');
      if (!isDartSdk && !uri.startsWith('package:')) {
        var fullName =
            path.normalize(path.absolute(path.dirname(filePath), uri));
        await getIncludedPaths(
          depth: depth,
          includedPaths: includedPaths,
          imports: imports,
          filePath: fullName,
          packageName: packageName,
          packageRoot: packageRoot,
          packageConfig: packageConfig,
          projectDirectory: projectDirectory,
        );
      }
    }
  }
}

Future<void> resolveCopyPackage(
  Directory projectDirectory,
  Package resolvePackage,
  int depth,
  List<String> includedPaths,
  Uri resolve,
  Set<String> imports,
) async {
  if (depth == 0) {
    return;
  }

  var copyPackageRoot = path.join(
    projectDirectory.path,
    '.dart_tool',
    resolvePackage.name,
  );
  Directory directory = Directory(copyPackageRoot);
  if (!directory.existsSync()) {
    copyAndPackageGet(
      projectDirectory: projectDirectory,
      packageName: resolvePackage.name,
      copyForm: resolvePackage.root.toFilePath(windows: Platform.isWindows),
    );
  }

  var copyPackageConfig = await findPackageConfig(Directory(copyPackageRoot));
  await getIncludedPaths(
    depth: depth,
    includedPaths: includedPaths,
    imports: imports,
    filePath: path.join(
      copyPackageRoot,
      resolve.toFilePath(windows: Platform.isWindows).replaceAll(
          resolvePackage.root.toFilePath(windows: Platform.isWindows), ''),
    ),
    packageName: resolvePackage.name,
    packageRoot: copyPackageRoot,
    packageConfig: copyPackageConfig!,
    projectDirectory: projectDirectory,
  );
}
