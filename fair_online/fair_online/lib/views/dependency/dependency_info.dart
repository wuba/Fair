
class DependencyInfo {

  String _name;
  String _version;

  DependencyInfo(this._name, this._version);

  get name => _name;

  get version => _version;

  set setVersion(String value) {
    _version = value;
  }

}