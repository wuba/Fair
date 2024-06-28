import 'package:fair/fair.dart';
import 'package:fair_gallery/fair_gallery_routes.dart';
import 'package:fair_gallery/src/delegate/photo_gallery.dart';
import 'package:fair_gallery/src/delegate/photo_swiper.dart';
import 'package:flutter/material.dart';

class FairDelegateBase extends FairDelegate {
  FairDelegateBase(this.data);
  final Map<String, dynamic>? data;

  @override
  Map<String, PropertyValue> bindValue() {
    return <String, PropertyValue>{
      ...super.bindValue(),
      'context': () => context,
    };
  }

  static Map<String, FairDelegateBuilder> delegates =
      <String, FairDelegateBuilder>{
    for (var routeName in routeNames)
      routeName: (context, data) => FairDelegateBase(data),
    Routes.fairPhotoGalleryPage.name: (
      BuildContext context,
      Map<String, dynamic>? data,
    ) =>
        PhotoGalleryDelegate(data),
    Routes.fairPhotoGalleryPage1.name: (
      BuildContext context,
      Map<String, dynamic>? data,
    ) =>
        PhotoGalleryDelegate(data),
    Routes.fairPhotoSwiper.name: (
      BuildContext context,
      Map<String, dynamic>? data,
    ) =>
        PhotoSwiperDelegate(data),
  };
}
