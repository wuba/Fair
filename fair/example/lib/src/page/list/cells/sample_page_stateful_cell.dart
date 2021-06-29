import 'package:fair/fair.dart';
import '../../../model/bean/loupan_bean.dart';
import 'package:flutter/material.dart';

part 'sample_page_stateful_cell.js.dart';

@FairPatch()
class StatefulCell extends StatefulWidget {
  var _fairProps;

  StatefulCell(this._fairProps);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<StatefulCell> {
  @override
  void initState() {
    super.initState();

    // dart 源文件可以直接对象映射，JS逻辑部分会转化为JSON
    _louPanDetail = widget._fairProps;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              height: 116,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                      child: Row(
                        children: <Widget>[
                          _buildIcon(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 16, bottom: 8),
                                child: Row(children: <Widget>[
                                  _buildLoupan(),
                                  _buildTitle()
                                ]),
                              ),
                              _buildSubTitle(),
                              _buildPrice()
                            ],
                          )
                        ],
                      )),
                ],
              )),
          Container(height: 0.5, color: Color(0xFFE7EBEE)),
        ],
      ),
      onTap: _onItemTap,
    );
  }

  Widget _buildIcon(){
    return GestureDetector(
        child: Image.network(_loupanIcon(),
            fit: BoxFit.cover, width: 95.0, height: 84.0),
        onTap: _onImageTap);
  }

  Widget _buildLoupan(){
    return Container(
      height: 18,
      alignment: Alignment.center,
      color: Color(0xFF23C993),
      padding:
      EdgeInsets.only(left: 4, right: 4, top: 0),
      child: Text(
          '楼盘',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              color: Color(0xFFFFFFFF),
              wordSpacing: 0)
      ),
    );
  }

  Widget _buildTitle(){
    return Container(
        width: 160,
        padding: EdgeInsets.only(left: 4),
        child: Text('',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0B0F12),
                wordSpacing: 0))
    );
  }

  Widget _buildSubTitle(){
    return Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8),
        child: Text(_generateSubtitle(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 12, color: Color(0xFF0B0F12))));
  }

  Widget _buildPrice(){
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 8),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: _generatePrice(),
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFF0000),
                  wordSpacing: 0)),
          TextSpan(
              text: "万",
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0B0F12),
                  wordSpacing: 0)),
        ]),
      ),
    );
  }
}
