import 'package:fair/fair.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'module.dart';
import 'src/generated.fair.dart';
import 'svg_const.dart';

@FairBinding(packages: [
  'package:adobe_xd/pinned.dart',
  'package:adobe_xd/page_link.dart',
  'package:flutter_svg/svg.dart',
])
void main() {
  runApp(
    FairApp(
      child: MaterialApp(home: MyApp()),
      generated: AppGeneratedModule(),
      modules: {
        PageLinkModule.tagName: () => PageLinkModule(),
        PageBuilderModule.tagName: () => PageBuilderModule(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XD to Flutter example',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FairWidget(
        name: 'adobe_xd',
        path: kIsWeb
            ? 'assets/bundle/lib_Home.fair.json'
            : 'assets/bundle/lib_Home.fair.bin',
        data: {
          'svg_il6hf2': svg_il6hf2,
          'svg_uvjlj2': svg_uvjlj2,
          'svg_6o6tx4': svg_6o6tx4,
          'svg_emmxj3': svg_emmxj3,
          'svg_dzwujb': svg_dzwujb,
          'svg_p45gdo': svg_p45gdo,
          'svg_20idv2': svg_20idv2
        },
      ) /*Home(svg_il6hf2: svg_il6hf2,
            svg_uvjlj2: svg_uvjlj2,
            svg_6o6tx4: svg_6o6tx4,
            svg_emmxj3: svg_emmxj3,
            svg_dzwujb: svg_dzwujb,
            svg_p45gdo: svg_p45gdo,
            svg_20idv2: svg_20idv2)*/
      , // Home is an artboard exported from Adobe XD
    );
  }
}
