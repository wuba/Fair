import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class PublicWidget extends StatelessWidget {
  final String fairPath;

  final Map? fairArguments;

  const PublicWidget({Key? key, required this.fairPath, this.fairArguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FairWidget(
      ///name 页面唯一id,每个个FairWidget使用不同的name,此处暂时使用fairPath
      ///当做name
      name: fairPath,
      path: fairPath,

      ///此处date传递需要使用fairProps为key的map,固定写法
      ///fairArguments可以是model的jsonString,建议使用
      ///jsonEncode转换成jsonString
      data: {
        'fairProps': jsonEncode(fairArguments),
      },
    );
  }
}
