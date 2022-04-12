/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'dart:io';

import 'package:args/args.dart';

import 'src/bundle.dart' as dsl;
import 'src/error.dart';
import 'src/widget.dart' as binding;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('file', abbr: 'f')
    ..addOption('directory', abbr: 'd')
    ..addOption('output-directory', abbr: 'o')
    ..addOption('sdk-name', abbr: 's')
    ..addOption('compile-kind',
        abbr: 'k',
        defaultsTo: 'bundle',
        allowed: ['bundle', 'dart', 'flutter', 'sdk']);
  var argResults = parser.parse(arguments);
  var kind = argResults['compile-kind'];
  if (kind == 'bundle') {
    var file = argResults['file'];
    if (file == null || !File(file).existsSync()) {
      print('file is required, please pass as absolute path');
      exit(1);
    }
    _printResult(await dsl.parseFile(file));

  } else if (kind == 'dart') {
    var dirString = argResults['directory'];
    Directory dir;
    if (dirString == null || !(dir = Directory(dirString)).existsSync()) {
      print('directory is not valid, please pass as absolute path');
      exit(1);
    }
    _printResult(await binding.parseDir(dir));
  } else if (kind == 'flutter') {
    var dir = argResults['directory'];
    if (dir == null || !(Directory(dir)).existsSync()) {
      print('directory is not valid, please pass as absolute path');
      exit(1);
    }
    await binding.parseFlutter(dir);
  } else if (kind == 'sdk'){
    var file = argResults['file'];
    var sdkName = argResults['sdk-name'];
    var outputDir = argResults['output-directory'];
    if (file == null || !File(file).existsSync()){
      print('file is required, please pass as absolute path');
      exit(1);
    }
    var _output = 'sdk';
    if(outputDir?.isNotEmpty == true){
      _output = outputDir;
    }
    await binding.parseSdkFile(sdkName, file, _output);
  }
}

void _printResult(String data) {
  if (data != null && data.isNotEmpty) {
    final startTag =
        '#####################fairc output begin#################';
    final endTag =
        '#####################fairc output end#################';
    print(startTag);
    print(data);
    print(endTag);
  }
}

Future dart2dsl(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('file', abbr: 'f')
    ..addOption('directory', abbr: 'd')
    ..addOption('output-directory', abbr: 'o')
    ..addOption('sdk-name', abbr: 's')
    ..addOption('compile-kind',
        abbr: 'k',
        defaultsTo: 'bundle',
        allowed: ['bundle', 'dart', 'flutter', 'sdk']);
  var argResults = parser.parse(arguments);
  var kind = argResults['compile-kind'];
  if (kind == 'bundle') {
    var file = argResults['file'];
    if (file == null || !File(file).existsSync()) {
      _error('file is required, please pass as absolute path');
    }
    return _appendResult(await dsl.parseFile(file));

  } else if (kind == 'dart') {
    var dirString = argResults['directory'];
    Directory? dir;
    if (dirString == null || !(dir = Directory(dirString)).existsSync()) {
      _error('directory is not valid, please pass as absolute path');
    }
    return _appendResult(await binding.parseDir(dir!));
  } else if (kind == 'flutter') {
    var dir = argResults['directory'];
    if (dir == null || !(Directory(dir)).existsSync()) {
      _error('directory is not valid, please pass as absolute path');
    }
    await binding.parseFlutter(dir);
  } else if (kind == 'sdk'){
    var file = argResults['file'];
    var sdkName = argResults['sdk-name'];
    var outputDir = argResults['output-directory'];
    if (file == null || !File(file).existsSync()){
      _error('file is required, please pass as absolute path');
    }
    var _output = 'sdk';
    if(outputDir?.isNotEmpty == true){
      _output = outputDir;
    }
    await binding.parseSdkFile(sdkName, file, _output);
  }
}

String _appendResult(String? data) {
  var result = StringBuffer();
  if (data != null && data.isNotEmpty) {
    final startTag =
        '#####################fairc output begin#################';
    final endTag =
        '#####################fairc output end#################';
    result.writeln(startTag);
    result.writeln(data);
    result.writeln(endTag);
  }
  return result.toString();
}

void _error(String msg){
  print(msg);
  throw FairCompileError(msg);
}