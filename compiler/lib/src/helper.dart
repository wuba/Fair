/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:build/build.dart';
import 'package:crypto/crypto.dart' show md5;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:process/process.dart';

mixin FlatCompiler {
  final command = 'flatc';

  File _fbs;

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
        _fbs.absolute.path,
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
  static File _fair;
  final _startTag = '#####################fairc output begin#################';
  final _endTag = '#####################fairc output end#################';
  final command = 'dart';
  final branch = 'main';

  Future<File> _syncFbs(BuildStep buildStep) async {
    final dir = path.join('.dart_tool', 'build', 'fairc');
    Directory(dir).createSync(recursive: true);
    var fbs =
        await File(path.join('.dart_tool', 'build', 'fairc', 'fair_bundle.fbs'))
            .create(recursive: true);
    await fbs.writeAsBytes(await buildStep.readAsBytes(
        AssetId.resolve('package:fair_compiler/src/fair_bundle.fbs')));
    return fbs;
  }

  Future<File> get temp async {
    return File(path.join('.dart_tool', 'build', 'fairc',
            DateTime.now().toString().hashCode.toString()))
        .create(recursive: true);
  }

  Future<R> compile(BuildStep buildStep, List<String> arguments) async {
    var content = '';
    var error = '';
    if (LocalProcessManager().canRun(command)) {
      // final fair = (await _bin(buildStep))?.absolute?.path;
      // 本地联调，可以先配置环境
      // final fair = '/Users/anjuke/haijun/Anjuke-Flutter/fairc/lib/fairc.dart';
      // if (fair != null) {
      // final result = Process.runSync(command, [fair, ...arguments]);
      await _syncFbs(buildStep);
      var whichCommand = await Process.run('which', ['dart']);
      var strBin = whichCommand.stdout.toString();
      var dirEndIndex = strBin.lastIndexOf(Platform.pathSeparator);
      var binDir = strBin.substring(0, dirEndIndex);

      var aotParentPath = Directory.current.parent.parent.path;
      var aotPathResult =
          await Process.run('find', [aotParentPath, "-name", 'fairc.aot']);
      var aotPathStr = aotPathResult.stdout.toString();
      var transferPath = aotPathStr.split('\r')[0].split('\n')[0];
      print('\u001b[33m [Fair Dart2JS] fairc.aot => ${transferPath} \u001b[0m');

      final result = Process.runSync(
          path.join('$binDir', 'dartaotruntime'), [transferPath, ...arguments]);
      print(result);

      var output = result.stdout.toString();
      if (output != null && output.isNotEmpty) {
        final startIndex = output.indexOf(_startTag);
        final endIndex = output.indexOf(_endTag);
        if (startIndex != -1 && endIndex != -1) {
          content = output.substring(startIndex + _startTag.length, endIndex);
        }
      }
      if (content.isEmpty) {
        var errorLog = await File(path.join('build', 'fair', 'log',
                '${DateFormat('yyyy-MM-dd_HH:mm:sss').format(DateTime.now())}.txt'))
            .create(recursive: true);
        var f = await errorLog.open(mode: FileMode.append);
        await f.writeString(output);
        await f.writeString(result.stderr);
        error = 'No content is generated: ${errorLog.path}';
        print('[Fair] $error');
      }
      // }
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
  final String data;
  final String message;

  R._(this.success, this.data, this.message);

  factory R.success(String data, String message) {
    return R._(true, data, message);
  }

  factory R.fail(String message) {
    return R._(false, null, message);
  }
}
