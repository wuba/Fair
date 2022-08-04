
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 *
 * RichText的text属性type 'WarningWidget' is not a subtype of type 'InlineSpan'
 *
 */
@FairPatch()
class FairRichTextPage extends StatefulWidget{

  dynamic fairProps;

  FairRichTextPage({Key key, this.fairProps}):super(key: key);

  @override
  State<StatefulWidget> createState()=> _FairRichTextPageState();

}

class _FairRichTextPageState extends State<FairRichTextPage>{
  @FairProps()
  var fairProps;

  @override
  void initState() {
    fairProps = widget.fairProps;
  }

  String _getContent(){
    return fairProps['content'];
  }

  List<TextSpan> _getChildren(){
    return <TextSpan>[
      TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: ' world!'),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: 'Hello',
          style: DefaultTextStyle.of(context).style,
          children: _getChildren(),
//          children: <TextSpan>[
//            TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
//            TextSpan(text: ' world!'),
//          ],此写法报：type 'List<dynamic>' is not a subtype of type 'List<InlineSpan>?'
        ),
      ),
    );
  }


}