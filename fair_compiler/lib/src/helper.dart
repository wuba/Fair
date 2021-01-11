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
      //error = '[Fair] $command is not installed, FlatBuffer is not generated';
      //print(error);
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

  // Flutter 1.12.13.hotfix.9 Dart 2.7.2
  // Flutter 1.17.3           Dart 2.8.4
  // Flutter 1.20.4           Dart 2.9.2
  // Flutter 1.22.4           Dart 2.10.2
  bool supported(String v) {
    switch (v) {
      case '2.7.2':
      case '2.8.4':
      case '2.9.2':
      case '2.10.4':
        return true;
      default:
        return false;
    }
  }

  Future<File> _bin(BuildStep buildStep) async {
    var v = File(path.join(
            path.dirname(path.dirname(Platform.resolvedExecutable)), 'version'))
        .readAsStringSync()
        .trimRight();
    if (!supported(v)) {
      return Future.value();
    }
    if (_fair == null || !_fair.existsSync()) {
      final asset = AssetId.resolve('package:fair_compiler/src/fairc');
      final bytes = await buildStep.readAsBytes(asset);
      var archive = TarDecoder().decodeBytes(GZipDecoder().decodeBytes(bytes));
      var matched = archive.where((element) => element.name.endsWith(v));
      List<int> rawBytes;
      if (matched != null && matched.isNotEmpty) {
        rawBytes = matched.first.content;
      } else {
        stderr.writeln('not supported flutter version');
      }
      if (rawBytes != null) {
        final digest = md5.convert(rawBytes).toString();
        final dir = path.join('.dart_tool', 'build', 'fairc');
        Directory(dir).createSync(recursive: true);
        final file = File(path.join(dir, digest));
        if (!file.existsSync()) {
          file.writeAsBytesSync(rawBytes);
        }
        _fair = file;
        var fbs = await File(
                path.join('.dart_tool', 'build', 'fairc', 'fair_bundle.fbs'))
            .create(recursive: true);
        await fbs.writeAsBytes(await buildStep.readAsBytes(
            AssetId.resolve('package:fair_compiler/src/fair_bundle.fbs')));
      }
    }
    return _fair;
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
      final fair = (await _bin(buildStep))?.absolute?.path;
      if (fair != null) {
        final result = Process.runSync(command, [fair, ...arguments]);
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
                  '${DateFormat('yyyy-MM-dd HH:mm:sss').format(DateTime.now())}.txt'))
              .create(recursive: true);
          var f = await errorLog.open(mode: FileMode.append);
          await f.writeString(output);
          await f.writeString(result.stderr);
          error = 'No content is generated: ${errorLog.path}';
          print('[Fair] $error');
        }
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
