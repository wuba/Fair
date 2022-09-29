import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * 基准线布局,将所有的元素都统一的放在一条水平线上,是根据child的baseline，来调整child的位置，即在不同的child都处在规定的基准线位置,
 * 多用文字排版中的时候，就算是不同大小的文字处于同一水平线上
 */
@FairPatch()
class FairBaselinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FairBaselinePageState();
}

class _FairBaselinePageState extends State<FairBaselinePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Baseline(
          baseline: 50.0,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            'TjTjTj',
            style: new TextStyle(
              fontSize: 20.0,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
        ),
        Baseline(
          baseline: 50.0,
          baselineType: TextBaseline.alphabetic,
          child: Container(
            width: 30.0,
            height: 30.0,
            color: Colors.red,
          ),
        ),
        Baseline(
          baseline: 50.0,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            'RyRyRy',
            style: TextStyle(
              fontSize: 35.0,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
        ),
      ],
    );
  }
}
