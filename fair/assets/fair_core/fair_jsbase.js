let global = this;
function inherit(cls, sup) {
    var oldProto = cls.prototype;
    cls.prototype = Object.create(Object.create(sup.prototype));
    Object.assign(cls.prototype, oldProto);
    cls.prototype.constructor = cls;
    cls.prototype.$superSubstitution = cls.prototype.__proto__;
}

function convertObjectLiteralToSetOrMap(obj) {
  let isSet = Object.prototype.toString.call(obj) == "[object Array]";
  if (!isSet) {
    function convertToMap(obj_) {
      const t = Object.prototype.toString.call(obj_);
      if (t == "[object Array]") {
        return obj_.map((item) => convertToMap(item));
      } else if (t == "[object Object]") {
        let keys = Object.getOwnPropertyNames(obj_);
        let res = new Map();
        keys.forEach((k) => res.set(k, convertToMap(obj_[k])));
        return res;
      } else {
        return obj_;
      }
    }
    return convertToMap(obj);
  } else {
    let res = new Set();
    obj.forEach((item) => res.add(item));
    return res;
  }
}

Object.prototype.ctor = function(){};
Object.__inner__ = function(){};

;(function(){
const __global__ = this;

function Duration() {
    const inner = Duration.__inner__;
    if (this == __global__) {
        return new Duration({ __args__: arguments });
    } else {
        const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
        inner.apply(this, args);
        Duration.prototype.ctor.apply(this, args);
        return this;
    }
}

Duration.__inner__ = function inner() {
    Object.defineProperties(this, {
        inDays: {
            get: () => (this._duration / Duration.microsecondsPerDay)>>0,
        },
        inHours: {
            get: () => (this._duration / Duration.microsecondsPerHour) >> 0,
        },
        inMinutes: {
            get: () => (this._duration / Duration.microsecondsPerMinute) >> 0,
        },
        inSeconds: {
            get: () => (this._duration / Duration.microsecondsPerSecond) >> 0,
        },
        inMilliseconds: {
            get: () => (this._duration / Duration.microsecondsPerMillisecond) >> 0,
        },
        inMicroseconds: {
            get: () => this._duration,
        },
        hashCode: {
            get: () => this._duration.hashCode,
        },
        isNegative: {
            get: () => this._duration < 0,
        }
    });
    this._duration = null;
};

Duration.prototype = {
    ctor: function ({ days = 0, hours = 0, minutes = 0, seconds = 0, milliseconds = 0, microseconds = 0 } = {}) {
        const __thiz__ = this;
        const __arg_ctx__ = {days, hours, minutes, seconds, milliseconds, microseconds};
        with (Duration) {
            with (__thiz__) {
                with (__arg_ctx__) {
                    Duration._microseconds.call(__thiz__, microsecondsPerDay * days +
                        microsecondsPerHour * hours +
                        microsecondsPerMinute * minutes +
                        microsecondsPerSecond * seconds +
                        microsecondsPerMillisecond * milliseconds +
                        microseconds);
                }
            }
        }
    },
    __op_add__: function(other) {
        return Duration._microseconds(this._duration + other._duration);
    },
    __op_minus__: function(other) {
        return Duration._microseconds(this._duration - other._duration);
    },
    __op_multi__: function(factor) {
        return Duration._microseconds(Math.round(this._duration * factor));
    },
    __op_idivide__: function (quotient) {
        return Duration._microseconds((this._duration / quotient)>>0);
    },
    __op_lt__: function (other) { return this._duration < other._duration; },
    __op_gt__: function (other) { return this._duration < other._duration; },
    __op_lte__: function (other) { return this._duration <= other._duration; },
    __op_gte__: function (other) { return this._duration >= other._duration; } ,
    __op_eq__: function (other) { return other && this._duration == other._duration; },
    __op_ngt__: function () { return Duration._microseconds(-this._duration) },
    compareTo: function (other) { return this._duration.compareTo(other._duration); },
    toString: function() {
        function sixDigits(n) {
            if (n >= 100000) return `${n}`;
            if (n >= 10000) return `0${n}`;
            if (n >= 1000) return `00${n}`;
            if (n >= 100) return `000${n}`;
            if (n >= 10) return `0000${n}`;
            return `00000${n}`;
        }

        function twoDigits(n) {
            if (n >= 10) return `${n}`;
            return `0${n}`;
        }

        let __thiz__ = this;
        with (Duration) {
            with (__thiz__) {
                if (inMicroseconds < 0) {
                    return `-${this.__op_ngt__()}`;
                }
                let twoDigitMinutes =
                    twoDigits(inMinutes % minutesPerHour);
                let twoDigitSeconds =
                    twoDigits(inSeconds % secondsPerMinute);
                let sixDigitUs =
                    sixDigits(inMicroseconds % microsecondsPerSecond);
                return `${inHours}:${twoDigitMinutes}:${twoDigitSeconds}.${sixDigitUs}`;
            }
        }
    },
    abs: function () { return Duration._microseconds(this._duration.abs()); }
};

const staticFields = {
    microsecondsPerMillisecond: 1000,
    millisecondsPerSecond: 1000,
    secondsPerMinute: 60,
    minutesPerHour: 60,
    hoursPerDay: 24,
};
Duration._microseconds = function (arg1) {
    const res = (this instanceof Duration) ? this : new Duration();
    res._duration = arg1;
    return res;
}
Object.assign(Duration, staticFields);
Duration.microsecondsPerSecond = Duration.microsecondsPerMillisecond * Duration.millisecondsPerSecond;
Duration.microsecondsPerMinute = Duration.microsecondsPerSecond * Duration.secondsPerMinute;
Duration.microsecondsPerHour = Duration.microsecondsPerMinute * Duration.minutesPerHour;
Duration.microsecondsPerDay = Duration.microsecondsPerHour * Duration.hoursPerDay;

Duration.millisecondsPerMinute = Duration.millisecondsPerSecond * Duration.secondsPerMinute;
Duration.millisecondsPerHour = Duration.millisecondsPerMinute * Duration.minutesPerHour;
Duration.millisecondsPerDay = Duration.millisecondsPerHour * Duration.hoursPerDay;
Duration.secondsPerHour = Duration.secondsPerMinute * Duration.minutesPerHour;
Duration.secondsPerDay = Duration.secondsPerHour * Duration.hoursPerDay;
Duration.minutesPerDay = Duration.minutesPerHour * Duration.hoursPerDay;
Duration.zero = Duration({seconds: 0});

global.Duration = Duration;})()
;(function(){
function Iterable() {}

Iterable.prototype = Object.create({
    followedBy: function(other) {
        return this.concat(other);
    },
    where: function(test) {
        return this.filter(test);
    },
    whereType: function() {
        throw 'Not Implemented: whereType';
    },
    expand: function(f) {
        let res = [];
        this.map(f).forEach(elem => {
            res.addAll(elem);
        });
        return res;
    },
    contains: function(element) {
        return this.includes(element);
    },
    // map / forEach / reduce / every
    // join 默认参数为空字串，而不是,
    fold: function (initialValue, combine) {
        return this.reduce(combine, initialValue);
    },
    any: function(test) {
        return this.some(test);
    },
    toList: function ({ growable = true} = {}) {
        return this;
    },
    toSet: function() {
        throw 'Not Implemented: toSet';
    },
    take: function(count) {
        return this.slice(0, count);
    },
    takeWhile: function(test) {
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
    skip: function(count) {
        return this.slice(count);
    },
    skipWhile: function(test) {
        let res = [];
        for (let i = 0; i < this.length; i++) {
            if (!test(this[i])) {
                res = this.slice(i);
                break;
            }
        }
        return res;
    },
    firstWhere: function(test, {orElse} = {}) {
        let res = this.find(test);
        if (!res) {
            if (orElse) {
                return orElse();
            } else {
                throw 'StateError';
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
            throw 'StateError';
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
                throw 'StateError';
            }
        }
    },
    elementAt: function(index) {
        if (index < 0 || index >= this.length) {
            throw 'Error';
        }
        return this[index];
    },
    toString: function() {
        throw 'NotImplemented: toString';
    }
}, {
    single: {
        get: function() {
            if (this.length == 1) {
                return this[0];
            } else {
                throw 'StateError';
            }
        }
    },
    isEmpty: {
        get: function() {
            return !this.length;
        }
    },
    isNotEmpty: {
        get: function () {
            return !this.isEmpty;
        }
    },

});

global.Iterable = Iterable;})()
;(function(){
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
            get: function() {
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
                throw 'Not Implemented: timeZoneName';
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
                return (val ^ (val >> 30)) & 0x3FFFFFFF;
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
    ctor: function(year, month = 1, day = 1, hour = 0, minute = 0, second = 0, millisecond = 0, microsecond = 0) {
        this.__date__ = new Date(year, month - 1, day, hour, minute, second, millisecond);
        this.isUtc = false;
    },
    __op_eq__: function(other) {

    },
    isBefore: function (other) {
        return this.__date__ < other.__date__;
    },
    isAfter: function (other) {
        return this.__date__ > other.__date__;
    },
    isAtSameMomentAs: function (other) {
        return this.__date__ == other.__date__;
    },
    compareTo: function(other) {
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
            res.__date__ = new Date(this.__date__ + (8 * 3600 * 1000));
        }
        return res;
    },
    toUtc: function() {
        const res = new DateTime();
        res.isUtc = true;
        if (this.isUtc) {
            res.__date__ = this.__date__;
        } else {
            // TODO: 默认本地为中国时区
            res.__date__ = new Date(this.__date__ - (8 * 3600 * 1000));
        }
        return res;
    },
    toString: function () {
        const __thiz__ = this;
        with(__thiz__) {
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
    toIso8601String: function() {
        const __thiz__ = this;
        with (__thiz__) {
            let y =
                (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
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
    subtract: function(duration) {
        var res = new DateTime();
        res.__date__ = new Date(this.__date__ - duration.inMilliseconds);
        return res;
    },
    difference: function(other) {
        return Duration({ milliseconds: this.__date__ - other.__date__});
    },

}

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

DateTime.utc = function (year, month = 1, day = 1, hour = 0, minute = 0, second = 0, millisecond = 0, microsecond = 0) {
    this.__date__ = new Date(year, month - 1, day, hour, minute, second, millisecond);
    this.isUtc = true;
};

DateTime.now = function() {
    var res = new DateTime();
    res.__date__ = new Date();
    return res;
}

DateTime.parse = function (formattedString) {
    var re = /^([+-]?\d{4,6})-?(\d\d)-?(\d\d)(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$/;
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
        let microsecond = milliAndMicroseconds % Duration.microsecondsPerMillisecond;
        let isUtc = false;
        if (match[8] != null) {
            // timezone part
            isUtc = true;
            let tzSign = match[9];
            if (tzSign != null) {
                // timezone other than 'Z' and 'z'.
                let sign = (tzSign == '-') ? -1 : 1;
                let hourDifference = int.parse(match[10]);
                let minuteDifference = parseIntOrZero(match[11]);
                minuteDifference += 60 * hourDifference;
                minute -= sign * minuteDifference;
            }
        }
        let res = DateTime(years, month, day, hour, minute, second, millisecond, microsecond);
        res.isUtc = isUtc;
        return res;
    } else {
        throw "Invalid date format" + formattedString;
    }
}

DateTime.tryParse = function (formattedString) {
    try {
        return DateTime.parse(formattedString);
    } catch {
        return null;
    }
}

DateTime.fromMillisecondsSinceEpoch = function (millisecondsSinceEpoch, {isUtc = false} = {}) {
    var res = new DateTime();
    res.__date__ = new Date(millisecondsSinceEpoch);
    res.isUtc = isUtc;
}

DateTime.fromMicrosecondsSinceEpoch = function (microsecondsSinceEpoch, { isUtc = false } = {}) {
    return DateTime.fromMillisecondsSinceEpoch((microsecondsSinceEpoch / 1000) >> 0, isUtc);
}

global.DateTime = DateTime;})()
;(function(){
// 仅支持list与list对象的交互
// 不支持
// 自定义Iterable对象
// 不可变list

let oldProto = Array.prototype;
oldProto.__proto__ = Iterable.prototype;
Array.prototype = Object.create(oldProto);
Object.assign(Array.prototype, {
    cast: function () {
        return this;
    },
    __op_idx__: function (index) {
        return this[index];
    },
    __op_idxeq__: function (index, value) {
        this[index] = value;
    },
    add: function (value) {
        this.push(value);
    },
    addAll: function (iterable) {
        iterable.forEach(item => this.push(item));
    },
    shuffle: function (random) {
        throw 'Not Implemented: shuffle';
    },
    // indexOf / lastIndexOf / length
    indexWhere: function (test, start = 0) {
        for (let i = start; i < this.length; i++) {
            if (test(this[i])) {
                return i;
            }
        }
        return -1;
    },
    lastIndexWhere: function (test, start) {
        if (start === undefined) {
            start = this.length - 1;
        }
        for (let i = start; i >= 0; i++) {
            if (test(this[i])) {
                return i;
            }
        }
        return -1;
    },
    clear: function () {
        this.length = 0;
    },
    insert: function (index, element) {
        this.splice(index, 0, element);
    },
    insertAll: function (index, iterable) {
        let args = [index, 0].concat(iterable);
        this.splice.apply(this, args);
    },
    setAll: function (index, iterable) {
        if (index < 0 || index > this.length ||
            index + iterable.length > this.length) {
            throw 'error';
        }
        for (let i = index, j = 0; i < this.length && j < iterable.length; i++, j++) {
            this[i] = iterable[j];
        }
    },
    remove: function (value) {
        let idx = this.indexOf(value);
        if (idx > -1) {
            this.splice(idx, 1);
            return true;
        } else {
            return false;
        }
    },
    removeAt: function (index) {
        this.splice(index, 1);
    },
    removeLast: function () {
        this.length = this.length - 1;
    },
    removeWhere: function (test) {
        let i = 0;
        while (i < this.length) {
            if (test(this[i])) {
                this.splice(i, 1);
            } else {
                i++;
            }
        }
    },
    retainWhere: function (test) {
        let i = 0;
        while (i < this.length) {
            if (!test(this[i])) {
                this.splice(i, 1);
            } else {
                i++;
            }
        }
    },
    __op_add__: function (other) {
        return this.concat(other);
    },
    sublist: function (start, end) {
        return this.slice(start, end);
    },
    getRange: function (start, end) {
        return this.slice(start, end);
    },
    setRange: function (start, end, iterable, skipCount = 0) {
        if (start < 0 || start >= this.length ||
            end < 0 || end >= this.length ||
            start >= end) {
                throw 'error';
            }
        let length = end - start;
        if (skipCount + length >= iterable.length) {
            throw 'error';
        }

        for (let i = end - 1, j = skipCount + length - 1; i >= start; i--, j--) {
            this[i] = iterable[j];
        }
    },
    removeRange: function (start, end) {
        if (start < 0 || start >= this.length ||
            end < 0 || end >= this.length ||
            start >= end) {
            throw 'error';
        }
        while (start < end) {
            this.splice(start, 1);
            end--;
        }
    },
    fillRange: function (start, end, fillValue) {
        if (start < 0 || start >= this.length ||
            end < 0 || end >= this.length) {
            throw 'error';
        }
        while (start < end) {
            this[start] = fillValue || null;
            start++;
        }
    },
    replaceRange: function (start, end, replacement) {
        if (start < 0 || start >= this.length ||
            end < 0 || end >= this.length ||
            start >= end) {
            throw 'error';
        }
        this.removeRange(start, end);
        this.insertAll(start, replacement);
    },
    asMap: function () {
        let res = {};
        for (let i = 0; i < this.length; i++) {
            res[i] = this[i];
        }
        return res;
    }
});

Object.defineProperties(Array.prototype, {
    // length
    first: {
        set: function (value) {
            this[0] = value;
        },
        get: function () {
            return this[0];
        },
    },
    last: {
        set: function (value) {
            this[this.length - 1] = value;
        },
        get: function () {
            return this[this.length - 1];
        },
    },
    reversed: {
        get: function() {
            return this.slice(0).reverse();
        }
    },

});

Array.filled = function (length, fill, { growable = false} = {}) {
    let res = new Array(length);
    for (let i = 0; i < length; i++) {
        res[i] = fill;
    }
    return res;
};

Array.empty = function ({ growable = false } = {}) {
    return [];
};

Array.from = function (elements, { growable = true } = {}) {
    return elements.slice(0);
};

Array.of = function (elements, { growable = true } = {}) {
    return elements.slice(0);
};

Array.generate = function (length, generator, { growable = true } = {}) {
    let res = new Array(length);
    for (let i = 0; i < length; i++) {
        res[i] = generator(i);
    }
    return res;
};

Array.unmodifiable = function (elements) {
    return elements.slice(0);
};

Array.castFrom = function(source) {
    return source;
};

Array.copyRange = function(target, at, source, start, end) {
    if (!start) {
        start = 0;
    }
    if (end === undefined) {
        end = source.length;
    }
    let length = end - start;
    if (target.length < at + length) {
        throw `Not big enough to hold ${length} elements at position ${at}`;
    }
    for (let i = length; --i >= 0;) {
        target[at + i] = source[start + i];
    }
};

Array.writeIterable = function (target, at, source) {
    target.setAll(at, source);
};



global.List = Array;})()
;(function(){
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
    ctor: function(key, value) {
        this.key = key;
        this.value = value;
    },
    toString: function() {
        return `MapEntry(${key.toString()}: ${value.toString()})`;
    }
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
            return Array.from(oldMapPrototype.entries.call(this)).map(item => MapEntry(item[0], item[1]));
        },
    },
    keys: {
        get: function () {
            return Array.from(oldMapPrototype.keys.call(this));
        },
    },
    values: {
        get: function () {
            return Array.from(oldMapPrototype.values.call(this));
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
    }
});

Object.assign(Map.prototype, {
    cast: function() {
        return this;
    },
    __op_idx__: function(key) {
        return this.get(key);
    },
    __op_idxeq__: function (key, value) {
        this.set(key, value);
    },
    containsValue: function(value) {
        return this.values.includes(value);
    },
    containsKey: function(value) {
        return this.has(value);
    },
    map: function(convert) {
        var res = new Map();
        this.forEach((key, value) => {
            var entry = convert(key, value);
            res.set(entry.key, entry.value);
        })
        return res;
    },
    addEntries: function (newEntries) {
        for (let i = 0; i < newEntries.length; i++) {
            this.set(newEntries[i].key, newEntries[i].value);
        }
    },
    update: function(key, update, {ifAbsent}={}) {
        var newVal = null;
        if (this.has(key)) {
            newVal = update(this.get(key));
            this.set(key, newVal);
        } else {
            if (ifAbsent) {
                newVal = ifAbsent();
                this.set(key, newVal);
            } else {
                throw 'Error';
            }
        }
        return newVal;
    },
    updateAll: function (update) {
        this.keys.forEach(k => {
            this.set(k, update(k, this.get(k)));
        });
    },
    removeWhere: function(test) {
        var i = 0;
        var keys = this.keys.slice(0);
        while ( i < this.size) {
            if (test(keys[i], this.get(keys[i]))) {
                this.delete(keys[i]);
                keys.splice(i, 1);
            } else {
                i++;
            }
        }
    },
    putIfAbsent: function(key, ifAbsent) {
        if (!this.has(key)) {
            this.set(key, ifAbsent());
        }
        return this.get(key);
    },
    addAll: function(other) {
        let __thiz__ = this;
        other.forEach((key, value) => {
            __thiz__.set(key, value);
        });
    },
    remove: function(key) {
        if (this.has(key)) {
            var res = this.get(key);
            this.delete(key);
            return res;
        }
        return null;
    },
    // clear

    forEach: function(action) {
        this.entries.forEach(e => action(e.key, e.value));
    }
});

Map.from = function(other) {
    var res = new Map();
    other.forEach((key, value) => res.set(key, value));
    return res;
};

Map.of = function(other) {
    return Map.from(other);
};

Map.unmodifiable = function(other) {
    return Map.from(other);
};

Map.identity = function() {
    throw 'Not Implemented: identity';
};

Map.fromIterable = function(arg1, arg2) {
    if (args2.length) {
        let keys = arg1;
        let values = arg2;
        if (keys.length != values.length) {
            throw 'Error';
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

Map.fromEntries = function(entries) {
    var res = new Map();
    for (let i = 0; i < entries.length; i++) {
        res.set(entries[i].key, entries[i].value);
    }
    return res;
};

Map.castFrom = function(source) {
    return source;
};

})()
;(function(){

Set.prototype.__proto__ = Iterable.prototype;
Object.assign(Set.prototype, {
    cast: function() {
        return this;
    },
    contains: function (value) {
        return this.has(value);
    },
    // add / clear
    addAll: function(elements) {
        elements.toList().forEach(elem => this.add(elem));
    },
    remove: function(value) {
        return this.delete(value);
    },
    lookup: function(object) {
        if (this.has(object)) {
            return object;
        }
        return null;
    },
    removeAll: function(elements) {
        elements.toList().forEach(elem => this.delete(elem));
    },
    retainAll: function(elements) {
        let values = Array.nativeFrom(this.values());
        for (let v of values) {
            if (!elements.contains(v)) {
                this.delete(v);
            }
        }
    },
    removeWhere: function (test) {
        let values = Array.nativeFrom(this.values());
        for (let v of values) {
            if (test(v)) {
                this.delete(v);
            }
        }
    },
    retainWhere: function (test) {
        let values = Array.nativeFrom(this.values());
        for (let v of values) {
            if (!test(v)) {
                this.delete(v);
            }
        }
    },
    containsAll: function (other) {
        let arr = other.toList();
        for (let v of arr) {
            if (!this.has(v)) {
                return false;
            }
        }
        return true;
    },
    intersection: function (other) {
        let res = new Set();
        for (let v of other) {
            if (this.has(v)) {
                res.add(v);
            }
        }
        return res;
    },
    union: function (other) {
        let res = new Set();
        res.addAll(this);
        res.addAll(other);
        return res;
    },
    difference: function (other) {
        let res = new Set();
        for (let v of this) {
            if (!other.has(v)) {
                res.add(v);
            }
        }
        return res;
    },
    toSet: function() {
        let res = new Set();
        res.addAll(this);
        return res;
    }
});

Object.defineProperties(Set.prototype, {
    iterator: {
        get: function() {
            throw 'Not Implemented: iterator';
        }
    },
    __iterable__: {
        get: function() {
            return Array.nativeFrom(this.values());
        }
    },
    length: {
        get: function() {
            return this.size;
        }
    }
});

Set.identify = function() {

};

Set.from = function () {

};

Set.of = function () {

};

Set.unmodifiable = function () {

};

Set.castFrom = function () {

};})()
;(function(){


Object.defineProperties(Number.prototype, {
    // bitLength: {

    // },
    isEven: {
        get: function(){
            return this%2 == 0 ? true:false
        }
    },
    isOdd: {
        get: function(){
            return this%2 == 0 ? false:true
        }
    },
    sign: {
        get: function(){
            // 符号 正数1、负数-1和0
            return this!=0 ? Math.abs(this) != this ? -1 : 1 : 0
        }
    },
    // hashCode: {
    //     get: function(){

    //     }
    // },
    isFinite: {
        get: function(){
            // 是否有限
            return isFinite(this)
        }
    },
    isInfinite: {
        get: function(){
            // 是否无穷
            return !isFinite(this)
        }
    },
    isNaN: {
        get: function(){
            // 是否NaN
            return isNaN(this)
        }
    },
    isNegative: {
        get: function(){
            // 是否为负数
            return this<0 ? true:false
        }
    },
    runtimeType: {
        get: function(){
            // 运行时的类型 ？？ 待定
            return typeof this
        }
    }
})

Number.prototype.abs = function() {
    return Math.abs(this)
}
Number.prototype.ceil = function() {
    return Math.ceil(this)
}
Number.prototype.ceilToDouble = function() {
    return (Math.ceil(this)).toFixed(1)
}
Number.prototype.clamp = function(lowerLimit, upperLimit) {
    return this < lowerLimit ? lowerLimit : this > upperLimit ? upperLimit : Number(this);
}
Number.prototype.compareTo = function(other) {
    return this < other ? -1 : 1
}
Number.prototype.floor = function() {
    // 向下取整
    return Math.floor(this)
}
Number.prototype.floorToDouble = function() {
    // 向下取整转浮点
    return (Math.floor(this)).toFixed(1)
}
Number.prototype.remainder = function(other) {
    // 取余
    return this%other
}
Number.prototype.round = function() {
    // 四舍五入
    return Math.round(this)
}
Number.prototype.roundToDouble = function() {
    // 四舍五入转浮点
    return (Math.round(this)).toFixed(1)
}
Number.prototype.toDouble = function() {
    // 转浮点
    return this != Math.floor(this) ? Number(this) : this.toFixed(1)
}
Number.prototype.toInt = function() {
    // 取整数部分
    return parseInt(this)
}
Number.prototype.toStringAsExponential = function(n) {
    // 返回几次幂值的字符串(科学记数法)
    return this.toExponential(n)
}
Number.prototype.toStringAsFixed = function(n) {
    // 保留n位小数
    return this.toFixed(n)
}
Number.prototype.toStringAsPrecision = function(n) {
    // 保留几位小数后精确结果的字符串
    return this.toPrecision(n)
}
Number.prototype.truncate = function() {
    // 取整
    return  parseInt(this)
}
Number.prototype.truncateToDouble = function() {
    // 取整返回浮点型
    return parseInt(this).toFixed(1)
}

// 定义原始类型方法
Number.parse = function(source){
    // 只转整数，小数报错
    if( parseInt(source) == source ){
        return parseInt(source);
    }
    else{
        throw 'FormatException: Invalid radix-10 number';
    }
}
Number.tryParse = function(source){
    if( parseInt(source) == source ){
        return parseInt(source);
    }
    else{
        return null;
    }
}
global.Number = Number;
})()
;(function(){
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
    ctor: function (source, { multiLine = false, caseSensitive = true, unicode = false, dotAll = false} = {}) {
        let flag = 'g';
        if (multiLine) {
            flag += 'm';
        }
        if (!caseSensitive) {
            flag += 'i';
        }
        if (unicode) {
            flag += 'u';
        }
        if (dotAll) {
            flag += 's';
        }
        this.__regex__ = new NativeRegExp(source, flag);
    },
    allMatches: function(string, start = 0) {
        this.__regex__.lastIndex = start;
        let matches = [];
        let m = this.__firstMatch__(string);
        while (m) {
            matches.push(m);
            m = this.__firstMatch__(string);
        }
        this.__regex__.lastIndex = 0;
        return (!matches.length) ? null : matches;
    },
    matchAsPrefix: function(string, start = 0) {
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
        return RegExpMatch(input, this, start, end, groups, groupNames, namedGroups);
    },
    hasMatch: function(input) {
        let res = this.__regex__.test(input);
        this.__regex__.lastIndex = 0;
        return res;
    },
    stringMatch: function(input) {
        let res = this.__regex__.exec(input);
        if (!res || !res.length) {
            return null;
        }
        this.__regex__.lastIndex = 0;
        return res[0];
    },

};

RegExp.escape = function (text) {
    return text.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
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
            get: function() {
                return this._start;
            }
        },
        end: {
            get: function () {
                return this._end;
            }
        },
        groupNames: {
            get: function () {
                return this._groupNames;
            },
        },
        groupCount: {
            get: function () {
                return Math.max(this._groups.length - 1, 0);
            }
        },
        input: {
            get: function () {
                return this._input;
            }
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

    group: function(group) {
        return this._groups[group];
    },
    __op_idx__: function(group) {
        return this.group(group);
    },
    groups: function (groupIndices) {
        return groupIndices.map(idx => this._groups[idx]);
    },
    namedGroup: function(name) {
        return this._namedGroups[name];
    },
};

global.RegExp = RegExp;})()
;(function(){

Object.defineProperties(String.prototype, {
    codeUnits: {
        get: function(){
            var codeArr = [];
            var strArr = this.split('');
            for( var i = 0; i < strArr.length; i++ ){
                codeArr.push(this.charCodeAt(i))
            }
            return codeArr
        }
    },
    // hashCode: {
    //     get: function(){

    //     }
    // },
    isEmpty: {
        get: function(){
            return !this.length
        }
    },
    isNotEmpty: {
        get: function(){
            return this.length
        }
    },
    // runes: {
    //     get: function(){

    //     }
    // },
    runtimeType: {
        get: function(){

        }
    },
})

// String.prototype.allMatches = function(reg) {

// }
String.prototype.codeUnitAt = function(i) {
    // 返回索引处的ascii
    return this.charCodeAt(i)
}

String.prototype.compareTo = function(other) {
    // 依次对比指定索引字段在ascii中字符串值比较大小 0相等 1大于 -1小于
    for( var i = 0; i < this.length; i++ ){
        if( this.charCodeAt(i) != other.charCodeAt(i) ){
            return this.charCodeAt(i)>other.charCodeAt(i) ? 1 : -1
        }
        else{
            if( i == this.length-1 && i == other.length-1 ){
                return 0
            }else if( i == this.length-1 && i != other.length-1 ){
                return -1
            }
            else if(i != this.length-1 && i == other.length-1 ){
                return 1
            }
            continue;
        }
    }
}

String.prototype.contains = function(other) {
    // 是否包含
    return this.includes(other)
}

// String.prototype.matchAsPrefix = function(string) {

// }

String.prototype.padLeft = function(width) {
    // 传入长度，从左侧填充空格
    return this.padStart(width,' ')
}
String.prototype.padRight = function(width) {
    // 传入长度，从右侧填充空格
    return this.padEnd(width,' ')
}
String.prototype.replaceAllMapped = function(from, replaceFn ) {
    // 可传方法返回值替换指定字符串
    return this.replaceAll(from, replaceFn)
}
String.prototype.replaceFirst = function(from, replace ) {
    // 替换第一个
    return this.replace(from, replace)
}
String.prototype.replaceFirstMapped = function(from, replaceFn ) {
    // 替换第一个，可传function
    return this.replace(from, replaceFn)
}
String.prototype.replaceRange = function( start, end, replacement ) {
    // 指定起始位置替换
    return this.substr(0,start)+replacement+this.substr(end,this.length)
}
String.prototype.splitMapJoin = function( pattern, onMatch, onNonMatch ) {
    // 查询指定字符，用onMatch的返回值替换“，”用onNonMatch的返回值替换其他
    if( this.split(pattern).length == 1 ){
        return onNonMatch() ? onNonMatch() : this
    }else {
        var splitArrLen = this.split(pattern).length;
        var array = new Array(splitArrLen).fill(onNonMatch());
        return array.join(onMatch())

    }
}
global.String = String;
})()
;(function(){

BigInt.one = 1;
BigInt.two = 2;
BigInt.zero = 0;

BigInt.from = function(num) {
    // 取整数部分
    return parseInt(num);
}

BigInt.parse = function(str) {
    // 只接受数字字符串，小数会报错
    if( str.indexOf('.') == -1 && !isNaN(Number(str)) ){
        return BigInt(str);
    }
    else{
        throw 'FormatException: Could not parse BigInt';
    }
}

BigInt.tryParse = function(str) {
    // 只接受数字字符串，小数会报错
    if( str.indexOf('.') == -1 && !isNaN(Number(str)) ){
        return BigInt(str);
    }
    else{
        return null;
    }
}
global.BigInt = BigInt;
})()
;(function(){

const NativeSymbol = global.Symbol;


function Symbol(name){
    // 不能返回Symbol自身会无限调用，只能返回字符串，但是Symbol(name)!=Symbol(name).toString()
    return NativeSymbol(name).toString()
}

Symbol.empty = 'Symbol("")';
Symbol.unaryMinus = 'Symbol("unary-")';

global.NativeSymbol = NativeSymbol;
global.Symbol = Symbol;



   })()
