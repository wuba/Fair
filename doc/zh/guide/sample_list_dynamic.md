# 完整动态列表

## 使用场景

    1、一个完全动态的列表
    2、动态列表 + 下拉刷新
    3、动态列表 + 上拉加载更多

## 预览效果

|   Pull Refresh   |    Load More  |
| ---- | ---- |
| ![pullRefresh](./assets/sample_list_pull_refresh.jpg)    |   ![loadMore](./assets/sample_list_load_more.jpg)   |

## 集成方式

    （由于是Dart侧组件回调通知，我们需要借助Dart到JS的通信通道，来处理数据的更新。由此我们统一把onRefresh，
    以及后面的ScrollController Flutter类型变量，定制到Delegate模版中统一处理，当然也支持用户自定义更多的回调处理方式）

#### 自定义delegate

    class ListDelegate extends FairDelegate {
    // 定义Flutter 系统变量
    ScrollController _scrollController;

    // 注册ListView组件回调
    @override
    Map<String, Function> bindFunction() {
        var functions = super.bindFunction();
        functions.addAll({
            '_itemBuilder': _itemBuilder,
            '_onRefresh': _onRefresh,
        });
        return functions;
    }

    // 注册监听变量
    @override Map<String, PropertyValue> bindValue() { 
        var pros = super.bindValue();
        pros.addAll({
          '_scrollController': () => _scrollController,
        });
        return pros;
    }

    @override void initState() { 
        // 监听滑动
        _scrollController = ScrollController()
        ..addListener(() { 
            //判断是否滑到底 
            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                _onLoadMore(); 
            } 
        }); 
    }

    // 通过Dart to JS Channel 回调JS侧方法
    void _onLoadMore() { runtime?.invokeMethod(pageName, '_onLoadMore', null); }

    // 通过Dart to JS Channel 回调JS侧方法
    Future<void> _onRefresh() async { await runtime?.invokeMethod(pageName, '_onRefresh', null); }

    // 通过Dart to JS Channel 回调JS侧方法
    Widget _itemBuilder(context, index) { 
        var result = runtime?.invokeMethodSync(pageName, '_onItemByIndex', [index]); 
        var value = jsonDecode(result); var itemData = value['result']['result']; 
        return FairWidget(name: itemData, path: 'assets/bundle/lib_src_page_list_sample_list_with_logic.fair.json', data: {'fairProps':jsonEncode({'item': '${itemData}'})},
    ); } }

#### 2、ListView绑定消息

    RefreshIndicator(
            //下拉刷新
            displacement: 10.0,
            child: Sugar.ifEqualBool(listIsEmpty(),
                trueValue: Center(
                  child: CircularProgressIndicator(), //没有数据就转圈
                ),
                falseValue: ListView.builder(
                    controller: _scrollController,
                    itemCount: list.length + 1,
                    itemBuilder: _itemBuilder)),
            onRefresh: _onRefresh),
      )
 