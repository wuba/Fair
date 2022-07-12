
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          text: _getContent(),
          style: DefaultTextStyle.of(context).style,
          children: const <TextSpan>[
            TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' world!'),
          ],
        ),
      ),
    );
  }


}