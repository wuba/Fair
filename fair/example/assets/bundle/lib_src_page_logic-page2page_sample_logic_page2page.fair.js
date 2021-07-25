GLOBAL['#FairPageName#'] = (function (__initProps__) {
    const __global__ = this;
    return {
        fairProps: __initProps__, getTitle: function getTitle() {
            const __thiz__ = this;
            with (__thiz__) {
                return fairProps.__op_idx__('pageName');
            }
        },
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
