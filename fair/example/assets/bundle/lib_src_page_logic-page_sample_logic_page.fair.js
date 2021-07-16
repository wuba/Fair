GLOBAL['#FairPageName#'] = (function(__initProps__) {
    const __global__ = this;
    return {
        fairProps: __initProps__,
        _platform: `Fair v$ {
            fairVersion
        }`,
        _count: 10,
        getTitle: function getTitle() {
            const __thiz__ = this;
            with(__thiz__) {
                return fairProps.__op_idx__('pageName');
            }
        },
        onTapText: function onTapText() {
            const __thiz__ = this;
            with(__thiz__) {
                setData('#FairPageName#', {_count: _count++});
            }
        },
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));