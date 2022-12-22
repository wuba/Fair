import 'dart:io';

/// A simple, properties file based configuration class.
///
/// We expect an (optional) file in the root of the directory, names 'config.properties'.
class Config {
  static Config? _singleton;

  static Config getConfig() {
    if (_singleton == null) {
      _singleton = Config._();

      final file = File('config.properties');
      if (file.existsSync()) {
        _singleton!._load(file.readAsLinesSync());
      }
    }

    return _singleton!;
  }

  final Map<String, String> _values = <String, String>{};

  Config._();

  String? getValue(String key) => _values[key];

  void _load(List<String> lines) {
    _values.clear();

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) {
        continue;
      }
      final index = line.indexOf('=');
      if (index == -1) {
        continue;
      }
      _values[line.substring(0, index)] = line.substring(index + 1);
    }
  }
}
