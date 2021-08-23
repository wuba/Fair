/*
 * Copyright (C) 2005-present, 58.com.  All rights reserved.
 * Use of this source code is governed by a BSD type license that can be
 * found in the LICENSE file.
 */
require("./duration");
const __global__ = global;
function DateTime() {
  const inner = DateTime.__inner__;
  if (this == __global__) {
    return new DateTime({ __args__: arguments });
  } else {
    const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
    inner.apply(this, args);
    DateTime.prototype.ctor.apply(this, args);
    return this;
  }
}
DateTime.__inner__ = function inner() {
  Object.defineProperties(this, {
    millisecondsSinceEpoch: {
      get: function () {
        return +this.__date__;
      },
    },
    microsecondsSinceEpoch: {
      get: function () {
        return this.millisecondsSinceEpoch * 1000;
      },
    },
    timeZoneName: {
      get: function () {
        throw "Not Implemented: timeZoneName";
      },
    },
    timeZoneOffset: {
      get: function () {
        return this.__date__.getTimezoneOffset();
      },
    },
    year: {
      get: function () {
        return this.__date__.getFullYear();
      },
    },
    month: {
      get: function () {
        return this.__date__.getMonth() + 1;
      },
    },
    day: {
      get: function () {
        return this.__date__.getDate();
      },
    },
    hour: {
      get: function () {
        return this.__date__.getHours();
      },
    },
    minute: {
      get: function () {
        return this.__date__.getMinutes();
      },
    },
    second: {
      get: function () {
        return this.__date__.getSeconds();
      },
    },
    millisecond: {
      get: function () {
        return this.__date__.getMilliseconds();
      },
    },
    microsecond: {
      get: function () {
        return 0; // TODO: not supported
      },
    },
    weekday: {
      get: function () {
        let res = this.__date__.getDay();
        return !res ? DateTime.sunday : res;
      },
    },
    hashCode: {
      get: function () {
        const val = +this.__date__;
        return (val ^ (val >> 30)) & 0x3fffffff;
      },
    },
  });
  this.isUtc = null;

  this.__date__ = null;
};

function _fourDigits(n) {
  let absN = Math.abs(n);
  let sign = n < 0 ? "-" : "";
  if (absN >= 1000) return `${n}`;
  if (absN >= 100) return `${sign}0${absN}`;
  if (absN >= 10) return `${sign}00${absN}`;
  return `${sign}000${absN}`;
}

function _sixDigits(n) {
  let absN = Math.abs(n);
  let sign = n < 0 ? "-" : "+";
  if (absN >= 100000) return `${sign}${absN}`;
  return `${sign}0${absN}`;
}

function _threeDigits(n) {
  if (n >= 100) return `${n}`;
  if (n >= 10) return `0${n}`;
  return `00${n}`;
}

function _twoDigits(n) {
  if (n >= 10) return `${n}`;
  return `0${n}`;
}

DateTime.prototype = {
  ctor: function (
    year,
    month = 1,
    day = 1,
    hour = 0,
    minute = 0,
    second = 0,
    millisecond = 0,
    microsecond = 0
  ) {
    this.__date__ = new Date(
      year,
      month - 1,
      day,
      hour,
      minute,
      second,
      millisecond
    );
    this.isUtc = false;
  },
  __op_eq__: function (other) {},
  isBefore: function (other) {
    return this.__date__ < other.__date__;
  },
  isAfter: function (other) {
    return this.__date__ > other.__date__;
  },
  isAtSameMomentAs: function (other) {
    return this.__date__ == other.__date__;
  },
  compareTo: function (other) {
    if (this.isBefore(other)) {
      return -1;
    } else if (this.isAfter(other)) {
      return 1;
    } else {
      return 0;
    }
  },
  toLocal: function () {
    const res = new DateTime();
    if (!this.isUtc) {
      res.__date__ = this.__date__;
    } else {
      // TODO: 默认本地为中国时区
      res.__date__ = new Date(this.__date__ + 8 * 3600 * 1000);
    }
    return res;
  },
  toUtc: function () {
    const res = new DateTime();
    res.isUtc = true;
    if (this.isUtc) {
      res.__date__ = this.__date__;
    } else {
      // TODO: 默认本地为中国时区
      res.__date__ = new Date(this.__date__ - 8 * 3600 * 1000);
    }
    return res;
  },
  toString: function () {
    const __thiz__ = this;
    with (__thiz__) {
      let y = _fourDigits(year);
      let d = _twoDigits(day);
      let m = _twoDigits(month);
      let h = _twoDigits(hour);
      let min = _twoDigits(minute);
      let sec = _twoDigits(second);
      let ms = _threeDigits(millisecond);
      let us = microsecond == 0 ? "" : _threeDigits(microsecond);
      if (isUtc) {
        return `${y}-${m}-${d} ${h}:${min}:${sec}.${ms}${us}Z`;
      } else {
        return `${y}-${m}-${d} ${h}:${min}:${sec}.${ms}${us}`;
      }
    }
  },
  toIso8601String: function () {
    const __thiz__ = this;
    with (__thiz__) {
      let y =
        year >= -9999 && year <= 9999 ? _fourDigits(year) : _sixDigits(year);
      let m = _twoDigits(month);
      let d = _twoDigits(day);
      let h = _twoDigits(hour);
      let min = _twoDigits(minute);
      let sec = _twoDigits(second);
      let ms = _threeDigits(millisecond);
      let us = microsecond == 0 ? "" : _threeDigits(microsecond);
      if (isUtc) {
        return `${y}-${m}-${d}T${h}:${min}:${sec}.${ms}${us}Z`;
      } else {
        return `${y}-${m}-${d}T${h}:${min}:${sec}.${ms}${us}`;
      }
    }
  },
  add: function (duration) {
    var res = new DateTime();
    res.__date__ = new Date(+this.__date__.valueOf() + duration.inMilliseconds);
    return res;
  },
  subtract: function (duration) {
    var res = new DateTime();
    res.__date__ = new Date(this.__date__ - duration.inMilliseconds);
    return res;
  },
  difference: function (other) {
    return Duration({ milliseconds: this.__date__ - other.__date__ });
  },
};

