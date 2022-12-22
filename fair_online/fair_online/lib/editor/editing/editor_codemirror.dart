library editor.codemirror;

import 'dart:convert';
import 'dart:html' as html;
import 'dart:js';
import 'dart:math';

import 'package:codemirror/codemirror.dart' hide Position;
import 'package:codemirror/codemirror.dart' as pos show Position;
import 'package:codemirror/hints.dart';
import 'package:fair_online/editor/component/params_provider.dart';
import 'package:fair_online/editor/editing/codemirror_options.dart';
import 'package:async/async.dart';
import 'package:fair_online/editor/editing/hint_helper.dart';
import 'package:fair_online/utils/log.dart';

import 'editor.dart' hide Position;
import 'editor.dart' as ed show Position;

export 'editor.dart';

final CodeMirrorFactory codeMirrorFactory = CodeMirrorFactory();

class CodeMirrorFactory extends EditorFactory {

  String? get version => CodeMirror.version;

  @override
  List<String> get modes => CodeMirror.modes;

  @override
  List<String> get themes => CodeMirror.themes;

  late ParamsProvider paramsProvider;

  @override
  Editor createFromElement(html.Element element, {Map? options}) {
    options ??= codeMirrorOptions;
    final editor = CodeMirror.fromElement(element, options: options);
    CodeMirror.addCommand('goLineLeft', _handleGoLineLeft);
    return _CodeMirrorEditor._(this, editor);
  }

  @override
  void registerCompleter(String mode, CodeCompleter completer) {
    Hints.registerHintsHelperAsync(mode, (CodeMirror editor,
        [HintsOptions? options]) {
      return _delayCompletionHelper(editor, completer, options);
    });
  }

  // Change the cmd-left behavior to move the cursor to the leftmost non-ws char.
  void _handleGoLineLeft(CodeMirror editor) {
    editor.execCommand('goLineLeftSmart');
  }

  CancelableCompleter? _lastCompleter;

  Future<HintResults> _delayCompletionHelper(
      CodeMirror editor, CodeCompleter codeCompleter, HintsOptions? options)  {
    _lastCompleter?.operation.cancel();
    final completer = CancelableCompleter<HintResults>();
    _lastCompleter = completer;
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      if (!completer.isCanceled) {
        Log.d("500ms内无输入，开始这次请求");
        completer.complete(_completionHelper(editor, codeCompleter, options));
      } else {
        Log.d("有500ms以内的输入，取消这次请求");
      }
    });
    return completer.operation.value;
  }

  Future<HintResults> _completionHelper(
      CodeMirror editor, CodeCompleter completer, HintsOptions? options) {
    final ed = _CodeMirrorEditor._fromExisting(this, editor);

    return completer
        .complete(ed, paramsProvider.getType(), paramsProvider.getFilePath(), onlyShowFixes: ed._lookingForQuickFix ?? false)
        .then((CompletionResult result) {
      final doc = editor.doc;
      final from = doc.posFromIndex(result.replaceOffset);
      final to = doc.posFromIndex(result.replaceOffset + result.replaceLength);
      final stringToReplace = doc.getValue()!.substring(
          result.replaceOffset, result.replaceOffset + result.replaceLength);

      var hints = result.completions.map((completion) {
        return HintResult(
          completion.value,
          displayText: completion.displayString,
          className: completion.type,
          hintApplier: (CodeMirror editor, HintResult hint, pos.Position? from,
              pos.Position? to) {
            doc.replaceRange(hint.text!, from!, to);

            if (completion.type == 'type-quick_fix') {
              for (final edit in completion.quickFixes) {
                ed.document.applyEdit(edit);
              }
            }

            if (completion.absoluteCursorPosition != null) {
              doc.setCursor(
                  doc.posFromIndex(completion.absoluteCursorPosition!));
            } else if (completion.cursorOffset != null) {
              final diff = hint.text!.length - completion.cursorOffset!;
              doc.setCursor(pos.Position(
                  editor.getCursor().line, editor.getCursor().ch! - diff));
            }
          },
          hintRenderer: (html.Element element, HintResult hint) {
            final escapeHtml = HtmlEscape().convert as String Function(String?);
            if (completion.type != 'type-quick_fix') {
              element.innerHtml = escapeHtml(completion.displayString)
                  .replaceFirst(escapeHtml(stringToReplace),
                      '<em>${escapeHtml(stringToReplace)}</em>');
            } else {
              element.innerHtml = escapeHtml(completion.displayString);
            }
          },
        );
      }).toList();

      if (hints.isEmpty && ed._lookingForQuickFix == true) {
        hints = [
          HintResult(stringToReplace,
              displayText: 'No fixes available',
              className: 'type-no_suggestions')
        ];
      } else if (hints.isEmpty &&
          (ed.completionActive ||
              (!ed.completionActive && !ed.completionAutoInvoked))) {
        // Only show 'no suggestions' if the completion was explicitly invoked
        // or if the popup was already active.
        hints = [
          HintResult(stringToReplace,
              displayText: 'No suggestions', className: 'type-no_suggestions')
        ];
      }
      HintResults hintResults = HintResults.fromHints(hints, from, to);
      //监听Hint是否显示
      hintResults.registerOnShown((){
        HintHelper.isShow = true;
      });
      hintResults.registerOnClose((){
        HintHelper.isShow = false;
      });
      return hintResults;
    });
  }
}

