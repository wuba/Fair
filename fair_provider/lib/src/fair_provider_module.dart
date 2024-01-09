import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'fair_provider_core.dart';

class FairProviderModule extends GeneratedModule {
  @override
  Map<String, dynamic> components() {
    return {
      'FairChangeNotifierProvider': (props) =>
      FairChangeNotifierProvider(
        key: props['key'],
        child: props['child'],
        initialJson: props['initialJson'],
      )
        ..setTypeArgumentList(props['ta']),
      'FairConsumer': (props) =>
      FairConsumer(
        key: props['key'],
        builder: props['builder'],
        child: props['child'],
      )
        ..setTypeArgumentList(props['ta']),
      'FairSelector': (props) =>
      FairSelector(
        key: props['key'],
        builder: props['builder'],
        selector: props['selector'],
        child: props['child'],
      )
        ..setTypeArgumentList(props['ta']),
      'SugarProvider.readString': (props) =>
          SugarProvider.readString(props['pa'][0], props['pa'][1]),
      'SugarProvider.readAsString': (props) =>
          SugarProvider.readAsString(props['pa'][0], props['pa'][1]),
      'SugarProvider.readInt': (props) =>
          SugarProvider.readInt(props['pa'][0], props['pa'][1]),
      'SugarProvider.readDouble': (props) =>
          SugarProvider.readDouble(props['pa'][0], props['pa'][1]),
      'SugarProvider.readBool': (props) =>
          SugarProvider.readBool(props['pa'][0], props['pa'][1]),
      'SugarProvider.readDynamic': (props) =>
          SugarProvider.readDynamic(props['pa'][0], props['pa'][1]),
      'SugarProvider.readList': (props) =>
          SugarProvider.readList(props['pa'][0], props['pa'][1]),
      'SugarProvider.readStringInList': (props) =>
          SugarProvider.readStringInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.readAsStringInList': (props) =>
          SugarProvider.readAsStringInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.readIntInList': (props) =>
          SugarProvider.readIntInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.readDoubleInList': (props) =>
          SugarProvider.readDoubleInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.readBoolInList': (props) =>
          SugarProvider.readBoolInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.readDynamicInList': (props) =>
          SugarProvider.readDynamicInList(props['pa'][0], props['pa'][1],  props['pa'][2]),
      'SugarProvider.evaluationToString': (props) =>
          SugarProvider.evaluationToString(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationAsString': (props) =>
          SugarProvider.evaluationAsString(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationToInt': (props) =>
          SugarProvider.evaluationToInt(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationToDouble': (props) =>
          SugarProvider.evaluationToDouble(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationToBool': (props) =>
          SugarProvider.evaluationToBool(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationToList': (props) =>
          SugarProvider.evaluationToList(props['pa'][0], props['pa'][1]),
      'SugarProvider.evaluationToDynamic': (props) =>
          SugarProvider.evaluationToDynamic(props['pa'][0], props['pa'][1]),
      'SugarProvider.anyToString': (props) =>
          SugarProvider.anyToString(props['pa'][0]),
      'SugarProvider.concatenates': (props) =>
          SugarProvider.concatenates(props['pa'][0], props['pa'][1]),
      'FairContextBuilder': (props) =>
          FairContextBuilder(
            key: props['key'],
            builder: props['builder'],
          ),
      'SugarProvider.onValueChangeWithFairContext': (props) =>
          SugarProvider.onValueChangeWithFairContext(function: props['function'], fairContext: props['fairContext']),
    };
  }

  @override
  Map<String, bool> mapping() {
    return {};
  }
}
