// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:extended_image/extended_image.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:fair_gallery/src/widget/hero_widget.dart';
import 'package:fair_gallery/src/widget/source_code_view_button.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';

@FairPatch()
@FFRoute(
  name: 'fair://PhotoSwiper',
  routeName: 'PhotoSwiper',
  description: '图片预览页面',
  pageRouteType: PageRouteType.transparent,
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
  },
)
class PhotoSwiper extends StatefulWidget {
  const PhotoSwiper({super.key, required this.fairProps});
  final Map<String, dynamic> fairProps;
  @override
  State<PhotoSwiper> createState() => _PhotoSwiperState();
}

class _PhotoSwiperState extends State<PhotoSwiper> {
  late GlobalKey<ExtendedImageSlidePageState> _slidePagekey;
  @FairProps()
  var fairProps;
  var index;
  var initialPage;
  var images = [];
  bool _showHeader = true;
  final String _pageName = '#FairKey#';
  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
    _slidePagekey = GlobalKey<ExtendedImageSlidePageState>();
    onLoad();
  }

  void onLoad() {
    index = fairProps['index'];
    initialPage = index;
    images = fairProps['images'];
  }

  void onUnload() {}

  @override
  void dispose() {
    onUnload();
    super.dispose();
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

  void _onImageTap() {
    FairCommonPlugin().navigate({
      // required
      'pageName': _pageName,
      'method': 'pop',
    });
  }

  void _onPageChanged(int value) {
    index = value;
    setState(() {});
  }

  String _getImagedescription(int index) {
    var image = images[index];
    if (image != null) {
      if (image['title'] != null) {
        return image['title'];
      } else if (image['description'] != null) {
        return image['description'];
      }
    }
    return '';
  }

  void _onImageSaveTap() {
    FairCommonPlugin().savePhoto({
      // required
      'pageName': _pageName,
      // if need, add a callback
      'callback': (dynamic result) {
        var success = result['success'];
        if (success == true) {
          FairCommonPlugin().showToast({
            'pageName': _pageName,
            'msg': '图片保存成功',
          });
        }
      },
      'url': _getImageUrl(index),
    });
  }

  void _onSlidingPage(bool isSliding) {
    var showHeader = !isSliding;
    if (showHeader != _showHeader) {
      _showHeader = showHeader;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ExtendedImageSlidePage(
        key: _slidePagekey,
        slideAxis: SlideAxis.both,
        slideType: SlideType.wholePage,
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImageGesturePageView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _onImageTap,
                    child: HeroWidget(
                      tag: _getImageUrl(index),
                      slidePagekey: _slidePagekey,
                      slideType: SlideType.wholePage,
                      child: ExtendedImage.network(
                        _getImageUrl(index),
                        fit: BoxFit.contain,
                        enableSlideOutPage: true,
                        mode: ExtendedImageMode.gesture,
                      ),
                    ),
                  );
                },
                controller: ExtendedPageController(
                  initialPage: initialPage,
                  pageSpacing: 50,
                  shouldIgnorePointerWhenScrolling: false,
                ),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemCount: SugarList.length(images),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Sugar.ifEqualBool(_showHeader,
                  trueValue: () => DefaultTextStyle(
                        style: const TextStyle(color: Colors.blue),
                        child: Container(
                          margin:
                              EdgeInsets.only(top: Sugar.paddingTop(context)),
                          height: 50.0,
                          width: Sugar.width(context),
                          color: Sugar.colorsWithOpacity(Colors.grey, 0.2),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 10.0,
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: SugarNum.numToString(
                                        SugarNum.adds(index, 1))),
                                const TextSpan(text: ' / '),
                                TextSpan(
                                    text: SugarInt.intToString(
                                        SugarList.length(images))),
                              ])),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                  child: Text(_getImagedescription(index),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.blue))),
                              const SizedBox(
                                width: 10.0,
                              ),
                              GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.save,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: _onImageSaveTap),
                              const SourceCodeViewButton(
                                asset: Assets
                                    .assets_page_complex_photo_swiper_dart,
                              )
                            ],
                          ),
                        ),
                      ),
                  falseValue: () => Container()),
            ),
          ],
        ),
        onSlidingPage: SugarCommon.onSlidingPage(_onSlidingPage),
      ),
    );
  }
}
