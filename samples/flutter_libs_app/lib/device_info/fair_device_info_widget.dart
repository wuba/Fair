import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairDeviceInfoWidget extends StatefulWidget {
  final String title;

  FairDeviceInfoWidget({Key key, this.title}) : super(key: key);

  @override
  _FairDeviceInfoWidgetState createState() {
    return _FairDeviceInfoWidgetState();
  }
}

class _FairDeviceInfoWidgetState extends State<FairDeviceInfoWidget> {
  @FairProps()
  var fairProps;

  @FairWell('_deviceInfo')
  String _deviceInfo = "";
  // @FairWell('_textAlign')
  // TextAlign _textAlign = TextAlign.center;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @FairWell('_getDeviceInfo')
  Future<void> _getDeviceInfo() async {

  }

  @FairWell('_pop')
  void _pop(){}

  @override
  void dispose() {
    super.dispose();
  }

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
              Text(
                "$_deviceInfo",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333)
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
                      "获取设备信息",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _getDeviceInfo,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
