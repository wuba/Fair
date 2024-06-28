import 'package:extended_image/extended_image.dart';
import 'package:fair/fair.dart';
import 'package:fair_gallery/src/delegate/delegate_base.dart';
import 'package:flutter/material.dart';

class PhotoSwiperDelegate extends FairDelegateBase {
  PhotoSwiperDelegate(super.data);
  final GlobalKey<ExtendedImageSlidePageState> _slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();
  @override
  Map<String, PropertyValue> bindValue() {
    return <String, PropertyValue>{
      ...super.bindValue(),
      '_slidePagekey': () => _slidePagekey,
    };
  }
}
