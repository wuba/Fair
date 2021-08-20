/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

const __global__ = global;
const NativeRegExp = global.RegExp;

function RegExp() {
  const inner = RegExp.__inner__;
  if (this == __global__) {
    return new RegExp({ __args__: arguments });
  } else {
    const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
    inner.apply(this, args);
    RegExp.prototype.ctor.apply(this, args);
    return this;
  }
}

RegExp.__inner__ = function inner() {
  Object.defineProperties(this, {
    pattern: {
      get: function () {
        return this.__regex__.source;
      },
    },
    isMultiLine: {
      get: function () {
        return this.__regex__.multiline;
      },
    },
    isCaseSensitive: {
      get: function () {
        return this.__regex__.ignoreCase;
      },
    },
    isUnicode: {
      get: function () {
        return this.__regex__.unicode;
      },
    },
    isDotAll: {
      get: function () {
        return this.__regex__.dotAll;
      },
    },
  });

  this.__regex__ = null;
};

RegExp.prototype = {
  ctor: function (
    source,
    {
      multiLine = false,
      caseSensitive = true,
      unicode = false,
      dotAll = false,
    } = {}
  ) {
    let flag = "g";
    if (multiLine) {
      flag += "m";
    }
    if (!caseSensitive) {
      flag += "i";
    }
    if (unicode) {
      flag += "u";
    }
    if (dotAll) {
      flag += "s";
    }
    this.__regex__ = new NativeRegExp(source, flag);
  },
  allMatches: function (string, start = 0) {
    this.__regex__.lastIndex = start;
    let matches = [];
    let m = this.__firstMatch__(string);
    while (m) {
      matches.push(m);
      m = this.__firstMatch__(string);
    }
    this.__regex__.lastIndex = 0;
    return !matches.length ? null : matches;
  },
  matchAsPrefix: function (string, start = 0) {
    this.__regex__.lastIndex = start;
    var res = this.__firstMatch__(string);
    this.__regex__.lastIndex = 0;
    return res;
  },
  firstMatch: function (input) {
    this.__regex__.lastIndex = 0;
    let res = this.__firstMatch__(input);
    this.__regex__.lastIndex = 0;
    return res;
  },
  __firstMatch__: function (input) {
    let res = this.__regex__.exec(input);
    if (!res || !res.length) {
      return null;
    }
    let start = res.index;
    let end = start + res[0].length;
    let groups = Array.prototype.slice.call(res, 0, res.length);
    let groupNames = res.groups ? Object.getOwnPropertyNames(res.groups) : [];
    let namedGroups = res.groups;
    return RegExpMatch(
      input,
      this,
      start,
      end,
      groups,
      groupNames,
      namedGroups
    );
  },
  hasMatch: function (input) {
    let res = this.__regex__.test(input);
    this.__regex__.lastIndex = 0;
    return res;
  },
  stringMatch: function (input) {
    let res = this.__regex__.exec(input);
    if (!res || !res.length) {
      return null;
    }
    this.__regex__.lastIndex = 0;
    return res[0];
  },
};

RegExp.escape = function (text) {
  return text.replace(/[-\/\\^$*+?.()|[\]{}]/g, "\\$&");
};

function RegExpMatch() {
  const inner = RegExpMatch.__inner__;
  if (this == __global__) {
    return new RegExpMatch({ __args__: arguments });
  } else {
    const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
    inner.apply(this, args);
    RegExpMatch.prototype.ctor.apply(this, args);
    return this;
  }
}

RegExpMatch.__inner__ = function inner() {
  Object.defineProperties(this, {
    start: {
      get: function () {
        return this._start;
      },
    },
    end: {
      get: function () {
        return this._end;
      },
    },
    groupNames: {
      get: function () {
        return this._groupNames;
      },
    },
    groupCount: {
      get: function () {
        return Math.max(this._groups.length - 1, 0);
      },
    },
    input: {
      get: function () {
        return this._input;
      },
    },
    pattern: {
      get: function () {
        return this._pattern;
      },
    },
  });
  this._start = null;
  this._end = null;
  this._input = null;
  this._pattern = null;
  this._groups = {};
  this._groupNames = [];
  this._namedGroups = {};
};
RegExpMatch.prototype = {
  ctor: function (input, pattern, start, end, groups, groupNames, namedGroups) {
    this._start = start;
    this._end = end;
    this._input = input;
    this._pattern = pattern;
    this._groups = groups;
    this._groupNames = groupNames;
    this._namedGroups = namedGroups;
  },

  group: function (group) {
    return this._groups[group];
  },
  __op_idx__: function (group) {
    return this.group(group);
  },
  groups: function (groupIndices) {
    return groupIndices.map((idx) => this._groups[idx]);
  },
  namedGroup: function (name) {
    return this._namedGroups[name];
  },
};

global.RegExp = RegExp;
