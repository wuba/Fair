// ignore_for_file: unused_local_variable

import 'package:fair/fair.dart';
import 'package:fair_gallery/assets.dart';
import 'package:fair_gallery/src/plugin/fair_common_plugin.dart';
import 'package:fair_gallery/src/sugar/common.dart';
import 'package:fair_gallery/src/sugar/dart_core.dart';
import 'package:fair_gallery/src/widget/app_bar.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';

@FairPatch()
@FFRoute(
  name: 'fair://PluginDemo',
  routeName: 'FairPlugin 示例',
  description: '通过 FairPlugin 在 js 中与 Flutter 交互',
  exts: <String, dynamic>{
    ExtendedFairWidget.tag: true,
    'group': '简单',
    'order': 2,
  },
)
class PluginDemo extends StatefulWidget {
  const PluginDemo({super.key});

  @override
  State<PluginDemo> createState() => _PluginDemoState();
}

class _PluginDemoState extends State<PluginDemo> {
  @FairProps()
  var fairProps;
  final String _pageName = '#FairKey#';
  var feedList = [];
  @override
  void initState() {
    super.initState();
    onLoad();
  }

  String _getRouteName() {
    if (fairProps != null && fairProps['routeName'] != null) {
      return fairProps['routeName'];
    }
    return 'FairPlugin例子';
  }

  void onLoad() {
    FairCommonPlugin().http({
      'method': 'GET',
      'url': 'https://api.tuchong.com/feed-app',
      // required
      'pageName': _pageName,
      // if need, add a callback
      'callback': (dynamic result) {
        if (result != null) {
          var statusCode = result['statusCode'];
          if (statusCode == 200) {
            var map = result['json'];
            if (map != null) {
              feedList = map['feedList'];
              setState(() {});
            }
          }
        }
      },
    });
  }

  void _onRefresh(Map input) {
    String futureId = input['futureId'];
    // 可以传一些参数过去，多个参数用数组
    String argument = input['argument'];

    FairCommonPlugin().http({
      'method': 'GET',
      'url': 'https://api.tuchong.com/feed-app',
      // required
      'pageName': _pageName,
      // if need, add a callback
      'callback': (dynamic result) {
        if (result != null) {
          var statusCode = result['statusCode'];
          if (statusCode == 200) {
            var map = result['json'];
            if (map != null) {
              feedList = map['feedList'];
              setState(() {});
            }
          }
          FairCommonPlugin().futureComplete({
            // required
            'pageName': _pageName,
            'futureId': futureId,
            'futureValue': null,
          });
        }
      },
    });
  }

  String _getContent(int index) {
    var item = feedList[index];

    if (item != null) {
      if (item['content'] != null) {
        return item['content'];
      } else if (item['excerpt'] != null) {
        return item['excerpt'];
      } else {
        return _getSiteTitle(item);
      }
    }

    return index.toString();
  }

  String _getSiteTitle(dynamic item) {
    var site = item['site'];
    if (site != null && site['name'] != null) {
      return site['name'];
    }

    return '';
  }

  String _getImageUrl(int index) {
    if (index >= feedList.length) {
      return '';
    }
    var item = feedList[index];
    var images = item['images'];

    if (images == null || images.length < 1) {
      return '';
    }

    var image = images[0];

    return 'https://photo.tuchong.com/' +
        image['user_id'].toString() +
        '/f/' +
        image['img_id'].toString() +
        '.jpg';
  }

  void _onImageSaveTap(int index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommomAppBar(
          title: _getRouteName(),
          asset: Assets.assets_page_simple_plugin_dart,
        ),
        body: RefreshIndicator(
          onRefresh: () => Sugar.createFuture<void>(
            function: _onRefresh,
            argument: '可以传一些参数过去，多个参数用数组',
          ),
          child: Sugar.ifEqualBool(
            SugarIterable.isEmpty(feedList),
            trueValue: () => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
            falseValue: () => ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SugarString.concatenates(
                                  SugarInt.intToString(index), '.'),
                              style: const TextStyle(height: 1),
                              strutStyle: const StrutStyle(height: 1.2),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                _getContent(index),
                                maxLines: 5,
                                style: const TextStyle(height: 1),
                                strutStyle: const StrutStyle(height: 1.2),
                              ),
                            ),
                          ],
                        ),
                        Sugar.ifEqual(
                          _getImageUrl(index),
                          '',
                          trueValue: () => const SizedBox.shrink(),
                          falseValue: () => GestureDetector(
                            onTap: SugarCommon.voidCallBack(
                              function: _onImageSaveTap,
                              value: index,
                            ),
                            child: Image.network(
                              _getImageUrl(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: SugarList.length(feedList),
            ),
          ),
        ));
  }
}
