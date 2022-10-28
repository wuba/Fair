import 'dart:collection';

class MethodDeclarationData {
  var name = '';
  var body = '';
  var _isGenerativeConstructor = false;
  var _isRedirectConstructor = false;
  var isArrow = false;
  var _isStatic = false;
  var _isFactory = false;

  bool get isRedirectConstructor => _isRedirectConstructor;

  set isRedirectConstructor(bool val) {
    _isRedirectConstructor = true;
    if (val) {
      _isGenerativeConstructor = val;
    }
  }

  bool get isStatic => _isStatic;

  set isStatic(bool val) {
    if (!val && (_isFactory || _isGenerativeConstructor)) {
      throw 'invalid value';
    }
    _isStatic = val;
  }

  bool get isGenerativeConstructor => _isGenerativeConstructor;

  set isGenerativeConstructor(bool val) {
    if (isRedirectConstructor && !val) {
      throw 'invalid value';
    }
    _isGenerativeConstructor = val;
    if (val) {
      isStatic = val;
    }
  }

  bool get isFactory => _isFactory;

  set isFactory(bool val) {
    _isFactory = val;
    if (val) {
      isStatic = val;
    }
  }

  var renamedParameters = HashMap<int, String>();
  var abtractedInitializer = <String>[];

  MethodDeclarationData(this.name, this.body, this.isArrow);
}