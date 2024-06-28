// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, unused_element, unused_local_variable

// ignore: unused_import
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/utils/text/my_special_text_span_builder.dart';
import 'package:fair_gallery/src/utils/text/selection_area.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/share_data_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

@FairPatch()
@FFRoute(
  name: 'fair://PhotoGalleryItem',
  routeName: '图片列表单个元素',
  description: 'PhotoGalleryItem',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
  },
)
class PhotoGalleryItem extends StatefulWidget {
  const PhotoGalleryItem({
    super.key,
    required this.fairProps,
  });
  final Map<String, dynamic> fairProps;
  @override
  State<PhotoGalleryItem> createState() => _PhotoGalleryItemState();
}

class _PhotoGalleryItemState extends State<PhotoGalleryItem> {
  @FairProps()
  var fairProps;

  var item;

  var itemIndex;

  var site;
  var tags = [];
  var images = [];
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
    item = fairProps['item'];
    itemIndex = fairProps['index'];
    if (item['site'] != null) {
      site = item['site'];
    }
    if (item['tags'] != null) {
      tags = item['tags'];
    }
    if (item['images'] != null) {
      images = item['images'];
    }
  }

  /// void dispose() {
  ///   runtime?.invokeMethod(pageName, 'onUnload', null);
  /// }
  ///
  void onUnload() {}

  @override
  void dispose() {
    onUnload();
    super.dispose();
  }

  dynamic _getValue(String key, dynamic defaultValue) {
    if (item != null && item[key] != null) {
      return item[key];
    }
    return defaultValue;
  }

  String _getSiteTitle() {
    if (site != null && site['name'] != null) {
      return site['name'];
    }

    return 'Image' + itemIndex.toString();
  }

  String _getSiteDescription() {
    if (site != null && site['description'] != null) {
      return site['description'];
    }

    return '';
  }

  String _getAvatarUrl() {
    if (site != null && site['icon'] != null) {
      return site['icon'];
    }
    return '';
  }

  String _getContent() {
    var content =
        '[love]Fair是为Flutter设计的动态化框架，通过Fair Compiler工具对原生Dart源文件的自动转化，使项目获得动态更新Widget的能力。[sun_glasses]';
    if (item != null) {
      if (item['content'] != null) {
        return item['content'] + content;
      } else if (item['excerpt'] != null) {
        return item['excerpt'] + content;
      } else {
        return _getSiteTitle() + content;
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

  double _getImageWidthOrHeight(int index, int returnWidth) {
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

  String _getImageUrl(int index) {
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

  List<String> _getImageUrls(int maxCount) {
    List<String> urls = [];
    var length = images.length;
    if (maxCount > length) {
      maxCount = length;
    }

    for (var i = 0; i < maxCount; i++) {
      urls.add(_getImageUrl(i));
    }
    return urls;
  }

  String _getImageMoreCount() {
    var moreCount = images.length - 9;
    return '+' + moreCount.toString();
  }

  void _onImageTap(int index) {
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
          'images': images,
        }
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: <Widget>[
              ExtendedImage.network(
                _getAvatarUrl(),
                width: 40.0,
                height: 40.0,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Sugar.colorsWithOpacity(Colors.grey, 0.4),
                  width: 1.0,
                ),
                loadStateChanged: SugarCommon.onImageStateChanged((loadState) {
                  return Sugar.switchCase(
                    loadState,
                    [
                      SugarSwitchCaseObj(
                        sugarCase: () => LoadState.loading,
                        reValue: () =>
                            ExtendedImage.asset(Assets.assets_image_avatar_jpg),
                      ),
                      SugarSwitchCaseObj(
                        sugarCase: () => LoadState.failed,
                        reValue: () =>
                            ExtendedImage.asset(Assets.assets_image_avatar_jpg),
                      ),
                    ],
                    () => null,
                  );
                }),
              ),
              const SizedBox(
                width: 11,
              ),
              Text(
                _getSiteTitle(),
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
                  _getSiteDescription(),
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
              _getContent(),
              onSpecialTextTap: _onSpecialTextTap,
              specialTextSpanBuilder: MySpecialTextSpanBuilder(),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 5,
              overflowWidget: TextOverflowWidget(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('\u2026 ',
                        style: TextStyle(fontSize: 14, height: 1.2)),
                    GestureDetector(
                      child: const Text(
                        '更多',
                        style: TextStyle(fontSize: 14, height: 1.2),
                      ),
                      onTap: _onTextMoreTap,
                    )
                  ],
                ),
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
          child: Wrap(
              runSpacing: 5.0,
              spacing: 5.0,
              children: Sugar.mapEach(
                SugarIterable.toList(SugarIterable.take(
                    ShareDataWidget.getValue(
                      context,
                      ['item', 'tags'],
                      defaultValue: [],
                    ),
                    //tags,
                    6)),
                (index, item) => Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: SugarCommon.getRandomColor(index),
                    border: Border.all(
                      color: Sugar.colorsWithOpacity(Colors.grey, 0.4),
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
                      color: SugarCommon.getLuminanceColor(
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
            ShareDataWidget.getValue(
              context,
              ['item', 'images'],
              defaultValue: [],
            ),
          ),
          [
            SugarSwitchCaseObj(sugarCase: () => 0, reValue: () => Container()),
            SugarSwitchCaseObj(
              sugarCase: () => 1,
              reValue: () => Padding(
                padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
                child: GestureDetector(
                  onTap: SugarCommon.voidCallBack(
                    function: _onImageTap,
                    value: 0,
                  ),
                  child: Hero(
                    tag: _getImageUrl(0),
                    child: ExtendedImage.network(
                      _getImageUrl(0),
                      height: _getImageWidthOrHeight(0, 0),
                      width: _getImageWidthOrHeight(0, 1),
                      fit: BoxFit.fill,
                      loadStateChanged:
                          SugarCommon.onImageStateChanged((loadState) {
                        return Sugar.switchCase(
                          loadState,
                          [
                            SugarSwitchCaseObj(
                              sugarCase: () => LoadState.loading,
                              reValue: () => ColoredBox(
                                color: Sugar.colorsWithOpacity(
                                  Colors.grey,
                                  0.2,
                                ),
                              ),
                            ),
                            SugarSwitchCaseObj(
                              sugarCase: () => LoadState.failed,
                              reValue: () => ColoredBox(
                                color: Sugar.colorsWithOpacity(
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
                    SugarDouble.divides(Sugar.width(context), 3), 2),
                child: GridView(
                  padding:
                      const EdgeInsets.only(left: 11, right: 11, bottom: 11),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: Sugar.mapEach(_getImageUrls(4), (index, imageItem) {
                    return GestureDetector(
                      onTap: SugarCommon.voidCallBack(
                        function: _onImageTap,
                        value: index,
                      ),
                      child: Hero(
                        tag: imageItem,
                        child: ExtendedImage.network(
                          imageItem,
                          fit: BoxFit.cover,
                          loadStateChanged:
                              SugarCommon.onImageStateChanged((loadState) {
                            return Sugar.switchCase(
                              loadState,
                              [
                                SugarSwitchCaseObj(
                                  sugarCase: () => LoadState.loading,
                                  reValue: () => ColoredBox(
                                    color: Sugar.colorsWithOpacity(
                                      Colors.grey,
                                      0.2,
                                    ),
                                  ),
                                ),
                                SugarSwitchCaseObj(
                                  sugarCase: () => LoadState.failed,
                                  reValue: () => ColoredBox(
                                    color: Sugar.colorsWithOpacity(
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
            padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: Sugar.mapEach(_getImageUrls(9), (index, imageItem) {
              return GestureDetector(
                onTap: SugarCommon.voidCallBack(
                  function: _onImageTap,
                  value: index,
                ),
                child: Sugar.ifEqualBool(
                    SugarBool.and(
                      SugarNum.greaterThan(
                        SugarList.length(
                          ShareDataWidget.getValue(
                            context,
                            ['item', 'images'],
                            defaultValue: [],
                          ),
                        ),
                        9,
                      ),
                      () => SugarNum.equalTo(index, 8),
                    ),
                    trueValue: () => Stack(
                          children: [
                            Positioned.fill(
                              child: Hero(
                                tag: imageItem,
                                child: ExtendedImage.network(
                                  imageItem,
                                  fit: BoxFit.cover,
                                  loadStateChanged:
                                      SugarCommon.onImageStateChanged(
                                          (loadState) {
                                    return Sugar.switchCase(
                                      loadState,
                                      [
                                        SugarSwitchCaseObj(
                                          sugarCase: () => LoadState.loading,
                                          reValue: () => ColoredBox(
                                            color: Sugar.colorsWithOpacity(
                                              Colors.grey,
                                              0.2,
                                            ),
                                          ),
                                        ),
                                        SugarSwitchCaseObj(
                                          sugarCase: () => LoadState.failed,
                                          reValue: () => ColoredBox(
                                            color: Sugar.colorsWithOpacity(
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
                              color: Sugar.colorsWithOpacity(Colors.grey, 0.2),
                              alignment: Alignment.center,
                              child: Text(
                                SugarString.concatenates(
                                    '+',
                                    SugarNum.numToString(
                                      SugarNum.subtracts(
                                        SugarList.length(
                                            ShareDataWidget.getValue(
                                          context,
                                          ['item', 'images'],
                                          defaultValue: [],
                                        )),
                                        9,
                                      ),
                                    ))
                                //_getImageMoreCount(),
                                ,
                                style: const TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                    falseValue: () => Hero(
                          tag: imageItem,
                          child: ExtendedImage.network(
                            imageItem,
                            fit: BoxFit.cover,
                            loadStateChanged:
                                SugarCommon.onImageStateChanged((loadState) {
                              return Sugar.switchCase(
                                loadState,
                                [
                                  SugarSwitchCaseObj(
                                    sugarCase: () => LoadState.loading,
                                    reValue: () => ColoredBox(
                                      color: Sugar.colorsWithOpacity(
                                        Colors.grey,
                                        0.2,
                                      ),
                                    ),
                                  ),
                                  SugarSwitchCaseObj(
                                    sugarCase: () => LoadState.failed,
                                    reValue: () => ColoredBox(
                                      color: Sugar.colorsWithOpacity(
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
          padding: const EdgeInsets.symmetric(horizontal: 11),
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
                    SugarInt.intToString(_getValue('comments', 0)),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              ),
              const Spacer(),
              LikeButton(
                size: 18.0,
                isLiked: _getValue('is_favorite', false),
                likeCount: _getValue('favorites', 0),

                // onTap:
                //     // (isLiked) => Sugar.futureValue<bool?>(SugarBool.invert(isLiked))
                //     // 需要保存 is_favorite 的值，只能特殊处理了
                onTap: SugarCommon.likeButtonTapCallback(
                  context,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 11),
          color: Sugar.colorsWithOpacity(Colors.grey, 0.2),
          height: 11,
        )
      ],
    );
  }
}
