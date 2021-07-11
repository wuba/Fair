GLOBAL['#FairPageName#'] = (function(__initProps__) {
    const __global__ = this;
    return {
        _name: __initProps__,
        _generateTitle: function _generateTitle() {
            const __thiz__ = this;
            with(__thiz__) {
                return _name.item;
            }
        }
    };
})(JSON.parse('#FairProps#'));