Object.assign(DateTime, {
  monday: 1,
  tuesday: 2,
  wednesday: 3,
  thursday: 4,
  friday: 5,
  saturday: 6,
  sunday: 7,
  daysPerWeek: 7,

  january: 1,
  february: 2,
  march: 3,
  april: 4,
  may: 5,
  june: 6,
  july: 7,
  august: 8,
  september: 9,
  october: 10,
  november: 11,
  december: 12,
  monthsPerYear: 12,
});

DateTime.utc = function (
  year,
  month = 1,
  day = 1,
  hour = 0,
  minute = 0,
  second = 0,
  millisecond = 0,
  microsecond = 0
) {
  this.__date__ = new Date(
    year,
    month - 1,
    day,
    hour,
    minute,
    second,
    millisecond
  );
  this.isUtc = true;
};

DateTime.now = function () {
  var res = new DateTime();
  res.__date__ = new Date();
  return res;
};

DateTime.parse = function (formattedString) {
  var re =
    /^([+-]?\d{4,6})-?(\d\d)-?(\d\d)(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$/;
  var match = formattedString.match(re);
  if (match != null) {
    function parseIntOrZero(matched) {
      if (matched == null) return 0;
      return int.parse(matched);
    }

    // Parses fractional second digits of '.(\d+)' into the combined
    // microseconds. We only use the first 6 digits because of DateTime
    // precision of 999 milliseconds and 999 microseconds.
    function parseMilliAndMicroseconds(matched) {
      if (matched == null) return 0;
      let length = matched.length;
      assert(length >= 1);
      let result = 0;
      for (let i = 0; i < 6; i++) {
        result *= 10;
        if (i < matched.length) {
          result += matched.codePointAt(i) ^ 0x30;
        }
      }
      return result;
    }

    let years = int.parse(match[1]);
    let month = int.parse(match[2]);
    let day = int.parse(match[3]);
    let hour = parseIntOrZero(match[4]);
    let minute = parseIntOrZero(match[5]);
    let second = parseIntOrZero(match[6]);
    let milliAndMicroseconds = parseMilliAndMicroseconds(match[7]);
    let millisecond =
      (milliAndMicroseconds / Duration.microsecondsPerMillisecond) >> 0;
    let microsecond =
      milliAndMicroseconds % Duration.microsecondsPerMillisecond;
    let isUtc = false;
    if (match[8] != null) {
      // timezone part
      isUtc = true;
      let tzSign = match[9];
      if (tzSign != null) {
        // timezone other than 'Z' and 'z'.
        let sign = tzSign == "-" ? -1 : 1;
        let hourDifference = int.parse(match[10]);
        let minuteDifference = parseIntOrZero(match[11]);
        minuteDifference += 60 * hourDifference;
        minute -= sign * minuteDifference;
      }
    }
    let res = DateTime(
      years,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond
    );
    res.isUtc = isUtc;
    return res;
  } else {
    throw "Invalid date format" + formattedString;
  }
};

DateTime.tryParse = function (formattedString) {
  try {
    return DateTime.parse(formattedString);
  } catch {
    return null;
  }
};

DateTime.fromMillisecondsSinceEpoch = function (
  millisecondsSinceEpoch,
  { isUtc = false } = {}
) {
  var res = new DateTime();
  res.__date__ = new Date(millisecondsSinceEpoch);
  res.isUtc = isUtc;
};

DateTime.fromMicrosecondsSinceEpoch = function (
  microsecondsSinceEpoch,
  { isUtc = false } = {}
) {
  return DateTime.fromMillisecondsSinceEpoch(
    (microsecondsSinceEpoch / 1000) >> 0,
    isUtc
  );
};

global.DateTime = DateTime;
