// ignore_for_file: implementation_imports

import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:widget_with_codeview/src/source_code_view.dart';

@FFRoute(
  name: 'fair://SourceCodeViewPage',
  routeName: 'SourceCodeViewPage',
)
class SourceCodeViewPage extends StatelessWidget {
  const SourceCodeViewPage({
    super.key,
    required this.asset,
  });
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('代码')),
      body: SourceCodeView(
        filePath: asset,
      ),
    );
  }
}
