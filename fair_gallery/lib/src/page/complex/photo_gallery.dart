import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/fair_gallery_routes.dart';
import 'package:fair_gallery/src/page/complex/photo_gallery_item.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/utils/repository.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
@FFArgumentImport()
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/push_to_refresh_header.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:keframe/keframe.dart';

@FairPatch()
@FFRoute(
  name: 'fair://PhotoGalleryPage',
  routeName: '照片库列表',
  description: '展示如何使用Fair创建一个列表,使用 delegate 绑定 itemBuilder',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '复杂',
    'order': 0,
  },
)
class PhotoGalleryPage extends StatefulWidget {
  const PhotoGalleryPage({
    super.key,
    required this.fairProps,
  });

  final Map<String, dynamic> fairProps;

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  late LoadingMoreRepository _repository;
  DateTime lastRefreshTime = DateTime.now();
  @FairProps()
  var fairProps;
  final String _pageName = '#FairKey#';
  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
    onLoad();
  }

  /// void didChangeDependencies() {
  ///   runtime?.invokeMethod(pageName, 'onLoad', null);
  /// }
  void onLoad() {
    _repository = LoadingMoreRepository();
  }

  @override
  void dispose() {
    onUnload();
    super.dispose();
  }

  /// void dispose() {
  ///   runtime?.invokeMethod(pageName, 'onUnload', null);
  /// }
  ///
  void onUnload() {}

  Widget _itemBuilder(
    BuildContext context,
    dynamic item,
    int index,
  ) {
    final fairProps = <String, dynamic>{
      'item': item,
      'index': index,
    };
    final Map<int?, Size>? size = SizeCacheWidget.of(context)?.itemsSizeCache;
    double height = size?[index]?.height ?? 200;
    return FrameSeparateWidget(
      index: index,
      child: ExtendedFairWidget(
        builder: (context) => PhotoGalleryItem(fairProps: fairProps),
        name: Routes.fairPhotoSwiper.name,
        fairProps: fairProps,
        holder: (b) => SizedBox(height: height),
      ),
      placeHolder: SizedBox(height: height),
    );
  }

  Future<bool> _onRefresh() {
    return _repository.refresh();
  }

  int pageIndex = 0;
  final List<int> _itemIds = <int>[];
  void _onLoadData(Map input) {
    String futureId = input['futureId'];
    bool isloadMoreAction = input['isloadMoreAction'];
    var url = '';
    if (!isloadMoreAction) {
      _itemIds.clear();
      pageIndex = 0;
    }
    if (_itemIds.isEmpty) {
      url = 'https://api.tuchong.com/feed-app';
    } else {
      var lastId = _itemIds[_itemIds.length - 1];
      // ignore: prefer_interpolation_to_compose_strings
      url = 'https://api.tuchong.com/feed-app?post_id=' +
          lastId.toString() +
          '&page=' +
          pageIndex.toString() +
          '&type=loadmore';
    }

    FairCommonPlugin().http({
      'method': 'GET',
      'url': url,
      // required
      'pageName': _pageName,
      // if need, add a callback
      'callback': (dynamic result) {
        if (result != null) {
          var statusCode = result['statusCode'];
          var list = [];
          if (statusCode == 200) {
            var map = result['json'];
            if (map != null) {
              var feedList = map['feedList'];
              for (var i = 0; i < feedList.length; i++) {
                var item = feedList[i];
                var postId = item['post_id'];
                if (!_itemIds.contains(item[postId])) {
                  list.add(item);
                  _itemIds.add(postId);
                }
              }
            }
            pageIndex = pageIndex + 1;
          }
          if (!isloadMoreAction) {
            lastRefreshTime = DateTime.now();
          }

          FairCommonPlugin().futureComplete({
            // required
            'pageName': _pageName,
            'futureId': futureId,
            'futureValue': {
              'pageIndex': pageIndex,
              'statusCode': statusCode,
              'list': list,
            },
          });
        }
      },
    });
  }

  String _getRouteName() {
    if (fairProps != null && fairProps['routeName'] != null) {
      return fairProps['routeName'];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommomAppBar(
        title: _getRouteName(),
        asset: Assets.assets_page_complex_photo_gallery_dart,
      ),
      body: PullToRefreshNotification(
        pullBackOnRefresh: false,
        maxDragOffset: 90,
        armedDragUpCancel: false,
        onRefresh: _onRefresh,
        child: Column(children: [
          PullToRefreshContainer(
            (info) => PullToRefreshHeader(
              info,
              Sugar.dateTimeFromJs(lastRefreshTime),
            ),
          ),
          Expanded(
            child: SizeCacheWidget(
              child: LoadingMoreList(
                ListConfig(
                  itemBuilder: _itemBuilder,
                  sourceList: LoadingMoreRepository.onLoadData(
                    _repository,
                    _onLoadData,
                    maxLength: 300,
                  ),
                  cacheExtent: SugarNum.toDouble(
                      SugarNum.multiplies(Sugar.height(context), 2)),
                  physics: const BouncingScrollPhysics(),
                  indicatorBuilder: SugarCommon.loadingMoreIndicatorBuilder(
                    [
                      SugarSwitchCaseObj(
                        sugarCase: () => IndicatorStatus.fullScreenBusying,
                        reValue: () => const Align(
                          alignment: Alignment.center,
                          child: Text('不要着急，正在加载中...'),
                        ),
                      ),
                      SugarSwitchCaseObj(
                        sugarCase: () => IndicatorStatus.loadingMoreBusying,
                        reValue: () => Container(
                          height: 35.0,
                          alignment: Alignment.center,
                          child: const Text('不要拖了，正在加载更多...'),
                        ),
                      ),
                      SugarSwitchCaseObj(
                        sugarCase: () => IndicatorStatus.noMoreLoad,
                        reValue: () => Container(
                          height: 35.0,
                          alignment: Alignment.center,
                          child: const Text('拖不动了，没有更多了！'),
                        ),
                      ),
                    ],
                    isSliver: false,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
