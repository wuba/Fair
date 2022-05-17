import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libs_app/colors.dart';

@FairPatch()
class FairPackageInfoWidget extends StatefulWidget {
  final String title;
  FairPackageInfoWidget({required Key key, required this.title}) : super(key: key);

  @override
  _FairPackageInfoWidgetState createState() {
    return _FairPackageInfoWidgetState();
  }
}

class _FairPackageInfoWidgetState extends State<FairPackageInfoWidget> {
  @FairWell('_appName')
  String _appName = "";
  @FairWell('_packageName')
  String _packageName = "";
  @FairWell('_version')
  String _version = "";
  @FairWell('_buildNumber')
  String _buildNumber = "";

  @FairWell('_textAlign')
  TextAlign _textAlign = TextAlign.center;

  @FairWell('_getPackageInfo')
  Future<void> _getPackageInfo() async {

  }

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
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
                "appName= $_appName",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333)
                ),
              ),
              Text(
                "packageName= $_packageName",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333)
                ),
              ),
              Text(
                "version= $_version",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333)
                ),
              ),
              Text(
                "buildNumber= $_buildNumber",
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
                      "获取PackageInfo",
                      textAlign: _textAlign,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                  onTap: _getPackageInfo,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
