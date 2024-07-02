/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:fair_dart2dsl/src/helper.dart';
import 'package:path/path.dart' as path;

import '../fairdsl/fair_ast_gen.dart';
import '../fairdsl/fair_dsl_gen.dart';

Future<String> parseFile(String filePath, {String? sourcePath}) async {
  var ast = await generateAstMap(filePath, sourcePath: sourcePath);
  return ast != null ? fairDsl(ast) : 'Failed parse ast';
}

Future<String> parseDir(String dir) async {
  var collection = AnalysisContextCollection(includedPaths: <String>[dir]);
  for (final context in collection.contexts) {
    for (final file in context.contextRoot.analyzedFiles()) {
      if (file.endsWith('.dart')) {
        var start = DateTime.now().millisecondsSinceEpoch;
        var resolvedUnitResult = await context.currentSession
            .getResolvedUnit(file) as ResolvedUnitResult;
        var ast = await generateAstMapByCompilation(
            resolvedUnitResult.unit, file,
            sourcePath: file.replaceFirst(dir, '').replaceFirst('/', ''));
        var result = fairDsl(ast);
        var moduleNameKey = path.withoutExtension(file);
        var moduleNameValue = ModuleNameHelper().modules[moduleNameKey];
        var destFile = File(path.join(
            'build',
            'fair',
            file
                .replaceFirst(dir, '')
                .replaceFirst('/', '')
                .replaceAll('lib', moduleNameValue)
                .replaceAll('/', '_')
                .replaceAll('\\', '_')
                .replaceFirst('.dart', '.fair.json')))
          ..createSync(recursive: true);
        await destFile.writeAsString(result);
        var end = DateTime.now().millisecondsSinceEpoch;
        stdout.writeln('[Fair] dart2Dsl $file, time: ${end - start} ms');
      }
    }
  }
  return 'Succeed parse ast';
}
