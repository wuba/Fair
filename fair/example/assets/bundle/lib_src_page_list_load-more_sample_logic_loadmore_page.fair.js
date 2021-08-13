GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;

    function JRListState() {
        const inner = JRListState.__inner__;
        if (this == __global__) {
            return new JRListState({__args__: arguments});
        } else {
            const args = arguments.length > 0 ? arguments[0].__args__ || arguments : [];
            inner.apply(this, args);
            JRListState.prototype.ctor.apply(this, args);
            return this;
        }
    }

    JRListState.__inner__ = function inner() {
        this.fairProps = __initProps__;
        this.list = List();
        this._scrollController = null;
    };
    JRListState.prototype = {
        listIsEmpty: function listIsEmpty() {
            const __thiz__ = this;
            with (__thiz__) {
                return list == null || list.isEmpty;
            }
        }, _onLoadMore: async function _onLoadMore() {
            const __thiz__ = this;
            with (__thiz__) {
                // await Future.delayed(Duration({seconds: 2}), function dummy() {
                //     list.addAll(List.generate(Random().nextInt(5) + 1, (i) => `more Item ${i}`));
                //     setState('ListLoadMore', {});
                // });
                console.log('JS:_onLoadMore');
                for (var i = 0; i < 4; i++) {
                    list.add(`More Item ${i}`);
                }
                setState('#FairKey#', function dummy() {});
            }
        }, _onRefresh: async function _onRefresh() {
            const __thiz__ = this;
            with (__thiz__) {
                // await Future.delayed(
                // Duration({seconds: 3}), function dummy() {
                    console.log('JS:_onRefresh');
                    list.insertAll(0, List.generate(2, (i) => `refresh Item ${i}`));
                    setState('#FairKey#', function dummy() {});
                // }//);
            }
        }, onLoad: function onLoad() {
            const __thiz__ = this;
            with (__thiz__) {
                console.log('JS:onLoad');
                // _onRefresh();
                // list = List.generate(Random().nextInt(20) + 15, (i) => `Item ${i}`);
                // _scrollController = (function () {
                //     let __target__ = ScrollController();
                //     __target__.addListener(function dummy() {
                //         if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                //             onLoadMore();
                //         }
                //     });
                //     return __target__;
                // })();
                for (var i = 0; i < 15; i++) {
                    list.add(`Item ${i}`);
                }
            }
        }, onUnload: function onUnload() {
            const __thiz__ = this;
            with (__thiz__) {
                _scrollController.dispose();
            }
        }, initState: function initState() {
            const __thiz__ = this;
            with (__thiz__) {
                fairProps = widget.fairProps;
                onLoad();
            }
        }, dispose: function dispose() {
            const __thiz__ = this;
            with (__thiz__) {
                onUnload();
            }
        }, _itemCount: function _itemCount() {
            const __thiz__ = this;
            with (__thiz__) {
                return list.length;
            }
        }, _onItemByIndex: function _onItemByIndex(index) {
        const __thiz__ = this;
        with (__thiz__) {
            return list[index];
        }
    }
    };
    JRListState.prototype.ctor = function () {
        Object.prototype.ctor.call(this);
    };
    ;
    return JRListState();
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
