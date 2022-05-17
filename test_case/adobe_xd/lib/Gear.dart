import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './GearItem.dart';
import 'dart:ui';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

@FairPatch()
class Gear extends StatelessWidget {
  @FairWell('svg_6z8g0n')
  final String svg_6z8g0n;

  @FairWell('svg_d9sdjy')
  final String svg_d9sdjy;

  @FairWell('svg_munyoe')
  final String svg_munyoe;

  Gear({
    Key key, this.svg_6z8g0n, this.svg_d9sdjy, this.svg_munyoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.0, 632.0, 345.5, 158.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'GearItem' (component)
                GearItem(
              description:
                  'After 6 months of cooking on camp stoves, this was the last stove standing.',
              label: 'Supplies',
              icon: const AssetImage('assets/images/lantern.png'),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(15.0, 454.0, 345.5, 158.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'GearItem' (component)
                GearItem(
              description:
                  'Too heavy? Too small? Too much? Relax. This tent is Just Right.',
              label: 'Tent\n',
              icon: const AssetImage('assets/images/tent.png'),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.0, 276.0, 345.5, 158.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'GearItem' (component)
                GearItem(
              description:
                  'Warm, dry, cool, and comfortable: Our favorite all-weather outer shell.',
              label: 'Outerwear',
              icon: const AssetImage('assets/images/jacket.png'),
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 256.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'header' (group)
                Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 256.0),
                  size: Size(375.0, 256.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'photo' (shape)
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/camp.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x66000000),
                          offset: Offset(0, 3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 172.0, 375.0, 84.0),
                  size: Size(375.0, 256.0),
                  pinLeft: true,
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'rectangle' (shape)
                      ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.95, sigmaY: 4.95),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [
                              const Color(0x00000000),
                              const Color(0x00254f6e),
                              const Color(0xff254f6e)
                            ],
                            stops: [0.0, 0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(344.0, 33.0, 19.0, 27.0),
                  size: Size(375.0, 256.0),
                  pinRight: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'send icon' (shape)
                      SvgPicture.string(
                    svg_6z8g0n,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(304.0, 38.0, 22.0, 22.0),
                  size: Size(375.0, 256.0),
                  pinRight: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'search icon' (shape)
                      SvgPicture.string(
                    svg_d9sdjy,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(12.0, 38.0, 11.3, 19.0),
                  size: Size(375.0, 256.0),
                  pinLeft: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'back button' (shape)
                      PageLink(
                    links: [
                      PageLinkInfo(),
                    ],
                    child: SvgPicture.string(
                      svg_munyoe,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(11.5, 214.0, 352.0, 17.0),
                  size: Size(375.0, 256.0),
                  pinLeft: true,
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'Your own personal s…' (text)
                      Text(
                    'Your own personal sherpa.',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(11.5, 197.0, 352.0, 16.0),
                  size: Size(375.0, 256.0),
                  pinLeft: true,
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'Gear Guide' (text)
                      Text(
                    'GEAR GUIDE',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 16,
                      color: const Color(0xfffbf7ff),
                      letterSpacing: 0.64,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
