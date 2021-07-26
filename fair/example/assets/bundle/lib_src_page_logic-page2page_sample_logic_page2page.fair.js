GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;
    return {
        fairProps: __initProps__,
        _count: __initProps__.__op_idx__('_count'),
        getTitle: function getTitle() {
            const __thiz__ = this;
            with (__thiz__) {
                return fairProps.__op_idx__('pageName');
            }
        }, onTapText: function onTapText() {
            const __thiz__ = this;
            with(__thiz__) {
                setState('#FairKey#', convertObjectLiteralToSetOrMap({ [_count] : ++_count,
                }));
            }
        }
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
