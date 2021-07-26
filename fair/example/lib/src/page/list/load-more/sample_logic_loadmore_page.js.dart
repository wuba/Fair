// part of 'sample_logic_loadmore_page.dart';
//
// List list = List();
//
// // 监听listview的滑动
// ScrollController _scrollController;
//
// bool listIsEmpty() {
//   return list == null || list.isEmpty;
// }
//
// Future _onLoadMore() async {
//   await Future.delayed(Duration(seconds: 1), () {
//     list.addAll(
//         List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
//     setState('LoadMore', {});
//   });
// }
//
// Future<void> _onRefresh() async {
//   await Future.delayed(Duration(seconds: 1), () {
//     list.insertAll(0,  List.generate(Random().nextInt(5) + 5, (i) => 'refresh Item $i'));
//     setState('LoadMore', {});
//   });
// }
//
// void onLaunch() {
//
//   Future.delayed(Duration(seconds: 1), () {
//     list.insertAll(0,  List.generate(Random().nextInt(10) + 5, (i) => 'Item $i'));
//     setState('LoadMore', {});
//   });
//
//   // 监听滑动
//   _scrollController = ScrollController()
//     ..addListener(() {
//       //判断是否滑到底
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         _onLoadMore();
//       }
//     });
// }
//
// void onDispose() {
//   _scrollController.dispose();
// }