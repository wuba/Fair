library editor;

import 'dart:html' as html;
import 'dart:math';

abstract class EditorFactory {
  List<String> get modes;

  List<String> get themes;

  Editor createFromElement(html.Element element);

  void registerCompleter(String mode, CodeCompleter completer);
}

abstract class Editor {
  final EditorFactory factory;

  bool completionAutoInvoked = false;

  Editor(this.factory);

  Document createDocument({required String content, required String mode});

  Document get document;

  /// Runs the command with the given name on the editor.
  void execCommand(String name);

  void showCompletions({bool autoInvoked = false, bool onlyShowFixes = false});

  /// Checks if the completion popup is displayed.
  bool get completionActive;

  bool? get autoCloseBrackets;

  set autoCloseBrackets(bool? value);

  String get mode;

  set mode(String str);

  String get theme;

  set theme(String str);

  /// Returns the cursor coordinates in pixels. cursorCoords.x corresponds to
  /// left and cursorCoords.y corresponds to top.
  Point getCursorCoords({Position? position});

  bool get hasFocus;

  /// Fired when a mouse is clicked. You can preventDefault the event to signal
  /// that the editor should do no further handling.
  Stream<html.MouseEvent> get onMouseDown;

  void setSize(double width, double height);

  void resize();

  void focus();

  /// Whether to show line numbers to the left of the editor.
  late bool showLineNumbers;

  /// Whether the editor is in read only mode.
  late bool readOnly;

  void swapDocument(Document document);

  /// Let the `Editor` instance know that it will no longer be used.
  void dispose() {}
}

abstract class Document<E extends Editor> {
  final E editor;

  Document(this.editor);

  String get value;

  set value(String str);

  /// Update the value on behalf of a user action, performing
  /// save, etc.
  void updateValue(String str);

  Position get cursor;

  void select(Position start, [Position? end]);

  /// The currently selected text in the editor.
  String get selection;

  String get mode;

  bool get isClean;

  void markClean();

  void setAnnotations(List<Annotation> annotations);

  void addAnnotations(List<Annotation> annotations);

  void clearAnnotations() => setAnnotations([]);

  int indexFromPos(Position pos);

  Position posFromIndex(int index);

  void applyEdit(SourceEdit edit);

  Stream get onChange;
}

class Annotation implements Comparable<Annotation> {
  static int _errorValue(String type) {
    if (type == 'error') return 2;
    if (type == 'warning') return 1;
    return 0;
  }

  /// info, warning, or error
  final String type;
  final String message;
  final int line;

  final Position start;
  final Position end;

  Annotation(this.type, this.message, this.line,
      {required this.start, required this.end});

  @override
  int compareTo(Annotation other) {
    if (line == other.line) {
      return _errorValue(other.type) - _errorValue(type);
    } else {
      return line - other.line;
    }
  }

  @override
  String toString() => '$type, line $line: $message';
}

class Position {
  final int line;
  final int char;

  const Position(this.line, this.char);

  @override
  String toString() => '[$line,$char]';
}

abstract class CodeCompleter {
  Future<CompletionResult> complete(Editor editor,
      String type,
      String filePath,
      {bool onlyShowFixes = false});
}

class CompletionResult {
  final List<Completion> completions;

  /// The start offset of the text to be replaced by a completion.
  final int replaceOffset;

  /// The length of the text to be replaced by a completion.
  final int replaceLength;

  CompletionResult(this.completions,
      {required this.replaceOffset, required this.replaceLength});
}

class Completion {
  /// The value to insert.
  final String value;

  /// An optional string that is displayed during auto-completion if specified.
  final String? displayString;

  /// The css class type for the completion.
  String? type;

  /// The (optional) offset to display the cursor at after completion. This is
  /// relative to the insertion location, not the absolute position in the file.
  /// This can be `null`.
  final int? cursorOffset;

  /// The (optional) index (starting from the top of the file) of the character
  /// at which the cursor should be placed after implementing the completion.
  ///
  /// Quick fixes that alter multiple lines of editor content can't simply
  /// provide an offset on the cursor's current line to represent the position
  /// to which the cursor should move. This field is provided as an alternative
  /// for use with those fixes.
  final int? absoluteCursorPosition;

  final List<SourceEdit> quickFixes;

  Completion(
    this.value, {
    this.displayString,
    this.type,
    this.cursorOffset,
    this.absoluteCursorPosition,
    this.quickFixes = const [],
  });

  bool isSetterAndMatchesGetter(Completion other) =>
      displayString == other.displayString &&
      (type == 'type-getter' && other.type == 'type-setter');
}

class SourceEdit {
  int length;
  int offset;
  String replacement;

  SourceEdit(this.length, this.offset, this.replacement);
}
