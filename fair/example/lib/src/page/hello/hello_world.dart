// /*
//  * Copyright (C) 2005-present, 58.com.  All rights reserved.
//  * Use of this source code is governed by a BSD type license that can be
//  * found in the LICENSE file.
//  */
//
// import 'package:fair/fair.dart';
// import 'package:fair_example/src/page/plugins/net/sampe_list_view_src.dart';
// import 'package:flutter/material.dart';
//
// @FairPatch()
// class HelloWorldPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _State();
//   }
// }
//
// class _State extends State<HelloWorldPage> {
//   @FairWell('_platform')
//   final String _platform = 'Fair v$fairVersion';
//   @FairWell('_count')
//   int _count = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Fair Example'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.show_chart),
//             onPressed: onTapSetting,
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/image/logo.png'),
//             Padding(
//               padding: EdgeInsets.only(bottom: 40),
//               child: Text('Running with $_platform, click count = $_count'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             child: Icon(Icons.open_in_new),
//             heroTag: 'open_dynamic',
//             backgroundColor: Colors.pink,
//             onPressed: () {
//               MaterialPageRoute(
//                 builder: (context) => SampleWanAndroidPageSrc(),
//               );
//             },
//           ),
//           Padding(padding: EdgeInsets.only(right: Sugar.paddingTop(context))),
//           FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: onTapText,
//           )
//         ],
//       ),
//     );
//   }
//
//   @FairWell('onTapText')
//   void onTapText() {
//     setState(() {
//       _count++;
//     });
//   }
//
//   @FairWell('onTapSetting')
//   void onTapSetting() {
//     showFairAboutDialog(context);
//   }
// }
