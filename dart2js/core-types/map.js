/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

const __global__ = global;

function MapEntry() {
  const inner = MapEntry.__inner__;
  if (this == __global__) {
    return new MapEntry({ __args__: arguments });
  } else {
    const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
    inner.apply(this, args);
    MapEntry.prototype.ctor.apply(this, args);
    return this;
  }
}

MapEntry.__inner__ = function inner() {
  this.key = null;
  this.value = null;
};

MapEntry.prototype = {
  ctor: function (key, value) {
    this.key = key;
    this.value = value;
  },
  toString: function () {
    return `MapEntry(${key.toString()}: ${value.toString()})`;
  },
};
global.MapEntry = MapEntry;

var oldMapPrototype = {
  entries: Map.prototype.entries,
  keys: Map.prototype.keys,
  values: Map.prototype.values,
};
Object.defineProperties(Map.prototype, {
  entries: {
    get: function () {
      return Array.nativeFrom(oldMapPrototype.entries.call(this)).map((item) =>
        MapEntry(item[0], item[1])
      );
    },
  },
  keys: {
    get: function () {
      return Array.nativeFrom(oldMapPrototype.keys.call(this));
    },
  },
  values: {
    get: function () {
      return Array.nativeFrom(oldMapPrototype.values.call(this));
    },
  },
  length: {
    get: function () {
      return this.size;
    },
  },
  isEmpty: {
    get: function () {
      return !this.size;
    },
  },
  isNotEmpty: {
    get: function () {
      return !this.isEmpty;
    },
  },
});

Object.assign(Map.prototype, {
  cast: function () {
    return this;
  },
  __op_idx__: function (key) {
    return this.get(key);
  },
  __op_idxeq__: function (key, value) {
    this.set(key, value);
  },
  containsValue: function (value) {
    return this.values.includes(value);
  },
  containsKey: function (value) {
    return this.has(value);
  },
  map: function (convert) {
    var res = new Map();
    this.forEach((key, value) => {
      var entry = convert(key, value);
      res.set(entry.key, entry.value);
    });
    return res;
  },
  addEntries: function (newEntries) {
    for (let i = 0; i < newEntries.length; i++) {
      this.set(newEntries[i].key, newEntries[i].value);
    }
  },
  update: function (key, update, { ifAbsent } = {}) {
    var newVal = null;
    if (this.has(key)) {
      newVal = update(this.get(key));
      this.set(key, newVal);
    } else {
      if (ifAbsent) {
        newVal = ifAbsent();
        this.set(key, newVal);
      } else {
        throw "Error";
      }
    }
    return newVal;
  },
  updateAll: function (update) {
    this.keys.forEach((k) => {
      this.set(k, update(k, this.get(k)));
    });
  },
  removeWhere: function (test) {
    var i = 0;
    var keys = this.keys.slice(0);
    while (i < this.size) {
      if (test(keys[i], this.get(keys[i]))) {
        this.delete(keys[i]);
        keys.splice(i, 1);
      } else {
        i++;
      }
    }
  },
  putIfAbsent: function (key, ifAbsent) {
    if (!this.has(key)) {
      this.set(key, ifAbsent());
    }
    return this.get(key);
  },
  addAll: function (other) {
    let __thiz__ = this;
    other.forEach((key, value) => {
      __thiz__.set(key, value);
    });
  },
  remove: function (key) {
    if (this.has(key)) {
      var res = this.get(key);
      this.delete(key);
      return res;
    }
    return null;
  },
  // clear

  forEach: function (action) {
    this.entries.forEach((e) => action(e.key, e.value));
  },
});

Map.from = function (other) {
  var res = new Map();
  other.forEach((key, value) => res.set(key, value));
  return res;
};

Map.of = function (other) {
  return Map.from(other);
};

Map.unmodifiable = function (other) {
  return Map.from(other);
};

Map.identity = function () {
  throw "Not Implemented: identity";
};

Map.fromIterable = function (arg1, arg2) {
  if (args2.length) {
    let keys = arg1;
    let values = arg2;
    if (keys.length != values.length) {
      throw "Error";
    }
    let res = new Map();
    for (let i = 0; i < keys.length; i++) {
      res.set(keys[i], values[i]);
    }
    return res;
  } else {
    let iterable = arg1;
    let obj = arg2;
    let res = new Map();
    for (let i = 0; i < iterable.length; i++) {
      res.set(obj.key(iterable[i]), obj.value(iterable[i]));
    }
    return res;
  }
};

Map.fromEntries = function (entries) {
  var res = new Map();
  for (let i = 0; i < entries.length; i++) {
    res.set(entries[i].key, entries[i].value);
  }
  return res;
};

Map.castFrom = function (source) {
  return source;
};
