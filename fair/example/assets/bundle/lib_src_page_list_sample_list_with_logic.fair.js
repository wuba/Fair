GLOBAL['#FairKey#'] = (function(__initProps__) {
  const __global__ = this;
  return {
    fairProps: __initProps__,
    _generateTitle: function _generateTitle() {
        const __thiz__ = this;
        with(__thiz__) {
            console.log('JS:_generateTitle');
          return fairProps.__op_idx__('item');
        }
    },
  };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
