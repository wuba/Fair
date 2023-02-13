import 'package:fair_online/app/styles.dart';
import 'package:flutter/material.dart';

class StyledImageIcon extends StatelessWidget {
  final AssetImage image;
  final Color color;
  final double size;

  const StyledImageIcon(this.image,
      {Key? key, this.color = Colors.white, this.size = Sizes.iconMed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(image, size: size, color: color);
  }
}
