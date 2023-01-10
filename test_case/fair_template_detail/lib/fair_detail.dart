import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fair/fair.dart';

@FairPatch()
class FairDetail extends StatefulWidget {
  final dynamic fairProps;

  const FairDetail({Key? key, this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FairDetailState();
}

class _FairDetailState extends State<FairDetail> {
  @FairProps()
  var fairProps;

  @override
  void initState() {
    super.initState();
    fairProps = widget.fairProps;
  }

  /**
   * 顶部widget
   */
  Widget _topWidget() {
    return Stack(
      children: [
        Container(
          child: Image.asset('assets/images/zhibo.jpeg'),
        ),
        Positioned(
          top: 20,
          child: Container(
            height: 72,
            width: 66,
            child: Image.asset('assets/images/back.png'),
          ),
        )
      ],
    );
  }

  /**
   * 概要widget
   */
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
              fontSize: 15.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              _getTitle(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
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
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 时间&地点
   */
  Widget _timeAndLocation() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 20,
            height: 20,
            child: Image.asset('assets/images/time.png'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _getTime(),
              style: TextStyle(
                fontSize: 15.0,
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
              child: Image.asset('assets/images/location.png'),
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
        "Event Details",
        style: TextStyle(
            color: Colors.grey, fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    );
  }

  /**
   * 详细信息
   */
  Widget _information() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        _getDetailContent(),
        style: TextStyle(
            color: Color(0xFF121416),
            fontSize: 15.0,
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
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: Sugar.width(context),
        height: 45,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 15),
        child: ElevatedButton(
          child: Text("RSVP to Event"),
          onPressed:_onPress,
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
