/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

Object.defineProperties(String.prototype, {
  codeUnits: {
    get: function () {
      var codeArr = [];
      var strArr = this.split("");
      for (var i = 0; i < strArr.length; i++) {
        codeArr.push(this.charCodeAt(i));
      }
      return codeArr;
    },
  },
  // hashCode: {
  //     get: function(){

  //     }
  // },
  isEmpty: {
    get: function () {
      return !this.length;
    },
  },
  isNotEmpty: {
    get: function () {
      return this.length;
    },
  },
  // runes: {
  //     get: function(){

  //     }
  // },
  runtimeType: {
    get: function () {},
  },
});

// String.prototype.allMatches = function(reg) {

// }
String.prototype.codeUnitAt = function (i) {
  // 返回索引处的ascii
  return this.charCodeAt(i);
};

String.prototype.compareTo = function (other) {
  // 依次对比指定索引字段在ascii中字符串值比较大小 0相等 1大于 -1小于
  for (var i = 0; i < this.length; i++) {
    if (this.charCodeAt(i) != other.charCodeAt(i)) {
      return this.charCodeAt(i) > other.charCodeAt(i) ? 1 : -1;
    } else {
      if (i == this.length - 1 && i == other.length - 1) {
        return 0;
      } else if (i == this.length - 1 && i != other.length - 1) {
        return -1;
      } else if (i != this.length - 1 && i == other.length - 1) {
        return 1;
      }
      continue;
    }
  }
};

String.prototype.contains = function (other) {
  // 是否包含
  return this.includes(other);
};

// String.prototype.matchAsPrefix = function(string) {

// }

String.prototype.padLeft = function (width) {
  // 传入长度，从左侧填充空格
  return this.padStart(width, " ");
};
String.prototype.padRight = function (width) {
  // 传入长度，从右侧填充空格
  return this.padEnd(width, " ");
};
String.prototype.replaceAllMapped = function (from, replaceFn) {
  // 可传方法返回值替换指定字符串
  return this.replaceAll(from, replaceFn);
};
String.prototype.replaceFirst = function (from, replace) {
  // 替换第一个
  return this.replace(from, replace);
};
String.prototype.replaceFirstMapped = function (from, replaceFn) {
  // 替换第一个，可传function
  return this.replace(from, replaceFn);
};
String.prototype.replaceRange = function (start, end, replacement) {
  // 指定起始位置替换
  return this.substr(0, start) + replacement + this.substr(end, this.length);
};
String.prototype.splitMapJoin = function (pattern, onMatch, onNonMatch) {
  // 查询指定字符，用onMatch的返回值替换“，”用onNonMatch的返回值替换其他
  if (this.split(pattern).length == 1) {
    return onNonMatch() ? onNonMatch() : this;
  } else {
    var splitArrLen = this.split(pattern).length;
    var array = new Array(splitArrLen).fill(onNonMatch());
    return array.join(onMatch());
  }
};
global.String = String;
