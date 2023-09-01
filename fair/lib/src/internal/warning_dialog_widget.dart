import 'package:flutter/material.dart';

class DialogWidget extends Dialog {
  final String? name ; //错误标题
  final String? url ; //错误链路
  final String? solution ; //是否须要"取消"按钮
  final dynamic error ; //错误
  void Function()? cancelFun; //取消
  void Function()? viewStackTrace; //查看堆栈
  final bool? stackTraceVisible;//堆栈按钮是否可见


  DialogWidget({
    Key? key,
    this.name,
    this.url,
    this.solution,
    this.error,
    this.cancelFun,
    this.viewStackTrace,
    this.stackTraceVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: Color(0xfff2f2f2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                     child: Text( 'Failure', style: TextStyle(color: Color(0xff000000), fontSize: 25.0)),
                    ),
                  ),
                  Container(
                    color: Color(0xffffffff),
                    height: 1.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
                    constraints: BoxConstraints(minHeight: 100),
                    child: Center(
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                              visible: name != null,
                              child: Text(
                                'Tag: $name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffff0000),
                                  fontSize: 20.0,
                                ),
                              )),
                          SizedBox(height: 10),
                          Text(
                            'Bundle: $url',
                             style:  TextStyle(
                                color: Color(0xff000000),
                                fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                             'Error: $error',
                            style:  TextStyle(
                               color: Color(0xff000000),
                               fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                           'Solution: $solution',
                            style:  TextStyle(
                               color: Color(0xff000000),
                               fontWeight: FontWeight.bold,
                               fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xffeeeeee),
                    height: 1.0,
                  ),
                  this._buildBottomButtonGroup()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    widgets.add(_buildBottomCancelButton());
    widgets.add(_buildBottomOnline());
    widgets.add(_buildBottomStackTraceButton());

    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widgets,
    );
  }

  Widget _buildBottomOnline() {
    return Container(
      color: Color(0xffeeeeee),
      height: 38,
      width: 1,
    );
  }

  Widget _buildBottomCancelButton() {
    return Flexible(
      fit: FlexFit.loose,
      child:InkWell(
        onTap: this.cancelFun,
        child: Text('Cancel', style: TextStyle(color: Color(0xff666666))),
      ),
    );
  }

  Widget _buildBottomStackTraceButton() {
    if (stackTraceVisible == null || !stackTraceVisible!) {
      return Container();
    }
    return Flexible(
      fit: FlexFit.loose,
      child: InkWell(
        onTap: viewStackTrace,
        child: Text('StackTrace', style: TextStyle(color: Color(0xFF6888DE))),
      ),
    );
  }
}