class _CodeMirrorEditor extends Editor {

  static final Map<dynamic, _CodeMirrorEditor> _instances = {};

  final CodeMirror cm;

  late _CodeMirrorDocument _document;

  bool? _lookingForQuickFix;

  _CodeMirrorEditor._(CodeMirrorFactory factory, this.cm) : super(factory) {
    _document = _CodeMirrorDocument._(this, cm.doc);
    _instances[cm.jsProxy] = this;
  }

  factory _CodeMirrorEditor._fromExisting(
      CodeMirrorFactory factory, CodeMirror cm) {
    // TODO: We should ensure that the Dart `CodeMirror` wrapper returns the
    // same instances to us when possible (or, identity is based on the
    // underlying JS proxy).
    if (_instances.containsKey(cm.jsProxy)) {
      return _instances[cm.jsProxy]!;
    } else {
      return _CodeMirrorEditor._(factory, cm);
    }
  }

  @override
  Document get document => _document;

  @override
  Document createDocument({String? content, String? mode}) {
    if (mode == 'html') mode = 'text/html';
    content ??= '';

    // TODO: For `html`, enable and disable the 'autoCloseTags' option.
    return _CodeMirrorDocument._(this, Doc(content, mode));
  }

  @override
  void execCommand(String name) => cm.execCommand(name);

  @override
  void showCompletions({bool autoInvoked = false, bool onlyShowFixes = false}) {
    if (autoInvoked) {
      completionAutoInvoked = true;
    } else {
      completionAutoInvoked = false;
    }
    if (onlyShowFixes) {
      _lookingForQuickFix = true;
    } else {
      _lookingForQuickFix = false;
    }
    execCommand('autocomplete');
  }

  @override
  bool get completionActive {
    final completionActive = _jsProxyState!['completionActive'];
    if (completionActive is Map) {
      return completionActive['widget'] != null;
    } else {
      return false;
    }
  }

  @override
  bool? get autoCloseBrackets => cm.getOption('autoCloseBrackets') as bool?;

  @override
  set autoCloseBrackets(bool? value) =>
      cm.setOption('autoCloseBrackets', value);

  @override
  String get mode => cm.getMode()!;

  @override
  set mode(String str) => cm.setMode(str);

  @override
  String get theme => cm.getTheme()!;

  @override
  set theme(String str) => cm.setTheme(str);

  @override
  bool get hasFocus => _jsProxyState?['focused'] == true;

  @override
  Stream<html.MouseEvent> get onMouseDown => cm.onMouseDown;

  @override
  Point getCursorCoords({ed.Position? position}) {
    JsObject? js;
    if (position == null) {
      js = cm.call('cursorCoords') as JsObject?;
    } else {
      final proxyPos = _document._posToPos(position).toProxy();
      js = cm.callArg('cursorCoords', proxyPos) as JsObject?;
    }
    return Point(js!['left'] as num, js['top'] as num);
  }

