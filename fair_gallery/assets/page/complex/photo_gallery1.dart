import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/utils/repository.dart';
import 'package:fair_gallery/src/utils/text/my_special_text_span_builder.dart';
import 'package:fair_gallery/src/utils/text/selection_area.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
@FFArgumentImport()
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/frame_separate_widget.dart';
import 'package:fair_gallery/src/widget/push_to_refresh_header.dart';
import 'package:fair_gallery/src/widget/share_data_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:keframe/keframe.dart';

@FairPatch()
@FFRoute(
  name: 'fair://PhotoGalleryPage1',
  routeName: '照片库列表',
  description: '展示如何使用Fair创建一个列表, 直接利用 FunctionDomain 创建 itemBuilder',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '复杂',
    'order': 1,
  },
)
class PhotoGalleryPage1 extends StatefulWidget {
  const PhotoGalleryPage1({
    super.key,
    required this.fairProps,
  });

  final Map<String, dynamic> fairProps;

  @override
  State<PhotoGalleryPage1> createState() => _PhotoGalleryPage1State();
}

class _PhotoGalleryPage1State extends State<PhotoGalleryPage1> {
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

  String _getAvatarUrl(dynamic item) {
    var site = item['site'];
    if (site != null && site['icon'] != null) {
      return site['icon'];
    }
    return '';
  }

  String _getSiteTitle(dynamic item) {
    var site = item['site'];
    if (site != null && site['name'] != null) {
      return site['name'];
    }

    return '';
  }

  String _getSiteDescription(dynamic item) {
    var site = item['site'];
    if (site != null && site['description'] != null) {
      return site['description'];
    }
    return '';
  }

  String _getContent(dynamic item) {
    var content =
        '[love]Fair是为Flutter设计的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget的能力。[sun_glasses]';
    if (item != null) {
      if (item['content'] != null) {
        return item['content'] + content;
      } else if (item['excerpt'] != null) {
        return item['excerpt'] + content;
      } else {
        return _getSiteTitle(item) + content;
      }
    }

    return content;
  }

  void _onSpecialTextTap(dynamic parameter) {
    var parameterString = parameter.toString();
    var url = '';
    if (parameterString.startsWith('#')) {
      url = 'https://github.com/wuba/Fair';
    } else if (parameterString.startsWith('@')) {
      url = 'mailto:zmtzawqlp@live.com';
    }
    if (url.isNotEmpty) {
      FairCommonPlugin().launchUrl({
        // required
        'pageName': _pageName,
        'url': url,
      });
    }
  }

  void _onTextMoreTap() {
    FairCommonPlugin().launchUrl({
      // required
      'pageName': _pageName,
      'url': 'https://github.com/wuba/Fair',
    });
  }

  void _onImageTap(List input) {
    int index = input[0];
    dynamic item = input[1];
    FairCommonPlugin().navigate({
      // required
      'pageName': _pageName,
      // if need, add a callback
      'callback': (dynamic result) {
        // result is map or null
      },
      'routeName': 'fair://PhotoSwiper',
      'method': 'pushNamed',
      'arguments': {
        'fairProps': {
          'index': index,
          'images': item['images'],
        }
      },
    });
  }

  String _getImageUrl(int index, dynamic item) {
    var images = item['images'];
    if (index >= images.length) {
      return '';
    }
    var image = images[index];

    return 'https://photo.tuchong.com/' +
        image['user_id'].toString() +
        '/f/' +
        image['img_id'].toString() +
        '.jpg';
  }

  double _getImageWidthOrHeight(int index, int returnWidth, dynamic item) {
    var images = item['images'];
    if (index >= images.length) {
      return 0.0;
    }
    var num300 = 150.0;
    var num400 = 200.0;
    var height = 150.0;
    var width = 200.0;
    var image = images[index];
    height = image['height'] * 1.0;
    width = image['width'] * 1.0;
    var aspectRatio43 = 4.0 / 3.0;
    var aspectRatio34 = 3.0 / 4.0;
    var n = height / width;
    if (n >= aspectRatio43) {
      width = num300;
      height = num400;
    } else if (aspectRatio43 > n && n > aspectRatio34) {
      double maxValue = height;
      if (width > height) {
        maxValue = width;
      }

      height = num400 * height / maxValue;
      width = num400 * width / maxValue;
    } else if (n <= aspectRatio34) {
      width = num400;
      height = num300;
    }

    if (returnWidth == 1) {
      return width;
    } else {
      return height;
    }
  }

