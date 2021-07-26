GLOBAL['#FairKey#'] = (function(__initProps__) {
    const __global__ = this;
    return {
        fairProps: __initProps__,
        _count: 0,
        getTitle: function getTitle() {
            const __thiz__ = this;
            with(__thiz__) {
                return fairProps.__op_idx__('pageName');
            }
        },
        onTapText: function onTapText() {
            const __thiz__ = this;
            with(__thiz__) {
                setState('#FairKey#', convertObjectLiteralToSetOrMap({ _count : _count++,
                }));
            }
        },
        _countCanMod2: function _countCanMod2() {
            const __thiz__ = this;
            with(__thiz__) {
                return _count % 2 == 1;
            }
        }
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));