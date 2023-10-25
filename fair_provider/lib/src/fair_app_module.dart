import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'fair_provider_core.dart';

class FairAppModule extends GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return {
      'InputBorder.none': InputBorder.none,
      'FairChangeNotifierProvider': (props) => FairChangeNotifierProvider(
            key: props['key'],
            child: props['child'],
            initialJson: props['initialJson'],
          )..setTypeArgumentList(props['ta']),
      'FairConsumer': (props) => FairConsumer(
            key: props['key'],
            builder: props['builder'],
            child: props['child'],
          )..setTypeArgumentList(props['ta']),
      'FairSelector': (props) => FairSelector(
            key: props['key'],
            builder: props['builder'],
            selector: props['selector'],
            child: props['child'],
          )..setTypeArgumentList(props['ta']),
      'FairSugarProvider.valueReader': (props) =>
          FairSugarProvider.valueReader(props['pa'][0], props['pa'][1]),
      'FairSugarProvider.stringValueReader': (props) =>
          FairSugarProvider.stringValueReader(props['pa'][0], props['pa'][1]),
      'FairSugarProvider.evaluationToString': (props) =>
          FairSugarProvider.evaluationToString(props['pa'][0], props['pa'][1]),
      'FairSugarProvider.anyToString': (props) =>
          FairSugarProvider.anyToString(props['pa'][0]),
      'FairContextBuilder': (props) => FairContextBuilder(
            key: props['key'],
            builder: props['builder'],
          ),
    };
  }

  @override
  Map<String, bool> mapping() {
    return {};
  }
}
