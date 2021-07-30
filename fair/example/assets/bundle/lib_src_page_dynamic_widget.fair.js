GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;

    function () {
        const inner =
    .
        __inner__;
        if (this == __global__) {
            return new ({__args__: arguments});
        } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
        .
            prototype.ctor.apply(this, args);
            return this;
        }
    }

.
    __inner__ = function inner() {
    };
.
    prototype = {};
.
    prototype.ctor = function () {
        Object.prototype.ctor.call(this);
    };
    ;
    return ();
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
