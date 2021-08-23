
import 'package:fair/fair.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class SlidableModule extends FairModule<SlidableScrollActionPane>{

  static String tagName = 'SlidableScrollActionPane';

  SlidableModule() : super(tagName);

  @override
  SlidableScrollActionPane onCreateComponent(BuildContext ctx, Map<String, dynamic> props) {
    return SlidableScrollActionPane();
  }

}

class BottomNavyBarModule extends FairModule<BottomNavyBarItem>{

  static String tagName = 'BottomNavyBarItem';

  BottomNavyBarModule() : super(tagName);

  @override
  BottomNavyBarItem onCreateComponent(BuildContext ctx, Map<String, dynamic> props) {
    return BottomNavyBarItem(
      title: props['title'],
      icon: props['icon']
    );
  }

}