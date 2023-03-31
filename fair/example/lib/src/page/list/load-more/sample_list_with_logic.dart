import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// {
//   "className": "Padding",
//   "na": {
//     "padding": {
//       "className": "EdgeInsets.only",
//       "na": {
//         "left": 20,
//         "bottom": 60,
//         "top": 60
//       }
//     },
//     "child": {
//       "className": "Text",
//       "pa": [
//         "%(_generateTitle)"
//       ],
//       "na": {
//         "overflow": "#(TextOverflow.ellipsis)",
//         "maxLines": 1,
//         "style": {
//           "className": "TextStyle",
//           "na": {
//             "fontSize": 40,
//             "color": {
//               "className": "Color",
//               "pa": [
//                 "0xFF0B0F12"
//               ]
//             }
//           }
//         }
//       }
//     }
//   }
// }
@FairPatch()
class SampleListWithLogic extends StatefulWidget {
  const SampleListWithLogic({Key? key}) : super(key: key);

  @override
  State<SampleListWithLogic> createState() => _SampleListWithLogicState();
}

class _SampleListWithLogicState extends State<SampleListWithLogic> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _generateTitle() {
    return fairProps['item'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 60,
        bottom: 60,
      ),
      child: Text(
        _generateTitle(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 40,
          color: Color(0xFF0B0F12),
        ),
      ),
    );
  }
}
