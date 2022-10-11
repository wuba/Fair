
import 'package:path/path.dart' as p;
const superSubstitution = '__super__';
const argsName = '__args__';
const innerName = '__inner__';
const constructorAlias = 'ctor';
const factoryConstructorAlias = '__fty__ctor__';
const thisAlias = '__thiz__';
const setStateMethodName = 'setState';
const FairKeyPlaceholder = '#FairKey#';
const commonJs = '''
var __global__ = global;
global.int = {
  parse: function(source, {radix} = {}) {
    return parseInt(source, radix || 10);
  }
};
var print = console.log.bind(console);
function inherit(cls, sup) {
    var oldProto = cls.prototype;
    cls.prototype = Object.create(Object.create(sup.prototype));
    Object.assign(cls.prototype, oldProto);
    cls.prototype.constructor = cls;
    cls.prototype.$superSubstitution = cls.prototype.__proto__;
}

function convertObjectLiteralToSetOrMap(obj) {
  let isSet = Object.prototype.toString.call(obj) == '[object Array]';
  if (!isSet) {
    let keys = Object.getOwnPropertyNames(obj);
    let res = new Map();
    keys.forEach(k => res.set(k, obj[k]));
    return res;
  } else {
    let res = new Set();
    obj.forEach(item => res.add(item));
    return res;
  }
}

Object.prototype.ctor = function(){};
Object.__inner__ = function(){};
''';

class TranspileOption {
  bool modifySetState = false;
}

var transpileOption = TranspileOption();

class Tuple<K1, K2, K3> {
  K1? k1;
  K2? k2;
  K3? k3;

  Tuple(this.k1, this.k2, this.k3);
}
class OperatorOverloadSymbol {
  static final add = '__op_add__';
  static final minus = '__op_minus__';
  static final negative = '__op_ngt__';
  static final multi = '__op_multi__';
  static final idivide = '__op_idivide__';
  static final lessThan = '__op_lt__';
  static final greaterThan = '__op_gt__';
  static final lessEqualThan = '__op_lte__';
  static final greaterEqualThan = '__op_gte__';
  static final equal = '__op_eq__';
  static final index = '__op_idx__';
  static final indexEqual = '__op_idxeq__';
}
enum ClassOutputTemplateType { raw, pageState }

String resolvePath(basePath, relativePath) {
  var p1 = p.split(basePath);
  var p2 = p.split(relativePath);
  for (var segment in p2) {
    if (segment == '..') {
      p1.removeLast();
    } else if (segment == '.') {
      continue;
    } else {
      p1.add(segment);
    }
  }
  return p.joinAll(p1);
}