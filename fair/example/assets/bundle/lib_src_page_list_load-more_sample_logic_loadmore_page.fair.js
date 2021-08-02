GLOBAL['#FairKey#'] = (function (__initProps__) {
    const __global__ = this;
    return {
        list: List(), _scrollController: null, listIsEmpty: function listIsEmpty() {
            const __thiz__ = this;
            with (__thiz__) {
                return list == null || list.isEmpty;
            }
        }, _onLoadMore: async function onLoadMore() {
            const __thiz__ = this;
            with (__thiz__) {
                // await Future.delayed(Duration({seconds: 2}), function dummy() {
                //     list.addAll(List.generate(Random().nextInt(5) + 1, (i) => `more Item ${i}`));
                //     setState('ListLoadMore', {});
                // });
                for (var i = 0; i < 4; i++) {
                    list.add(`More Item ${i}`);
                }
                setState('ListLoadMore', {});
            }
        }, _onRefresh: async function _onRefresh() {
            const __thiz__ = this;
            with (__thiz__) {
                // await Future.delayed(
                Duration({seconds: 3}), function dummy() {
                    list = List.generate(Random().nextInt(20) + 15, (i) => `Item ${i}`);
                    console.log('JS:_onRefresh');
                    setState('ListLoadMore', {});
                }//);
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
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
