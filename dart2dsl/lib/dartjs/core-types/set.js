require('./iterable');

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

};