GLOBAL['#FairPageName#'] = (function(__initProps__) {
    const __global__ = this;
    return {
        _platform: `Fair v$ {
            fairVersion
        }`,
        _count: 0,
        onTapText: function onTapText() {
            const __thiz__ = this;
            with(__thiz__) {
                setData('#FairPageName#', {_count: _count++});
            }
        },
        getShowText: function getShowText() {
            const __thiz__ = this;
            with(__thiz__) {
                return`Running with $ {
                    _platform
                },
                click count = $ {
                    _count
                }`;
            }
        },
    };
})(JSON.parse('#FairProps#'));