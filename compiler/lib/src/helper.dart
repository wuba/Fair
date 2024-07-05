/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:fair_compiler/src/fair_asset.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:process/process.dart';
import 'package:fair_dart2dsl/fairc.dart' as dart2dsl;

mixin FlatCompiler {
  final command = 'flatc';

  File? _fbs;

  Future<R> compile(String jsonPath) async {
    var content = '';
    var error = '';
    if (LocalProcessManager().canRun(command)) {
      _fbs ??= await File(
          path.join('.dart_tool', 'build', 'fairc', 'fair_bundle.fbs'))
          .create(recursive: true);

      final result = Process.runSync(command, [
        '-o',
        File(jsonPath).parent.absolute.path,
        '-b',
        _fbs!.absolute.path,
        jsonPath
      ]);
      if (result.exitCode != 0) {
        print('${result.stdout}');
        print('${result.stderr}');
      }
      var relativeIndex = jsonPath.indexOf('/build');
      content =
          jsonPath.substring(relativeIndex + 1).replaceAll('.json', '.bin');
    } else {
      print(
          '[Fair] Since $command is not installed, the bin of bundle will not be generated!');
      print(
          'You may install flatc from : http://google.github.io/flatbuffers/flatbuffers_guide_building.html');
    }
    return content.isNotEmpty
        ? R.success(content, '$command execute success')
        : R.fail(error);
  }
}

mixin FairCompiler {
  static File? _fair;
  final _startTag = '#####################fairc output begin#################';
  final _endTag = '#####################fairc output end#################';
  final command = 'dart';
  final branch = 'main';

  /// Copy fair_bundle.fbs to the current project.
  Future<File> syncFbs(BuildStep buildStep) async {
    final dir = path.join('.dart_tool', 'build', 'fairc');
    Directory(dir).createSync(recursive: true);
    var fbs =
    await File(path.join('.dart_tool', 'build', 'fairc', 'fair_bundle.fbs'))
        .create(recursive: true);
    await fbs.writeAsBytes(await buildStep.readAsBytes(
        FairAssetId.resolve('package:fair_compiler/src/fair_bundle.fbs')));

    return fbs;
  }

  /// Create a temporary file.
  /// The file name is the hash value of the current date and time.
  /// The file is located in the directory .dart_tool/build/fairc.
  Future<File> get temp async {
    return File(path.join('.dart_tool', 'build', 'fairc',
        DateTime.now().toString().hashCode.toString()))
        .create(recursive: true);
  }

  Future<R> compile(BuildStep buildStep, List<String> arguments) async {
    var content = '';
    var error = '';
    if (LocalProcessManager().canRun(command)) {
      await syncFbs(buildStep);
      try {
        final output = await dart2dsl.dart2dsl(arguments);
        if (output != null && output is String && output.isNotEmpty) {
          final startIndex = output.indexOf(_startTag);
          final endIndex = output.indexOf(_endTag);
          if (startIndex != -1 && endIndex != -1) {
            content = output.substring(startIndex + _startTag.length, endIndex);
          }
        }
      } catch (e, s) {
        var errorLog = await File(path.join('build', 'fair', 'log',
                '${DateFormat('yyyy-MM-dd_HH:mm:sss').format(DateTime.now())}.txt'))
            .create(recursive: true);
        var f = await errorLog.open(mode: FileMode.append);
        await f
            .writeString('error:\n${e.toString()}\nstack:\n${s.toString()}\n');
        error = 'No content is generated: ${errorLog.path}';
        print('[Fair] $error');
      }

    } else {
      error = '[Fair] Please checkout the flutter & dart version';
      print(error);
    }
    return content.isNotEmpty
        ? R.success(content, 'compile success')
        : R.fail(error);
  }
}

class R {
  final bool success;
  final String? data;
  final String message;

  R._(this.success, this.data, this.message);

  factory R.success(String data, String message) {
    return R._(true, data, message);
  }

  factory R.fail(String message) {
    return R._(false, null, message);
  }
}