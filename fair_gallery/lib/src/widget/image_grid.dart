// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:fair/fair.dart';

import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    super.key,
    required this.images,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.padding,
    required this.totalCount,
  });
  final List<Widget> images;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    int childCount = images.length;
    if (childCount == 0) {
      return Container();
    }
    if (childCount == 1) {
      return Container(
        child: images.first,
        padding: padding,
      );
    }

    double sreenWidth = Sugar.width(context);
    if (images.length == 4) {
      sreenWidth = sreenWidth / 3 * 2;
    }
    double width = sreenWidth;

    width -= (crossAxisCount - 1) * mainAxisSpacing;
    if (padding != null) {
      width -= padding!.horizontal;
    }
    width /= crossAxisCount;
    double height = width;
    int rowCount = (childCount / crossAxisCount).ceil();

    return Container(
      padding: padding,
      width: images.length == 4 ? Sugar.width(context) / 3 * 2 : null,
      height: height * rowCount +
          (rowCount - 1) * crossAxisSpacing +
          (padding?.vertical ?? 0),
      child: CustomMultiChildLayout(
        delegate: _ImageGridLayoutDelegate(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childCount: images.take(9).length,
        ),
        children: [
          for (var i = 0; i < images.length; i++)
            LayoutId(id: i, child: images[i])
        ],
      ),
    );
  }
}

class ImageGrid1 extends StatelessWidget {
  const ImageGrid1({
    super.key,
    required this.images,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.padding,
    required this.onImageTap,
  });
  final List<dynamic> images;

  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final void Function(int index) onImageTap;

  String _getImageUrl(int index) {
    if (index >= images.length) {
      return '';
    }
    var image = images[index];

    return 'https://photo.tuchong.com/' +
        image['user_id'].toString() +
        '/f/' +
        image['img_id'].toString() +
        '.jpg';
  }

  double _getImageWidthOrHeight(int index, int returnWidth) {
    if (index >= images.length) {
      return 0.0;
    }
    var num300 = 150.0;
    var num400 = 200.0;
    var height = 150.0;
    var width = 200.0;
    var image = images[index];
    height = image['height'] * 1.0;
    width = image['width'] * 1.0;
    var aspectRatio43 = 4.0 / 3.0;
    var aspectRatio34 = 3.0 / 4.0;
    var n = height / width;
    if (n >= aspectRatio43) {
      width = num300;
      height = num400;
    } else if (aspectRatio43 > n && n > aspectRatio34) {
      double maxValue = height;
      if (width > height) {
        maxValue = width;
      }

      height = num400 * height / maxValue;
      width = num400 * width / maxValue;
    } else if (n <= aspectRatio34) {
      width = num400;
      height = num300;
    }

    if (returnWidth == 1) {
      return width;
    } else {
      return height;
    }
  }

  @override
  Widget build(BuildContext context) {
    int childCount = images.length;
    if (childCount == 0) {
      return Container();
    }
    bool single = images.length == 1;
    buildImage(int index) {
      Widget image = ExtendedImage.network(
        _getImageUrl(index),
        width: single ? _getImageWidthOrHeight(0, 1) : null,
        height: single ? _getImageWidthOrHeight(0, 0) : null,
        fit: single ? BoxFit.fill : BoxFit.cover,
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.completed ||
              images.length > 9 && index == 8) {
            return null;
          }
          return ColoredBox(
            color: Sugar.colorsWithOpacity(
              Colors.grey,
              0.2,
            ),
          );
        },
      );
      if (images.length > 9 && index == 8) {
        image = Stack(
          children: [
            Positioned.fill(child: image),
            Container(
              color: Sugar.colorsWithOpacity(Colors.grey, 0.2),
              alignment: Alignment.center,
              child: Text(
                '+${images.length - 9}',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            )
          ],
        );
      }
      return GestureDetector(
        onTap: () {
          onImageTap(index);
        },
        child: Hero(
          tag: _getImageUrl(index),
          child: image,
        ),
      );
    }

    if (single) {
      return Container(
        child: buildImage(0),
        padding: padding,
      );
    }

    childCount = min(9, childCount);

    int crossAxisCount = 3;
    double sreenWidth = Sugar.width(context);
    if (childCount == 4) {
      sreenWidth = sreenWidth / 3 * 2;
      crossAxisCount = 2;
    }
    double width = sreenWidth;

    width -= (crossAxisCount - 1) * mainAxisSpacing;
    if (padding != null) {
      width -= padding!.horizontal;
    }
    width /= crossAxisCount;
    double height = width;
    int rowCount = (childCount / crossAxisCount).ceil();

    return Container(
      padding: padding,
      width: images.length == 4 ? Sugar.width(context) / 3 * 2 : null,
      height: height * rowCount +
          (rowCount - 1) * crossAxisSpacing +
          (padding?.vertical ?? 0),
      child: CustomMultiChildLayout(
        delegate: _ImageGridLayoutDelegate(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childCount: childCount,
        ),
        children: [
          for (var i = 0; i < childCount; i++)
            LayoutId(id: i, child: buildImage(i))
        ],
      ),
    );
  }
}

class _ImageGridLayoutDelegate extends MultiChildLayoutDelegate {
  _ImageGridLayoutDelegate({
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childCount,
  });
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int childCount;
  @override
  void performLayout(Size size) {
    double width = size.width;
    width -= (crossAxisCount - 1) * mainAxisSpacing;
    width /= crossAxisCount;
    double height = width;
    double dy = 0;
    Size childSize = Size(width, height);

    for (var i = 0; i < childCount;) {
      double dx = 0;
      for (var j = 0; j < crossAxisCount && i < childCount; j++, i++) {
        layoutChild(i, BoxConstraints.tight(childSize));
        positionChild(i, Offset(dx, dy));
        dx += mainAxisSpacing + width;
      }
      dy += childSize.height + crossAxisSpacing;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
