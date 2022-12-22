library execution;

import 'dart:typed_data';

class TestResult {
  final bool success;
  final List<String> messages;

  const TestResult(this.success, this.messages);
}

/// An abstraction about a service that can inject and execute JavaScript code.
abstract class ExecutionService {
  /// Sends a request to the execution iframe.
  ///
  /// [modulesBaseUrl] can be null, and is only passed in if [javaScript]
  /// uses RequireJS to reference other modules.
  ///
  /// [addRequireJs] should be `true` when [javaScript] has been compiled with
  /// DDC. RequireJS will then be added to the iframe, and will be used to load
  /// the Dart and Flutter SDKs.
  ///
  /// [addFirebaseJs] should be `true` when the script imports any Firebase
  /// libraries. Firebase JS SDKs will then be added to the iframe.
  ///
  /// If [destroyFrame] is `true`, this method destroys and rebuilds the
  /// execution frame, instead of just replacing its contents.
  Future<void> execute(
    String html,
    String css,
    String javaScript, {
    String? modulesBaseUrl,
    bool addRequireJs = false,
    bool addFirebaseJs = false,
    bool destroyFrame = false,
  });

  void replaceHtml(String html);

  void replaceCss(String css);

  /// Destroy the iframe; stop any currently running scripts. The iframe will be
  /// available to be re-used again.
  Future<void> tearDown();

  Stream<String> get onStdout;

  Stream<String> get onStderr;

  Stream<TestResult> get testResults;

  Stream<Uint8List> get screenshot;

  /// The method returned here should be added to any Dart code that needs to
  /// report a test result while executing via this service. It calls `print`
  /// with a specially constructed string, which is caught by the `dartPrint`
  /// method and routed to [testResults] rather than the [onStdout] stream.
  String get testResultDecoration;
}
