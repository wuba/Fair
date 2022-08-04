
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 *  formatException:Unexpected character(at character 1) jsAppObj is null
 */
@FairPatch()
class FairAbsorbPointerPage extends StatefulWidget{

  dynamic fairProps;

  FairAbsorbPointerPage({Key key,this.fairProps}): super(key: key);

  @override
  State<StatefulWidget> createState()=>_FairAbsorbPointerPageState();

}

class _FairAbsorbPointerPageState extends State<FairAbsorbPointerPage>{

  @FairProps()
  var fairProps;


  @override
  void initState() {
    super.initState();
    this.fairProps = widget.fairProps;
  }

  Color _getButtonColor(){
    var color = fairProps['color'];
    return Colors.blue.shade200;
  }

  void _clickButtonBg(){
    print("click bg");
  }

  void _clickButtonTop(){
    print("click top");
  }

  ButtonStyle _getButtonStyle(){
    ElevatedButton.styleFrom(primary: Colors.blue.shade200);
  }

  @override
  Widget build(BuildContext context) {
   return  Stack(
     alignment: AlignmentDirectional.center,
     children:<Widget> [
//       SizedBox(
//           width: 200.0,
//           height: 100.0,
//           child: ElevatedButton(
//             onPressed: _clickButtonBg,
//             child: null,
//           )
//       ),
       SizedBox(
         width: 100.0,
         height: 200.0,
//         child:AbsorbPointer(
           child:  ElevatedButton(
             style: _getButtonStyle(),
             onPressed: _clickButtonTop,
             child: null,
           ),
//         )
       ),
     ],
   );
  }

}