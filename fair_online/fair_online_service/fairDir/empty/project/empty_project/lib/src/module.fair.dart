
import 'package:flutter/material.dart';

import 'generated.fair.dart';

class FairAppModule extends AppGeneratedModule {
  @override
  Map<String, dynamic> components() {
    return super.components()
      ..addAll({
        'SliverChildBuilderDelegate': (props) => SliverChildBuilderDelegate(
              props['pa'][0],
              childCount: props['childCount'],
              addAutomaticKeepAlives: props['addAutomaticKeepAlives'] ?? true,
              addRepaintBoundaries: props['addRepaintBoundaries'] ?? true,
              addSemanticIndexes: props['addSemanticIndexes'] ?? true,
              semanticIndexOffset: props['semanticIndexOffset'] ?? 0,
            ),
        'InputBorder.none': InputBorder.none,
      });
  }
}
