import 'dart:async';

import 'context.dart';
import 'editing/editor.dart';

class PlaygroundContext extends Context {
  final Editor editor;

  final _modeController = StreamController<String>.broadcast();

  final Document _dartDoc;
  final Document _htmlDoc;
  final Document _cssDoc;

  final _cssDirtyController = StreamController.broadcast();
  final _dartDirtyController = StreamController.broadcast();
  final _htmlDirtyController = StreamController.broadcast();

  final _cssReconcileController = StreamController.broadcast();
  final _dartReconcileController = StreamController.broadcast();
  final _htmlReconcileController = StreamController.broadcast();

  PlaygroundContext(this.editor)
      : _dartDoc = editor.document,
        _htmlDoc = editor.createDocument(content: '', mode: 'html'),
        _cssDoc = editor.createDocument(content: '', mode: 'css') {
    editor.mode = 'dart';

    _dartDoc.onChange.listen((_) => _dartDirtyController.add(null));
    _htmlDoc.onChange.listen((_) => _htmlDirtyController.add(null));
    _cssDoc.onChange.listen((_) => _cssDirtyController.add(null));

    _createReconciler(_cssDoc, _cssReconcileController, 250);
    _createReconciler(_dartDoc, _dartReconcileController, 1250);
    _createReconciler(_htmlDoc, _htmlReconcileController, 250);
  }

  Document get dartDocument => _dartDoc;

  Document get htmlDocument => _htmlDoc;

  Document get cssDocument => _cssDoc;

  @override
  String get dartSource => _dartDoc.value;

  @override
  set dartSource(String value) {
    _dartDoc.value = value;
  }

  @override
  String get htmlSource => _htmlDoc.value;

  @override
  set htmlSource(String value) {
    _htmlDoc.value = value;
  }

  @override
  String get cssSource => _cssDoc.value;

  @override
  set cssSource(String value) {
    _cssDoc.value = value;
  }

  @override
  String get activeMode => editor.mode;

  @override
  Stream<String> get onModeChange => _modeController.stream;

  bool hasWebContent() {
    return htmlSource.trim().isNotEmpty || cssSource.trim().isNotEmpty;
  }

  @override
  void switchTo(String name) {
    final oldMode = activeMode;

    if (name == 'dart') {
      editor.swapDocument(_dartDoc);
    } else if (name == 'html') {
      editor.swapDocument(_htmlDoc);
    } else if (name == 'css') {
      editor.swapDocument(_cssDoc);
    }

    if (oldMode != name) _modeController.add(name);

    editor.focus();
  }

  @override
  String get focusedEditor {
    if (editor.document == _htmlDoc) return 'html';
    if (editor.document == _cssDoc) return 'css';
    return 'dart';
  }

  Stream get onCssDirty => _cssDirtyController.stream;

  Stream get onDartDirty => _dartDirtyController.stream;

  Stream get onHtmlDirty => _htmlDirtyController.stream;

  Stream get onCssReconcile => _cssReconcileController.stream;

  Stream get onDartReconcile => _dartReconcileController.stream;

  Stream get onHtmlReconcile => _htmlReconcileController.stream;

  void markCssClean() => _cssDoc.markClean();

  void markDartClean() => _dartDoc.markClean();

  void markHtmlClean() => _htmlDoc.markClean();

  /// Restore the focus to the last focused editor.
  void focus() => editor.focus();

  void _createReconciler(Document doc, StreamController controller, int delay) {
    Timer? timer;
    doc.onChange.listen((_) {
      if (timer != null) timer!.cancel();
      timer = Timer(Duration(milliseconds: delay), () {
        controller.add(null);
      });
    });
  }

  /// Return true if the current cursor position is in a whitespace char.
  bool cursorPositionIsWhitespace() {
    final document = editor.document;
    final str = document.value;
    final index = document.indexFromPos(document.cursor);
    if (index < 0 || index >= str.length) return false;
    final char = str[index];
    return char != char.trim();
  }
}
