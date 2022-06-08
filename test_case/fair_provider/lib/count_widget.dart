import 'package:demo/theme.dart';
import 'package:fair/fair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@FairBinding()
class Count extends StatelessWidget {
  final int count;

  const Count({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
        '$count',
        key: const Key('counterState'),
        style: ThemeStyle.headline4(context));
  }
}
