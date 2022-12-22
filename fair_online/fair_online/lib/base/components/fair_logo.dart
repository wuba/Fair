import 'package:flutter/material.dart';

class FairLogo extends StatelessWidget {
  final double size;
  final Color color;

  const FairLogo(this.size, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/fair-logo.png", color: color, height: size);
  }
}
