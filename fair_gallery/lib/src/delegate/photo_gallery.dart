import 'dart:async';

import 'package:fair/fair.dart';
import 'package:fair_gallery/fair_gallery_routes.dart';
import 'package:fair_gallery/src/page/complex/photo_gallery_item.dart';
import 'package:fair_gallery/src/utils/repository.dart';
import 'package:fair_gallery/src/widget/extended_fair_widget.dart';
import 'package:flutter/material.dart';
import 'package:keframe/keframe.dart';
import 'package:fair_gallery/src/delegate/delegate_base.dart';

class PhotoGalleryDelegate extends FairDelegateBase {
  PhotoGalleryDelegate(super.data);
  final LoadingMoreRepository _repository = LoadingMoreRepository();

  @override
  Map<String, Function> bindFunction() {
    return <String, Function>{
      ...super.bindFunction(),
      '_itemBuilder': _itemBuilder,
      '_onRefresh': _onRefresh,
    };
  }

  @override
  Map<String, PropertyValue> bindValue() {
    return <String, PropertyValue>{
      ...super.bindValue(),
      '_repository': () => _repository,
    };
  }

  Future<bool> _onRefresh() {
    return _repository.refresh();
  }

  Widget _itemBuilder(BuildContext context, dynamic item, int index) {
    final fairProps = <String, dynamic>{
      'item': item,
      'index': index,
    };
    final Map<int?, Size>? size = SizeCacheWidget.of(context)?.itemsSizeCache;
    double height = size?[index]?.height ?? 200;
    return FrameSeparateWidget(
      index: index,
      child: ExtendedFairWidget(
        builder: (context) => PhotoGalleryItem(fairProps: fairProps),
        name: Routes.fairPhotoGalleryItem.name,
        fairProps: fairProps,
        holder: (b) => SizedBox(height: height),
      ),
      placeHolder: SizedBox(height: height),
    );
  }
}
