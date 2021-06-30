// 仅支持list与list对象的交互
// 不支持
// 自定义Iterable对象
// 不可变list
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



//global.List = Array;