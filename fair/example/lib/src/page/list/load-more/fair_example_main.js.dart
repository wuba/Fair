part of 'fair_example_main.dart';

List list = List();

// 监听listview的滑动
ScrollController _scrollController;

bool listIsEmpty() {
  return list == null || list.isEmpty;
}

Future onLoadMore() async {
  await Future.delayed(Duration(seconds: 2), () {
    // setData(() {
    //   list.addAll(
    //       List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
    // });
  });
}

Future<void> _refresh() async {
  await Future.delayed(Duration(seconds: 3), () {
    // setState(() {
    //   list = List.generate(Random().nextInt(20) + 15, (i) => 'Item $i');
    // });
  });
}

void onLaunch() {
  _refresh();
  // 监听滑动
  _scrollController = ScrollController()
    ..addListener(() {
      //判断是否滑到底
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        onLoadMore();
      }
    });
}

void onDispose() {
  _scrollController.dispose();
}