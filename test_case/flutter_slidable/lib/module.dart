
import 'package:fair/fair.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableModule extends FairModule<SlidableScrollActionPane>{

  static String tagName = 'SlidableScrollActionPane';

  SlidableModule() : super(tagName);

  @override
  SlidableScrollActionPane onCreateComponent(BuildContext ctx, Map<String, dynamic>? props) {
    return SlidableScrollActionPane();
  }

}
