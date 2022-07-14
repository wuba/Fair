
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

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
    return Color(color);
  }

  @override
  Widget build(BuildContext context) {
   return  Stack(
     alignment: AlignmentDirectional.center,
     children:<Widget> [
       SizedBox(
           width: 200.0,
           height: 100.0,
           child: ElevatedButton(
             onPressed: (){
               print("click bg");
             },
             child: null,
           )
       ),
       SizedBox(
         width: 100.0,
         height: 200.0,
         child:AbsorbPointer(
           child:  ElevatedButton(
             style: ElevatedButton.styleFrom(primary: _getButtonColor()),
             onPressed: (){
               print("click top");
             },
             child: null,
           ),
         )
       ),
     ],
   );
  }

}