GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;

    function _MyHomePageState() {
        const inner = _MyHomePageState.__inner__;
        if (this == __global__) {
            return new _MyHomePageState({__args__: arguments});
        } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            _MyHomePageState.prototype.ctor.apply(this, args);
            return this;
        }
    }

    _MyHomePageState.__inner__ = function inner() {
        this._currentIndex = 0;
    };
    _MyHomePageState.prototype = {
        onItemSelect: function onItemSelect(index) {
            const __thiz__ = this;
            const __arg_ctx__ = {index,};
            with (__thiz__) {
                with (__arg_ctx__) {
                    _currentIndex = index;
                    setState('#FairKey#', function dummy() {
                    });
                }
            }
        },
    };
    _MyHomePageState.prototype.ctor = function () {
        Object.prototype.ctor.call(this);
    };
    ;
    return _MyHomePageState();
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
