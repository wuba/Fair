import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class OutlineButtonDemo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OutlineButton"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                print("Flutter Click Me");
              },
              child: const Text('Click Me'),
            ),
          ),
          Expanded(
            child: FairWidget(
                path:
                    'assets/bundle/outlinebutton/lib_outlinebutton_outlinebutton_demo.fair.json',
                data: {
                  'fairProps': jsonEncode({'content': 'Fair Click Me'})
                }),
          )
        ],
      ),
    );
  }
}

@FairPatch()
class FairOutlineButtonPage extends StatefulWidget {
  dynamic fairProps;

  FairOutlineButtonPage({Key key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairOutlineButtonPageState();
}

class _FairOutlineButtonPageState extends State<FairOutlineButtonPage> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  String _getButtonContent() {
    return fairProps['content'];
  }

  void _onClick(){
    print('Fair Click Me');
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _onClick,
      child: Text(_getButtonContent()),
    );
  }
}
