GLOBAL['#FairPageName#'] = (function(__initProps__) {
    const __global__ = this;
    return {
        list: List(),
        _scrollController: {},
        listIsEmpty: function listIsEmpty() {
            const __thiz__ = this;
            with(__thiz__) {
                return list == null || list.isEmpty;
            }
        },
        _itemCount: function _itemCount() {
            const __thiz__ = this;
            with(__thiz__) {
                return list.length;
            }
        },
        _refresh: function _refresh() {
            const __thiz__ = this;
            with(__thiz__) {
            }
        },
        onListData: function onListData() {
            const __thiz__ = this;
            with(__thiz__) {
                return list;
            }
        },
        onLoadMore: function onLoadMore() {
            const __thiz__ = this;
            with(__thiz__) {
                list.add("58");
                list.add("fair");
                list.add("1");
                list.add("2");
                list.add("3");
                list.add("4");
                list.add("5");
                list.add("6");
            }
            setData('#FairPageName#', {});
            console.log("onLoadMore");
        },
        onLaunch: function onLaunch() {
            console.log("onLaunch");
            this.onLoadMore();
        },
        onDispose: function onDispose() {

        }
    };
})(JSON.parse('#FairProps#'));