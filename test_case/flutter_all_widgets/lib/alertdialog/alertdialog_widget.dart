import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairAlertDialogPage extends StatefulWidget{

  dynamic fairProps;
  FairAlertDialogPage({Key key,this.fairProps}):super(key: key);
  @override
  State<StatefulWidget> createState() =>_FairAlertDialogPageState();

}

/**
 * 问题一：TextButton没有注册
 * 问题二：不支持() =>xxx写法
 * 问题三：AlertDialog不展示
 */
class _FairAlertDialogPageState extends State<FairAlertDialogPage>{
  @FairProps()
  var fairProps;


  @override
  void initState() {
    super.initState();
    this.fairProps =widget.fairProps;
  }

  String _getAlertContent(){
    return fairProps['content'];
  }

  void _cancelButton(){
    Navigator.pop(context,'取消');
  }

  void _showDialog(){
    showDialog<String>(
      context: context,
      builder: _getAlertDialog,
    );
  }

  Widget _getAlertDialog(BuildContext context){
    return AlertDialog(
      title: Text('Fair AlertDialog'),
      content: Text(_getAlertContent()),
      actions: <Widget>[
        TextButton(
            onPressed: _cancelButton,
            child: Text('Cancel')),
        TextButton(
            onPressed: _cancelButton,
            child: Text('Ok'))
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
//    return TextButton(onPressed: ()=>showDialog<String>( 此处报错type 'String' is not a subtype of type '(() => void)?'
//        context: context,
//        builder: (BuildContext context)=>AlertDialog(
//          title: Text('Fair AlertDialog'),
//          content: Text(_getAlertContent()),
//          actions: <Widget>[
//            TextButton(
//                onPressed: ()=>Navigator.pop(context,'取消'),
//                child: Text('Cancel')),
//            TextButton(
//                onPressed: ()=>Navigator.pop(context,'确定'),
//                child: Text('Ok'))
//          ],
//        )
//    ), child: Text('Fair Show Dialog'));
  return TextButton(onPressed: _showDialog, child: Text('Fair Show Dialog'));
  }

}

