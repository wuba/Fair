import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class UrlLauncherExampleWidget extends StatefulWidget {
  String title = "";
  UrlLauncherExampleWidget({Key key, this.title}) : super(key: key);

  @override
  _UrlLauncherExampleWidgetState createState() {
    return _UrlLauncherExampleWidgetState();
  }
}

class _UrlLauncherExampleWidgetState extends State<UrlLauncherExampleWidget> {
  _UrlLauncherExampleWidgetState();

  @FairWell("_editingController")
  TextEditingController _editingController;

  @FairWell("_textAlign")
  TextAlign _textAlign = TextAlign.center;

  @FairWell("_launch")
  void _launch(){}

  @FairWell("_email")
  void _email(){}

  @FairWell("_tel")
  void _tel(){}

  @FairWell("_sms")
  void _sms(){}

  @FairWell("_launchByInput")
  void _launchByInput(){}

  @FairWell("_pop")
  void _pop(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 20,
          ),
          onTap: _pop,
        ),
        centerTitle: true,
        title: Text(
            widget.title
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: TextField(
                  controller: _editingController,
                  maxLines: 1,
                  minLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1882F1),
                    ),
                    child: Text(
                      "根据输入跳转",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _launchByInput,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1882F1),
                    ),
                    child: Text(
                      "跳转网络链接",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _launch,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1882F1),
                    ),
                    child: Text(
                      "发送email",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _email,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1882F1),
                    ),
                    child: Text(
                      "打电话",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _tel,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1882F1),
                    ),
                    child: Text(
                      "发送短信",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _sms,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}