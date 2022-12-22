import 'dart:convert' show jsonDecode;
import 'package:async/async.dart';

import 'editing/editor.dart';
import 'services/dartservices.dart' as ds;

class DartCompleter extends CodeCompleter {
  final ds.DartservicesApi servicesApi;
  final Document document;

  CancelableCompleter? _lastCompleter;

  DartCompleter(this.servicesApi, this.document);

  @override
  Future<CompletionResult> complete(
    Editor editor,
    String type,
    String filePath, {
    bool onlyShowFixes = false,
  }) {
    // Cancel any open completion request.
    _lastCompleter?.operation.cancel();

    final offset = editor.document.indexFromPos(editor.document.cursor);

    final request = ds.SourceRequest()
      ..source = editor.document.value
      ..type = type
      ..filePath = filePath
      ..offset = offset;

    final completer = CancelableCompleter<CompletionResult>();
    _lastCompleter = completer;

    if (onlyShowFixes) {
      final completions = <Completion>[];
      final fixesFuture =
          servicesApi.fixes(request).then((ds.FixesResponse response) {
        for (final problemFix in response.fixes) {
          for (final fix in problemFix.fixes) {
            final fixes = fix.edits.map((edit) {
              return SourceEdit(edit.length, edit.offset, edit.replacement);
            }).toList();

            completions.add(Completion(
              '',
              displayString: fix.message,
              type: 'type-quick_fix',
              quickFixes: fixes,
            ));
          }
        }
      });
      final assistsFuture =
          servicesApi.assists(request).then((ds.AssistsResponse response) {
        for (final assist in response.assists) {
          final sourceEdits = assist.edits
              .map((edit) =>
                  SourceEdit(edit.length, edit.offset, edit.replacement))
              .toList();

          int? absoluteCursorPosition;

          // TODO(redbrogdon): Find a way to properly use these linked edit
          // groups via selections and multiple cursors.
          if (assist.linkedEditGroups.isNotEmpty) {
            absoluteCursorPosition =
                assist.linkedEditGroups.first.positions.first;
          }

          // If a specific offset is provided, prefer it to the one calculated
          // from the linked edit groups.
          if (assist.hasSelectionOffset()) {
            absoluteCursorPosition = assist.selectionOffset;
          }

          final completion = Completion(
            '',
            displayString: assist.message,
            type: 'type-quick_fix',
            quickFixes: sourceEdits,
            absoluteCursorPosition: absoluteCursorPosition,
          );

          completions.add(completion);
        }
      });

      Future.wait([fixesFuture, assistsFuture]).then((_) {
        completer.complete(CompletionResult(completions,
            replaceOffset: offset, replaceLength: 0));
      });
    } else {
      servicesApi.complete(request).then((ds.CompleteResponse response) {
        if (completer.isCanceled) return;
        final replaceOffset = response.replacementOffset;
        final replaceLength = response.replacementLength;

        final responses = response.completions.map((completion) {
          return AnalysisCompletion(replaceOffset, replaceLength, completion);
        });

        final completions = responses.map((completion) {
          // TODO: Move to using a LabelProvider; decouple the data and rendering.
          var displayString = completion.isMethod
              ? '${completion.text}${completion.parameters}'
              : completion.text;
          if (completion.isMethod && completion.returnType != null) {
            displayString += ' → ${completion.returnType}';
          }

          var text = completion.text;

          if (completion.isMethod) {
            text += '()';
          }

          if (completion.isConstructor) {
            displayString += '()';
          }

          final deprecatedClass = completion.isDeprecated ? ' deprecated' : '';

          if (completion.type == null) {
            return Completion(
              text,
              displayString: displayString,
              type: deprecatedClass,
            );
          } else {
            int? cursorPos;

            if (completion.isMethod && completion.parameterCount! > 0) {
              cursorPos = text.indexOf('(') + 1;
            }

            if (completion.selectionOffset != 0) {
              cursorPos = completion.selectionOffset;
            }

            return Completion(
              text,
              displayString: displayString,
              type: 'type-${completion.type!.toLowerCase()}$deprecatedClass',
              cursorOffset: cursorPos,
            );
          }
        }).toList();

        // Removes duplicates when a completion is both a getter and a setter.
        for (final completion in completions) {
          for (final other in completions) {
            if (completion.isSetterAndMatchesGetter(other)) {
              completions.removeWhere((c) => completion == c);
              other.type = 'type-getter_and_setter';
            }
          }
        }

        completer.complete(CompletionResult(
          completions,
          replaceOffset: replaceOffset,
          replaceLength: replaceLength,
        ));
      }).catchError((e) {
        completer.completeError(e as Object);
      });
    }

    return completer.operation.value;
  }
}

class AnalysisCompletion implements Comparable {
  final int offset;
  final int length;

  final Map<String, dynamic> _map;

  AnalysisCompletion(this.offset, this.length, ds.Completion completion)
      : _map = Map<String, dynamic>.from(completion.completion) {
    // TODO: We need to pass this completion info better.
    _convert('element');
    _convert('parameterNames');
    _convert('parameterTypes');

    if (_map.containsKey('element')) _map['element'].remove('location');
  }

  // Convert maps and lists that have been passed as json.
  void _convert(String key) {
    if (_map[key] is String) {
      _map[key] = jsonDecode(_map[key] as String);
    }
  }

  // KEYWORD, INVOCATION, ...
  String? get kind => _map['kind'] as String?;

  bool get isMethod {
    final element = _map['element'];
    return element is Map
        ? (element['kind'] == 'FUNCTION' || element['kind'] == 'METHOD')
        : false;
  }

  bool get isConstructor => type == 'CONSTRUCTOR';

  String? get parameters =>
      isMethod ? _map['element']['parameters'] as String? : null;

  int? get parameterCount =>
      isMethod ? _map['parameterNames'].length as int? : null;

  String get text {
    final str = _map['completion'] as String;
    if (str.startsWith('(') && str.endsWith(')')) {
      return str.substring(1, str.length - 1);
    } else {
      return str;
    }
  }

  String? get returnType => _map['returnType'] as String?;

  bool get isDeprecated => _map['isDeprecated'] == 'true';

  int get selectionOffset => _int(_map['selectionOffset'] as String?);

  // FUNCTION, GETTER, CLASS, ...
  String? get type =>
      _map.containsKey('element') ? _map['element']['kind'] as String? : kind;

  @override
  int compareTo(other) {
    if (other is AnalysisCompletion) {
      return text.compareTo(other.text);
    }
    return -1;
  }

  @override
  String toString() => text;

  int _int(String? val) => val == null ? 0 : int.parse(val);
}
