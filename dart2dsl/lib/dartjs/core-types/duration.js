const __global__ = global;

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

global.Duration = Duration;