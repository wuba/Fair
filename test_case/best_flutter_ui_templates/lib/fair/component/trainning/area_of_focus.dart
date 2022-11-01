import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import '../../../fitness_app/fintness_app_theme.dart';

// class FocusView extends StatelessWidget {
//   const FocusView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 24.0,
//         crossAxisSpacing: 24.0,
//         childAspectRatio: 1.0,
//       ), itemBuilder: (BuildContext context, int index) {
//         return Text('index is');
//     });
//   }
// }


@FairPatch()
class FocusView extends StatefulWidget {
  const FocusView({Key? key}) : super(key: key);

  @override
  _FocusListViewState createState() => _FocusListViewState();
}

class _FocusListViewState extends State<FocusView> {
  // List<String> areaListData = <String>[
  //   'assets/fitness_app/area1.png',
  //   'assets/fitness_app/area2.png',
  //   'assets/fitness_app/area3.png',
  //   'assets/fitness_app/area1.png',
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: const Sugar.SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Text('tfjksadhfkasdf');
          },
        ),
        // child: GridView(
        //   padding:
        //       const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        //   physics: const BouncingScrollPhysics(),
        //   scrollDirection: Axis.vertical,
        //   children: Sugar.mapEach(areaListData, (index, item) {
        //     return AreaView(imagepath: areaListData[index]);
        //   }),
        //   // children: List<Widget>.generate(
        //   //   areaListData.length,
        //   //       (int index) {
        //   //     return AreaView(
        //   //       imagepath: areaListData[index]
        //   //     );
        //   //   },
        //   // ),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 24.0,
        //     crossAxisSpacing: 24.0,
        //     childAspectRatio: 1.0,
        //   ),
        // ),
      ),
    );
  }
}

// @FairBinding()
// class AreaView extends StatelessWidget {
//   const AreaView({
//     Key? key,
//     this.imagepath,
//   }) : super(key: key);
//
//   final String? imagepath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       transform: Matrix4.translationValues(0.0, 50, 0.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: FitnessAppTheme.white,
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(8.0),
//               bottomLeft: Radius.circular(8.0),
//               bottomRight: Radius.circular(8.0),
//               topRight: Radius.circular(8.0)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Sugar.colorsWithOpacity(FitnessAppTheme.grey, 0.4),
//                 offset: const Offset(1.1, 1.1),
//                 blurRadius: 10.0),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             focusColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//             splashColor:
//                 Sugar.colorsWithOpacity(FitnessAppTheme.nearlyDarkBlue, 0.2),
//             onTap: () {},
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
//                   child: Image.asset(imagepath!),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