  List<String> _getImageUrls(int maxCount, dynamic item) {
    var images = item['images'];
    List<String> urls = [];
    var length = images.length;
    if (maxCount > length) {
      maxCount = length;
    }

    for (var i = 0; i < maxCount; i++) {
      urls.add(_getImageUrl(i, item));
    }
    return urls;
  }

  void _likeButtonTap(Map input) {
    String futureId = input['futureId'];
    // isLiked
    bool isLiked = input['argument'];

    FairCommonPlugin().futureComplete({
      // required
      'pageName': _pageName,
      'futureId': futureId,
      'futureValue': !isLiked,
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
        asset: Assets.assets_page_complex_photo_gallery1_dart,
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
              child: ShareDataWidget(
                data: _repository,
                child: LoadingMoreList(
                  ListConfig(
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
                    itemBuilder:
                        (context, dynamic loadingMoreItem, loadingMoreIndex) {
                      return ExtendedFrameSeparateWidget(
                        index: loadingMoreIndex,
                        placeHolder: Container(height: 200),
                        builder: Sugar.widgetBuilder((context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(11),
                                child: Row(
                                  children: <Widget>[
                                    ExtendedImage.network(
                                      _getAvatarUrl(loadingMoreItem),
                                      width: 40.0,
                                      height: 40.0,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Sugar.colorsWithOpacity(
                                            Colors.grey, 0.4),
                                        width: 1.0,
                                      ),
                                      loadStateChanged:
                                          SugarCommon.onImageStateChanged(
                                              (loadState) {
                                        return Sugar.switchCase(
                                          loadState,
                                          [
                                            SugarSwitchCaseObj(
                                                sugarCase: () =>
                                                    LoadState.loading,
                                                reValue: () =>
                                                    ExtendedImage.asset(Assets
                                                        .assets_image_avatar_jpg)),
                                            SugarSwitchCaseObj(
                                                sugarCase: () =>
                                                    LoadState.failed,
                                                reValue: () =>
                                                    ExtendedImage.asset(Assets
                                                        .assets_image_avatar_jpg)),
                                          ],
                                          () => null,
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      _getSiteTitle(loadingMoreItem),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _getSiteDescription(loadingMoreItem),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                child: CommonSelectionArea(
                                  child: ExtendedText(
                                    _getContent(loadingMoreItem),
                                    onSpecialTextTap: _onSpecialTextTap,
                                    specialTextSpanBuilder:
                                        MySpecialTextSpanBuilder(),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    maxLines: 5,
                                    overflowWidget: TextOverflowWidget(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('\u2026 ',
                                              style: TextStyle(
                                                  fontSize: 14, height: 1.2)),
                                          GestureDetector(
                                            child: const Text(
                                              '更多',
                                              style: TextStyle(
                                                  fontSize: 14, height: 1.2),
                                            ),
                                            onTap: _onTextMoreTap,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 11, right: 11, bottom: 11),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 11, right: 11, bottom: 11),
                                child: Wrap(
                                    runSpacing: 5.0,
                                    spacing: 5.0,
                                    children: Sugar.mapEach(
                                      SugarIterable.toList(SugarIterable.take(
                                          Sugar.mapGet(loadingMoreItem, 'tags'),
                                          //tags,
                                          6)),
                                      (index, item) => Container(
                                        padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          color:
                                              SugarCommon.getRandomColor(index),
                                          border: Border.all(
                                            color: Sugar.colorsWithOpacity(
                                                Colors.grey, 0.4),
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Text(
                                          '$item',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                SugarCommon.getLuminanceColor(
                                              SugarCommon.colorComputeLuminance(
                                                SugarCommon.getRandomColor(
                                                  index,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              Sugar.switchCase(
                                // SugarList.length(images),
                                SugarList.length(
                                  Sugar.mapGet(loadingMoreItem, 'images'),
                                ),
                                [
                                  SugarSwitchCaseObj(
                                      sugarCase: () => 0,
                                      reValue: () => Container()),
                                  SugarSwitchCaseObj(
                                    sugarCase: () => 1,
                                    reValue: () => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 11, right: 11, bottom: 11),
                                      child: GestureDetector(
                                        onTap: SugarCommon.voidCallBack(
                                            function: _onImageTap,
                                            value: [0, loadingMoreItem]),
                                        child: Hero(
                                          tag: _getImageUrl(
                                            0,
                                            loadingMoreItem,
                                          ),
                                          child: ExtendedImage.network(
                                            _getImageUrl(0, loadingMoreItem),
                                            height: _getImageWidthOrHeight(
                                                0, 0, loadingMoreItem),
                                            width: _getImageWidthOrHeight(
                                                0, 1, loadingMoreItem),
                                            fit: BoxFit.fill,
                                            loadStateChanged:
                                                SugarCommon.onImageStateChanged(
                                                    (loadState) {
                                              return Sugar.switchCase(
                                                loadState,
                                                [
                                                  SugarSwitchCaseObj(
                                                    sugarCase: () =>
                                                        LoadState.loading,
                                                    reValue: () => ColoredBox(
                                                      color: Sugar
                                                          .colorsWithOpacity(
                                                        Colors.grey,
                                                        0.2,
                                                      ),
                                                    ),
                                                  ),
                                                  SugarSwitchCaseObj(
                                                    sugarCase: () =>
                                                        LoadState.failed,
                                                    reValue: () => ColoredBox(
                                                      color: Sugar
                                                          .colorsWithOpacity(
                                                        Colors.grey,
                                                        0.2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                () => null,
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SugarSwitchCaseObj(
                                    sugarCase: () => 4,
                                    reValue: () => SizedBox(
                                      width: SugarDouble.multiplies(
                                          SugarDouble.divides(
                                              Sugar.width(context), 3),
                                          2),
                                      child: GridView(
                                        padding: const EdgeInsets.only(
                                            left: 11, right: 11, bottom: 11),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 1.0,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: Sugar.mapEach(
                                            _getImageUrls(4, loadingMoreItem),
                                            (index, item) {
                                          return GestureDetector(
                                            onTap: SugarCommon.voidCallBack(
                                              function: _onImageTap,
                                              value: [index, loadingMoreItem],
                                            ),
                                            child: Hero(
                                              tag: item,
                                              child: ExtendedImage.network(
                                                item,
                                                fit: BoxFit.cover,
                                                loadStateChanged: SugarCommon
                                                    .onImageStateChanged(
                                                        (loadState) {
                                                  return Sugar.switchCase(
                                                    loadState,
                                                    [
                                                      SugarSwitchCaseObj(
                                                        sugarCase: () =>
                                                            LoadState.loading,
                                                        reValue: () =>
                                                            ColoredBox(
                                                          color: Sugar
                                                              .colorsWithOpacity(
                                                            Colors.grey,
                                                            0.2,
                                                          ),
                                                        ),
                                                      ),
                                                      SugarSwitchCaseObj(
                                                        sugarCase: () =>
                                                            LoadState.failed,
                                                        reValue: () =>
                                                            ColoredBox(
                                                          color: Sugar
                                                              .colorsWithOpacity(
                                                            Colors.grey,
                                                            0.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    () => null,
                                                  );
                                                }),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                                () => GridView(
                                  padding: const EdgeInsets.only(
                                      left: 11, right: 11, bottom: 11),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: Sugar.mapEach(
                                      _getImageUrls(
                                        9,
                                        loadingMoreItem,
                                      ), (index, item) {
                                    return GestureDetector(
                                      onTap: SugarCommon.voidCallBack(
                                        function: _onImageTap,
                                        value: [index, loadingMoreItem],
                                      ),
                                      child: Sugar.ifEqualBool(
                                          SugarBool.and(
                                            SugarNum.greaterThan(
                                              SugarList.length(Sugar.mapGet(
                                                  loadingMoreItem, 'images')),
                                              9,
                                            ),
                                            () => SugarNum.equalTo(index, 8),
                                          ),
                                          trueValue: () => Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: Hero(
                                                      tag: item,
                                                      child:
                                                          ExtendedImage.network(
                                                        item,
                                                        fit: BoxFit.cover,
                                                        loadStateChanged: SugarCommon
                                                            .onImageStateChanged(
                                                                (loadState) {
                                                          return Sugar
                                                              .switchCase(
                                                            loadState,
                                                            [
                                                              SugarSwitchCaseObj(
                                                                sugarCase: () =>
                                                                    LoadState
                                                                        .loading,
                                                                reValue: () =>
                                                                    ColoredBox(
                                                                  color: Sugar
                                                                      .colorsWithOpacity(
                                                                    Colors.grey,
                                                                    0.2,
                                                                  ),
                                                                ),
                                                              ),
                                                              SugarSwitchCaseObj(
                                                                sugarCase: () =>
                                                                    LoadState
                                                                        .failed,
                                                                reValue: () =>
                                                                    ColoredBox(
                                                                  color: Sugar
                                                                      .colorsWithOpacity(
                                                                    Colors.grey,
                                                                    0.2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                            () => null,
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    color:
                                                        Sugar.colorsWithOpacity(
                                                            Colors.grey, 0.2),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      SugarString.concatenates(
                                                          '+',
                                                          SugarNum.numToString(
                                                            SugarNum.subtracts(
                                                              SugarList.length(
                                                                  Sugar.mapGet(
                                                                      loadingMoreItem,
                                                                      'images')),
                                                              9,
                                                            ),
                                                          ))
                                                      //_getImageMoreCount(),
                                                      ,
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                          falseValue: () => Hero(
                                                tag: item,
                                                child: ExtendedImage.network(
                                                  item,
                                                  fit: BoxFit.cover,
                                                  loadStateChanged: SugarCommon
                                                      .onImageStateChanged(
                                                          (loadState) {
                                                    return Sugar.switchCase(
                                                      loadState,
                                                      [
                                                        SugarSwitchCaseObj(
                                                          sugarCase: () =>
                                                              LoadState.loading,
                                                          reValue: () =>
                                                              ColoredBox(
                                                            color: Sugar
                                                                .colorsWithOpacity(
                                                              Colors.grey,
                                                              0.2,
                                                            ),
                                                          ),
                                                        ),
                                                        SugarSwitchCaseObj(
                                                          sugarCase: () =>
                                                              LoadState.failed,
                                                          reValue: () =>
                                                              ColoredBox(
                                                            color: Sugar
                                                                .colorsWithOpacity(
                                                              Colors.grey,
                                                              0.2,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      () => null,
                                                    );
                                                  }),
                                                ),
                                              )),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 11),
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.comment,
                                          color: Colors.amberAccent,
                                          size: 18.0,
                                        ),
                                        const SizedBox(
                                          width: 3.0,
                                        ),
                                        Text(
                                          SugarInt.intToString(
                                            SugarCommon.nullOrDefault(
                                              Sugar.mapGet(
                                                  loadingMoreItem, 'comments'),
                                              0,
                                            ),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    LikeButton(
                                      size: 18.0,
                                      isLiked: SugarCommon.nullOrDefault(
                                        Sugar.mapGet(
                                          loadingMoreItem,
                                          'is_favorite',
                                        ),
                                        false,
                                      ),
                                      likeCount: SugarCommon.nullOrDefault(
                                        Sugar.mapGet(
                                          loadingMoreItem,
                                          'favorites',
                                        ),
                                        0,
                                      ),
                                      onTap: (isLiked) =>
                                          Sugar.createFuture<bool?>(
                                        function: _likeButtonTap,
                                        argument: isLiked,
                                        callback: (result) => SugarMap.set(
                                          loadingMoreItem,
                                          'is_favorite',
                                          result,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 11),
                                color:
                                    Sugar.colorsWithOpacity(Colors.grey, 0.2),
                                height: 11,
                              )
                            ],
                          );
                        }),
                      );
                    },
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
