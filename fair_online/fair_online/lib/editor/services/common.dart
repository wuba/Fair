/// Common constants.
///
/// The `*EnvironmentVar` constants specify environment variable names, which
/// are typically specified in `dart2js_args` passed via a build_runner option.
/// The `grind build` task specifies each of these options.
/// The environment variable name which specifies the URL of the base back-end
/// server.
const serverUrlEnvironmentVar = 'SERVER_URL';

/// The URL of the back-end server.
const serverUrl = String.fromEnvironment(serverUrlEnvironmentVar);

/// The environment variable name which specifies the URL of the back-end
/// server serving "Flutter stable".
const stableServerUrlEnvironmentVar = 'STABLE_SERVER_URL';

/// The URL of the "Flutter stable" back-end server.
const stableServerUrl = String.fromEnvironment(stableServerUrlEnvironmentVar);

/// The environment variable name which specifies the URL of the back-end
/// server serving "Flutter beta".
const betaServerUrlEnvironmentVar = 'BETA_SERVER_URL';

/// The URL of the "Flutter beta" back-end server.
const betaServerUrl = String.fromEnvironment(betaServerUrlEnvironmentVar);

// TODO(srawlins): remove these 'dev' channel tasks if that channel becomes
// unsupported.

/// The environment variable name which specifies the URL of the back-end
/// server serving "Flutter dev".
const devServerUrlEnvironmentVar = 'DEV_SERVER_URL';

/// The URL of the "Flutter dev" back-end server.
const devServerUrl = String.fromEnvironment(devServerUrlEnvironmentVar);

/// The environment variable name which specifies the URL of the back-end
/// server serving "Flutter old" (stable -1).
const oldServerUrlEnvironmentVar = 'OLD_SERVER_URL';

/// The URL of the "Flutter old" back-end server.
const oldServerUrl = String.fromEnvironment(oldServerUrlEnvironmentVar);

const Duration serviceCallTimeout = Duration(seconds: 10);
const Duration longServiceCallTimeout = Duration(seconds: 60);

class Lines {
  final _starts = <int>[];

  Lines(String source) {
    final units = source.codeUnits;
    var nextIsEol = true;
    for (var i = 0; i < units.length; i++) {
      if (nextIsEol) {
        nextIsEol = false;
        _starts.add(i);
      }
      if (units[i] == 10) nextIsEol = true;
    }
  }

  /// Return the 0-based line number.
  int getLineForOffset(int offset) {
    if (_starts.isEmpty) return 0;
    for (var i = 1; i < _starts.length; i++) {
      if (offset < _starts[i]) return i - 1;
    }
    return _starts.length - 1;
  }

  int offsetForLine(int line) {
    assert(line >= 0);
    if (_starts.isEmpty) return 0;
    if (line >= _starts.length) line = _starts.length - 1;
    return _starts[line];
  }
}
