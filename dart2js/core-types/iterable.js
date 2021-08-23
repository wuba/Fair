/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */

function Iterable() {}

Iterable.prototype = Object.create(
  {
    followedBy: function (other) {
      return this.concat(other);
    },
    where: function (test) {
      return this.filter(test);
    },
    whereType: function () {
      throw "Not Implemented: whereType";
    },
    expand: function (f) {
      let res = [];
      this.map(f).forEach((elem) => {
        res.addAll(elem);
      });
      return res;
    },
    contains: function (element) {
      return this.includes(element);
    },
    // map / forEach / reduce / every
    // join 默认参数为空字串，而不是,
    fold: function (initialValue, combine) {
      return this.reduce(combine, initialValue);
    },
    any: function (test) {
      return this.some(test);
    },
    toList: function ({ growable = true } = {}) {
      return this;
    },
    toSet: function () {
      throw "Not Implemented: toSet";
    },
    take: function (count) {
      return this.slice(0, count);
    },
    takeWhile: function (test) {
      let res = [];
      for (let i = 0; i < this.length; i++) {
        if (test(this[i])) {
          res.push(this[i]);
        } else {
          break;
        }
      }
      return res;
    },
    skip: function (count) {
      return this.slice(count);
    },
    skipWhile: function (test) {
      let res = [];
      for (let i = 0; i < this.length; i++) {
        if (!test(this[i])) {
          res = this.slice(i);
          break;
        }
      }
      return res;
    },
    firstWhere: function (test, { orElse } = {}) {
      let res = this.find(test);
      if (!res) {
        if (orElse) {
          return orElse();
        } else {
          throw "StateError";
        }
      } else {
        return res;
      }
    },
    lastWhere: function (test, { orElse } = {}) {
      for (let i = this.length - 1; i >= 0; i--) {
        if (test(this[i])) {
          return this[i];
        }
      }
      if (orElse) {
        return orElse();
      } else {
        throw "StateError";
      }
    },
    singleWhere: function (test, { orElse } = {}) {
      let res = this.filter(test);
      if (res && res.length == 1) {
        return res[0];
      } else {
        if (orElse) {
          return orElse();
        } else {
          throw "StateError";
        }
      }
    },
    elementAt: function (index) {
      if (index < 0 || index >= this.length) {
        throw "Error";
      }
      return this[index];
    },
    toString: function () {
      throw "NotImplemented: toString";
    },
  },
  {
    single: {
      get: function () {
        if (this.length == 1) {
          return this[0];
        } else {
          throw "StateError";
        }
      },
    },
    isEmpty: {
      get: function () {
        return !this.length;
      },
    },
    isNotEmpty: {
      get: function () {
        return !this.isEmpty;
      },
    },
  }
);

global.Iterable = Iterable;
