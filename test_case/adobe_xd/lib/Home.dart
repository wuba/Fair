import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Gear.dart';
import 'ItemWidget.dart';

@FairPatch()
class Home extends StatelessWidget {
  @FairWell('svg_il6hf2')
  final String svg_il6hf2;

  @FairWell('svg_uvjlj2')
  final String svg_uvjlj2;

  @FairWell('svg_6o6tx4')
  final String svg_6o6tx4;

  @FairWell('svg_emmxj3')
  final String svg_emmxj3;

  @FairWell('svg_dzwujb')
  final String svg_dzwujb;

  @FairWell('svg_p45gdo')
  final String svg_p45gdo;

  @FairWell('svg_20idv2')
  final String svg_20idv2;

  Home({
    Key key,
    this.svg_il6hf2,
    this.svg_uvjlj2,
    this.svg_6o6tx4,
    this.svg_emmxj3,
    this.svg_dzwujb,
    this.svg_p45gdo,
    this.svg_20idv2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff254f6e),
      body: Stack(
        children: <Widget>[
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.5, 672.0, 348.0, 120.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            pinBottom: true,
            child:
                // Adobe XD layer: 'adventuresCard' (group)
                Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 348.0, 120.0),
                  size: Size(348.0, 120.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'rectangle background' (shape)
                      Container(
                    decoration: BoxDecoration(
                      color: const Color(0x80353535),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x13000000),
                          offset: Offset(1, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(172.0, 102.0, 165.0, 13.0),
                  size: Size(348.0, 120.0),
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: '2 hours ago' (text)
                      Text(
                    '2 hours ago',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 11,
                      color: const Color(0xff00a9de),
                      letterSpacing: 0.11,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(172.0, 38.0, 165.0, 55.0),
                  size: Size(348.0, 120.0),
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'Finding Beauty' (text)
                      Text(
                    'Finding Beauty in the Badlands: A Trip to the Alberta Badlands.',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(172.0, 14.0, 165.0, 16.0),
                  size: Size(348.0, 120.0),
                  pinRight: true,
                  pinTop: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'Adventures' (text)
                      Text(
                    'Adventures',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 12,
                      color: const Color(0x80ffffff),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 158.0, 120.0),
                  size: Size(348.0, 120.0),
                  pinLeft: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'photo Badlands' (shape)
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/badlands.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.5, 635.5, 348.0, 16.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'Latest Adventures' (text)
                Text(
              'LATEST ADVENTURES',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 16,
                color: const Color(0xfffbf7ff),
                letterSpacing: 0.64,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.5, 497.0, 348.0, 115.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'mapCard' (group)
                Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 348.0, 115.0),
                  size: Size(348.0, 115.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff00a9de),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(4.0, 0.0, 340.0, 115.0),
                  size: Size(348.0, 115.0),
                  pinTop: true,
                  pinBottom: true,
                  fixedWidth: true,
                  child:
                      // Adobe XD layer: 'map' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 340.0, 115.0),
                        size: Size(340.0, 115.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child:
                            // Adobe XD layer: 'rectangle trail' (shape)
                            Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  const AssetImage('assets/images/trail.png'),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  // TODO
                                  Colors.black,
                                  //Colors.black.withOpacity(0.59),
                                  BlendMode.dstIn),
                            ),
                          ),
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(268.0, 82.0, 20.0, 12.0),
                        size: Size(340.0, 115.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'mountains 2' (shape)
                            SvgPicture.string(
                          svg_il6hf2,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(256.5, 57.0, 40.0, 13.0),
                        size: Size(340.0, 115.0),
                        pinRight: true,
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'The Great' (text)
                            Text(
                          'The Great\nWhite Throne',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 6,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(65.0, 35.0, 20.0, 12.0),
                        size: Size(340.0, 115.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'mountains 1' (shape)
                            SvgPicture.string(
                          svg_uvjlj2,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(60.0, 21.0, 30.0, 5.0),
                        size: Size(340.0, 115.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'Mt Majestic' (text)
                            Text(
                          'Mt Majestic',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 5,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.5, 287.0, 348.0, 190.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'latestTripCard' (group)
                Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 348.0, 190.0),
                  size: Size(348.0, 190.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'white rectangle' (shape)
                      Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(3.0, 130.5, 340.0, 48.0),
                  size: Size(348.0, 190.0),
                  pinLeft: true,
                  pinRight: true,
                  pinBottom: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'days, miles, camps,…' (none)
                      SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 0,
                      runSpacing: 20,
                      children: [
                        ItemWidget(value: '10', label: 'Days'),
                        ItemWidget(value: '160', label: 'Miles'),
                        ItemWidget(value: '5', label: 'Camps'),
                        ItemWidget(value: '2', label: 'Bears'),
                      ],
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(134.0, 38.0, 80.0, 80.0),
                  size: Size(348.0, 190.0),
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'gray circle' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      color: const Color(0xffd5d5d5),
                    ),
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(305.5, 15.5, 22.0, 22.0),
                  size: Size(348.0, 190.0),
                  pinRight: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'compass' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 22.0, 22.0),
                        size: Size(22.0, 22.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child:
                            // Adobe XD layer: 'ellipse' (shape)
                            SvgPicture.string(
                          svg_6o6tx4,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(6.7, 6.6, 8.3, 8.3),
                        size: Size(22.0, 22.0),
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'path' (shape)
                            SvgPicture.string(
                          svg_emmxj3,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(16.0, 15.0, 269.0, 12.0),
                  size: Size(348.0, 190.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'Your latest trip' (text)
                      Text(
                    'YOUR LATEST TRIP',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 11,
                      color: const Color(0xff333333),
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(13.5, 224.0, 348.0, 48.0),
            size: Size(375.0, 812.0),
            pinLeft: true,
            pinRight: true,
            pinTop: true,
            fixedHeight: true,
            child:
                // Adobe XD layer: 'gearGuideBtn' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.SlideLeft,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: pageBuilder,
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 348.0, 48.0),
                    size: Size(348.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'rectangle' (shape)
                        Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff00a9de),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff00a9de)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xa8000000),
                            offset: Offset(1, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(15.0, 17.5, 325.0, 16.0),
                    size: Size(348.0, 48.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Our Blog' (text)
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
          ),
          Pinned.fromSize(
            bounds: Rect.fromLTWH(14.0, 38.0, 348.0, 130.5),
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
                  bounds: Rect.fromLTWH(130.0, 130.5, 88.0, 1.0),
                  size: Size(348.0, 130.5),
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'blue divider line' (shape)
                      SvgPicture.string(
                    svg_dzwujb,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(10.0, 45.0, 327.0, 74.0),
                  size: Size(348.0, 130.5),
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'Welcome to Campvibe…' (text)
                      Text(
                    'Welcome to Campvibes!',
                    style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 30,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(326.0, 0.0, 22.0, 22.0),
                  size: Size(348.0, 130.5),
                  pinRight: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'search icon' (shape)
                      SvgPicture.string(
                    svg_20idv2,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 28.0, 21.0),
                  size: Size(348.0, 130.5),
                  pinLeft: true,
                  pinTop: true,
                  fixedWidth: true,
                  fixedHeight: true,
                  child:
                      // Adobe XD layer: 'tent icon' (shape)
                      SvgPicture.string(
                    svg_p45gdo,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @FairWell('pageBuilder')
  final pageBuilder = () => Gear();
}
