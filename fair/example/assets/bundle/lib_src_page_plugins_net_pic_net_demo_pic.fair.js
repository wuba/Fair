GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;

    function PicData() {
        const inner = PicData.__inner__;
        if (this == __global__) {
            return new PicData({__args__: arguments});
        } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            PicData.prototype.ctor.apply(this, args);
            return this;
        }
    }

    PicData.__inner__ = function inner() {
        this.picUrl = `https://www.youxinpai.com/public/home/widget/services/4s/img/img_4s_4_0943ac1.jpg`;
        this.title = ``;
        this.content = ``;
    };
    PicData.prototype = {};
    PicData.prototype.ctor = function () {
        Object.prototype.ctor.call(this);
    };

    function _PicNetDemoPageStateful() {
        const inner = _PicNetDemoPageStateful.__inner__;
        if (this == __global__) {
            return new _PicNetDemoPageStateful({__args__: arguments});
        } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            _PicNetDemoPageStateful.prototype.ctor.apply(this, args);
            return this;
        }
    }

    _PicNetDemoPageStateful.__inner__ = function inner() {
        this._picData = PicData();
    };
    _PicNetDemoPageStateful.prototype = {
        onClick: function onClick() {
            const __thiz__ = this;
            with (__thiz__) {
                let order_id = 10;
                FairNet().request(convertObjectLiteralToSetOrMap({
                    [`pageName`]: `#FairKey#`,
                    [`method`]: `GET`,
                    [`url`]: `https://www.wanandroid.com/banner/json`,
                    [`data`]: convertObjectLiteralToSetOrMap({
                        [`order_id`]: order_id,
                        [`content`]: `test`,
                        [`aa`]: [`hello`, `world`],
                    }),
                    [`success`]: function dummy(resp) {
                        if (resp == null) {
                            return null;
                        }
                        let data = resp.__op_idx__(`data`);
                        let u = data.__op_idx__(0).__op_idx__(`imagePath`);
                        _picData.picUrl = u;
                        _picData.title = data.__op_idx__(0).__op_idx__(`title`);
                        setState('#FairKey#', function dummy() {
                        });
                    },
                }));
            }
        },
    };
    _PicNetDemoPageStateful.prototype.ctor = function () {
        Object.prototype.ctor.call(this);
    };
    ;
    return _PicNetDemoPageStateful();
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