  @override
  void setSize(double width, double height) {
    cm.setSize(width, height);
  }

  @override
  void focus() => cm.focus();

  @override
  void resize() => cm.refresh();

  @override
  bool get readOnly => cm.getReadOnly();

  @override
  set readOnly(bool ro) => cm.setReadOnly(ro);

  @override
  bool get showLineNumbers => cm.getLineNumbers()!;

  @override
  set showLineNumbers(bool ln) => cm.setLineNumbers(ln);

  @override
  void swapDocument(Document document) {
    _document = document as _CodeMirrorDocument;
    cm.swapDoc(_document.doc);
  }

  @override
  void dispose() {
    _instances.remove(cm.jsProxy);
  }

  JsObject? get _jsProxy => cm.jsProxy;

  JsObject? get _jsProxyState => _jsProxy?['state'] as JsObject?;
}

class _CodeMirrorDocument extends Document<_CodeMirrorEditor> {
  final Doc doc;

  final List<LineWidget> widgets = [];
  final List<html.DivElement> nodes = [];

  /// We use `_lastSetValue` here to avoid a change notification when we
  /// programmatically change the `value` field.
  String? _lastSetValue;

  _CodeMirrorDocument._(_CodeMirrorEditor editor, this.doc) : super(editor);

  _CodeMirrorEditor get parent => editor;

  @override
  String get value => doc.getValue()!;

  @override
  set value(String str) {
    _lastSetValue = str;
    doc.setValue(str);
    doc.markClean();
    doc.clearHistory();
  }

  @override
  void updateValue(String str) {
    doc.setValue(str);
  }

  @override
  ed.Position get cursor => _posFromPos(doc.getCursor());

  @override
  void select(ed.Position start, [ed.Position? end]) {
    if (end != null) {
      doc.setSelection(_posToPos(start), head: _posToPos(end));
    } else {
      doc.setSelection(_posToPos(start));
    }
  }

  @override
  String get selection => doc.getSelection(value)!;

  @override
  String get mode => parent.mode;

  @override
  bool get isClean => doc.isClean();

  @override
  void markClean() => doc.markClean();

  @override
  void applyEdit(SourceEdit edit) {
    doc.replaceRange(edit.replacement, _posToPos(posFromIndex(edit.offset)),
        _posToPos(posFromIndex(edit.offset + edit.length)));
  }

  @override
  void setAnnotations(List<Annotation> annotations) {
    for (final marker in doc.getAllMarks()) {
      marker.clear();
    }

    for (final widget in widgets) {
      widget.clear();
    }
    widgets.clear();

    for (final e in nodes) {
      e.parent!.children.remove(e);
    }
    nodes.clear();

    // Sort annotations so that the errors are set first.
    annotations.sort();

    var lastLine = -1;

    for (final an in annotations) {
      // Create in-line squiggles.
      doc.markText(_posToPos(an.start), _posToPos(an.end),
          className: 'squiggle-${an.type}', title: an.message);

      // Create markers in the margin.
      if (lastLine == an.line) continue;
      lastLine = an.line;
    }
  }

  @override
  void addAnnotations(List<Annotation> annotations) {
    // Sort annotations so that the errors are set first.
    annotations.sort();

    var lastLine = -1;

    for (final an in annotations) {
      // Create in-line squiggles.
      doc.markText(_posToPos(an.start), _posToPos(an.end),
          className: 'squiggle-${an.type}', title: an.message);

      // Create markers in the margin.
      if (lastLine == an.line) continue;
      lastLine = an.line;
    }
  }

  @override
  int indexFromPos(ed.Position position) =>
      doc.indexFromPos(_posToPos(position))!;

  @override
  ed.Position posFromIndex(int index) => _posFromPos(doc.posFromIndex(index));

  pos.Position _posToPos(ed.Position position) =>
      pos.Position(position.line, position.char);

  ed.Position _posFromPos(pos.Position position) =>
      ed.Position(position.line!, position.ch!);

  @override
  Stream get onChange {
    return doc.onChange.where((_) {
      if (value != _lastSetValue) {
        _lastSetValue = null;
        return true;
      } else {
        //_lastSetValue = null;
        return false;
      }
    });
  }
}
