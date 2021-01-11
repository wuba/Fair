import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

@FairBinding()//
class GearItem extends StatelessWidget {
  final String description;
  final String label;
  final ImageProvider icon;
  GearItem({
    Key key,
    this.description =
        'Warm, dry, cool, and comfortable: Our favorite all-weather outer shell.',
    this.label = 'Outerwear',
    this.icon = const AssetImage('assets/images/jacket.png'),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(157.5, 48.0, 188.0, 63.0),
          size: Size(345.5, 158.0),
          pinLeft: true,
          pinRight: true,
          fixedHeight: true,
          child:
              // Adobe XD layer: 'Warm, dry, cool, an…' (text)
              Text(
            description,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: const Color(0xff333333),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 158.0, 158.0),
          size: Size(345.5, 158.0),
          pinLeft: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child:
              // Adobe XD layer: 'item' (group)
              Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 158.0, 158.0),
                size: Size(158.0, 158.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child:
                    // Adobe XD layer: 'icon' (group)
                    Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 158.0, 158.0),
                      size: Size(158.0, 158.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child:
                          // Adobe XD layer: 'zone' (shape)
                          Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(9.0, 126.0, 144.0, 20.0),
                      size: Size(158.0, 158.0),
                      pinLeft: true,
                      pinRight: true,
                      pinBottom: true,
                      fixedHeight: true,
                      child:
                          // Adobe XD layer: 'Outerwear' (text)
                          Text(
                        label,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 20,
                          color: const Color(0xff00a9de),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(28.0, 15.0, 102.0, 102.0),
                      size: Size(158.0, 158.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      fixedHeight: true,
                      child:
                          // Adobe XD layer: 'jacket' (shape)
                          Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
