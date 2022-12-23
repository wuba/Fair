import '../../fair_common.dart';
import 'package:flutter/material.dart';
import 'package:fair/fair.dart';
@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  final dynamic fairProps;

  const @@PageName@@(
  {Key? key,
  this.fairProps = const {
  'auth': 'Internal Team',
  'title': 'Kickoff Meeting',
  'time': '8:00am',
  'location': 'Kaleo Office - San Starbucks',
  'des':
  'Short description goes here and can ben more than one line. Two lines is the best lenth Short description goes here and can ben more than one line. Two lines is the best lenth',
  'detail':
  'Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level.Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. '
  }})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  /// 顶部widget
  Widget _topWidget() {
    return Stack(
      children: [
        Container(
          child: Image.network('https://pic3.58cdn.com.cn/nowater/frs/n_v327380fe3313c44cb8528c6a7b5fb501c.jpg'),
        ),
        Positioned(
          top: 20,
          child: Container(
            height: 72,
            width: 66,
            child: Image.network('https://pic3.58cdn.com.cn/nowater/frs/n_v378fb424b4182441a9f743c44336ea9f5.png'),
          ),
        )
      ],
    );
  }

  /// 概要widget
  Widget _outlineWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getAuth(),
            style: TextStyle(
              color: Color(0xFF3978C4),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              _getTitle(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              _getDes(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 时间&地点
  Widget _timeAndLocation() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 20,
            height: 20,
            child: Image.network('https://pic7.58cdn.com.cn/nowater/frs/n_v37e6d7991117d417eac9b0214dbc3fb34.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _getTime(),
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF3978C4),
              ),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Container(
              width: 26,
              height: 20,
              child: Image.network('https://pic5.58cdn.com.cn/nowater/frs/n_v3df9d125924c84b129515973e617aebe1.png'),
            ),
          ),
          Expanded(
            child: Text(
              _getLocation(),
              style: TextStyle(color: Color(0xFF3978C4)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _DetailTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Text(
        'Event Details',
        style: TextStyle(
            color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  /// 详细信息
  Widget _information() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        _getDetailContent(),
        style: TextStyle(
            color: Color(0xFF121416),
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  String _getAuth() {
    return fairProps['auth'];
  }

  String _getTitle() {
    return fairProps['title'];
  }

  String _getDes() {
    return fairProps['des'];
  }

  String _getTime() {
    return fairProps['time'];
  }

  String _getLocation() {
    return fairProps['location'];
  }

  String _getDetailContent() {
    return fairProps['detail'];
  }

  void _onPress(){
    print('onPressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: Sugar.width(context),
        height: 45,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 15),
        child: ElevatedButton(
          onPressed:_onPress,
          child: Text('RSVP to Event'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topWidget(),
          _outlineWidget(),
          _timeAndLocation(),
          _DetailTitle(),
          _information(),
        ],
      ),
    );
  }
}
