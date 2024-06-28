// ignore_for_file: unused_field

import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';

import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';

@FairPatch()
@FFRoute(
  name: 'fair://SugarDemo',
  routeName: '语法糖例子',
  description: '常用语法糖例子',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '简单',
    'order': 1,
  },
)
class SugarDemo extends StatefulWidget {
  const SugarDemo({
    super.key,
    required this.fairProps,
  });

  final Map<String, dynamic> fairProps;

  @override
  State<SugarDemo> createState() => _SugarDemoState();
}

class _SugarDemoState extends State<SugarDemo> {
  @FairProps()
  var fairProps;
  final String _pageName = '#FairKey#';
  var _data;
  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
    onLoad();
  }

  void onLoad() {
    if (fairProps != null && fairProps['itemData'] != null) {
      _data = fairProps['itemData'];

      setState(() {});
    }
  }

  String _getRouteName() {
    if (fairProps != null && fairProps['routeName'] != null) {
      return fairProps['routeName'];
    }
    return '';
  }

  dynamic _getValue(String key, dynamic defaultValue) {
    if (_data != null && _data[key] != null) {
      return _data[key];
    }
    return defaultValue;
  }

  String _getImageUrl(int index) {
    if (_data == null || _data['images'] == null) {
      return '';
    }

    var images = _data['images'];

    if (images.length < 1) {
      return '';
    }

    var image = images[index];

    return 'https://photo.tuchong.com/' +
        image['user_id'].toString() +
        '/f/' +
        image['img_id'].toString() +
        '.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommomAppBar(
        title: _getRouteName(),
        asset: Assets.assets_page_simple_sugar_dart,
      ),
      body: Sugar.ifEqualBool(
        SugarCommon.isNull(_data),
        trueValue: () => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
        falseValue: () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Sugar.ifEqualBool(
                      SugarNum.greaterThan(_getValue('views', 0), 1000),
                      trueValue: () {
                    return Container(
                      margin: const EdgeInsets.all(11),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Text('热门',
                          style: TextStyle(color: Colors.white)),
                    );
                  }, falseValue: () {
                    return Container();
                  }),
                  Sugar.ifEqual(
                    _getValue('type', ''),
                    'multi-photo',
                    trueValue: () {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Text('多图',
                            style: TextStyle(color: Colors.white)),
                      );
                    },
                    falseValue: () => Container(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
                child: Wrap(
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: Sugar.mapEach(
                    SugarIterable.toList(
                        SugarIterable.take(_getValue('tags', []), 6)),
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
                  ),
                ),
              ),
              Sugar.switchCase(
                _getValue('image_count', 0),
                [
                  SugarSwitchCaseObj(
                    sugarCase: () => 0,
                    reValue: () => Container(),
                  ),
                  SugarSwitchCaseObj(
                    sugarCase: () => 1,
                    reValue: () => Image.network(_getImageUrl(0)),
                  ),
                ],
                () => GridView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(11),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  children: Sugar.mapEach(
                      SugarIterable.toList(SugarIterable.take(
                        _getValue('images', []),
                        9,
                      )),
                      (index, item) =>
                          Image.network(_getImageUrl(index), frameBuilder: (
                            context,
                            child,
                            frame,
                            wasSynchronouslyLoaded,
                          ) {
                            return Sugar.ifEqualBool(
                              wasSynchronouslyLoaded,
                              trueValue: () => child,
                              falseValue: () => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Sugar.ifEqualBool(
                                  SugarCommon.isNull(frame),
                                  trueValue: () => Container(
                                    color: Sugar.colorsWithOpacity(
                                      Colors.grey,
                                      0.3,
                                    ),
                                  ),
                                  falseValue: () => child,
                                ),
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
