/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:pedantic/pedantic.dart';
import 'package:source_gen/source_gen.dart';

class BundleBuilder extends LibraryBuilder {
  BundleBuilder(Generator generator, {String? generatedExtension, String Function(String code)? formatOutput})
      : _generator = generator,
        _generatedExtension = generatedExtension ?? '.dart.temp',
        super(
          generator,
          header: '',
          formatOutput: formatOutput,
          generatedExtension: generatedExtension ?? '.dart.temp',
        );
  final String _generatedExtension;
  final Generator _generator;

  @override
  Future build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    await _generateForLibrary(lib, buildStep);
  }

  Future _generateForLibrary(
    LibraryElement library,
    BuildStep buildStep,
  ) async {
    final generatedOutputs = await _generate(library, [_generator], buildStep).toList();
    if (generatedOutputs.isEmpty) return;
    final outputId = buildStep.inputId.changeExtension(_generatedExtension);

    final contentBuffer = StringBuffer();

    for (var item in generatedOutputs) {
      contentBuffer.writeln(item.output);
    }

    var genPartContent = contentBuffer.toString();

    try {
      genPartContent = formatOutput(genPartContent);
    } catch (e, stack) {
      log.severe(
        '''
An error `${e.runtimeType}` occurred while formatting the generated source for
  `${library.identifier}`
which was output to
  `${outputId.path}`.
This may indicate an issue in the generator, the input source code, or in the
source formatter.\n==>\n$genPartContent
''',
        e,
        stack,
      );
    }
    if (genPartContent.isNotEmpty) {
      unawaited(buildStep.writeAsString(outputId, genPartContent));
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': <String>[_generatedExtension]
      };

  Stream<_GeneratedOutput> _generate(
    LibraryElement library,
    List<Generator> generators,
    BuildStep buildStep,
  ) async* {
    final libraryReader = LibraryReader(library);
    for (var i = 0; i < generators.length; i++) {
      final gen = generators[i];
      var msg = 'Running $gen';
      if (generators.length > 1) {
        msg = '$msg - ${i + 1} of ${generators.length}';
      }
      log.fine(msg);
      var createdUnit = await gen.generate(libraryReader, buildStep);

      if (createdUnit == null) {
        continue;
      }

      createdUnit = createdUnit.trim();
      if (createdUnit.isEmpty) {
        continue;
      }

      yield _GeneratedOutput(gen, createdUnit);
    }
  }
}

class _GeneratedOutput {
  final String output;
  final String generatorDescription;

  _GeneratedOutput(Generator generator, this.output)
      : assert(output.isNotEmpty),
        // assuming length check is cheaper than simple string equality
        assert(output.length == output.trim().length),
        generatorDescription = _toString(generator);

  static String _toString(Generator generator) {
    final output = generator.toString();
    if (output.endsWith('Generator')) {
      return output;
    }
    return 'Generator: $output';
  }
}
