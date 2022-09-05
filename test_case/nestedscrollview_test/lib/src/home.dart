import 'dart:developer';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  bool headerWhite = false;
  String backIcon =
      'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_white.png';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ///监听滚动位置设置导航栏颜色
      log(_scrollController.offset.toString());
      setState(() {
        headerWhite = _scrollController.offset > 170 ? true : false;
        backIcon = _scrollController.offset > 170
            ? 'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_back.png'
            : 'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_white.png';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sugar.isNestedScrollView(
        // controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 230.0,
              pinned: true,
              floating: true,
              stretch: true,
              snap: false,
              leading: IconButton(
                  icon: Image.network(
                    backIcon,
                    height: 22,
                    width: 22,
                  ),
                  onPressed: (() => {print('点击了返回')})),
              flexibleSpace: FlexibleSpaceBar(
                title: headerWhite
                    ? Text(
                        '我是测试',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: 'PingFangSC-Semibold'),
                      )
                    : Text(''),
                background: Image.network(
                  'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ];
        },
        body: Text('我是内容')
        // ListView.builder(
        //   padding: EdgeInsets.only(top: 0),
        //   itemBuilder: (BuildContext context, int index) {
        //     return GestureDetector(
        //         onTap: (() => {print(index)}),
        //         child: Container(
        //           height: 80,
        //           color: Colors.primaries[index % Colors.primaries.length],
        //           alignment: Alignment.center,
        //           child: Text(
        //             '$index',
        //             style: TextStyle(color: Colors.white, fontSize: 20),
        //           ),
        //         ));
        //   },
        //   itemCount: 20,
        // )
        // return NestedScrollView(
        //     controller: _scrollController,
        //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //     return <Widget>[SliverAppBar(
        //       expandedHeight: 230.0,
        //       pinned: true,
        //       floating: true,
        //       stretch: true,
        //       snap: false,
        //       leading: IconButton(
        //           icon: Image.network(backIcon, height: 22, width: 22,),
        //           onPressed: (){
        //             //TODO: 返回事件处理
        //           }
        //       ),
        //       flexibleSpace:FlexibleSpaceBar(
        //         title: headerWhite ? Text('我是测试', style: TextStyle(
        //             color: Color(0xFF333333),
        //             fontWeight: FontWeight.w700,
        //             fontSize: 17,
        //             fontFamily: 'PingFangSC-Semibold'
        //         ),) : Text(''),
        //         background: Image.network(
        //           'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
        //           fit: BoxFit.fitHeight,
        //         ),
        //       ) ,
        //     )];
        //   },
        //   body: ListView.builder(padding:EdgeInsets.only(top: 0),itemBuilder: (BuildContext context,int index){
        //     return
        //       GestureDetector(
        //         onTap: (){
        //           print(index);
        //         },
        //         child:Container(
        //         height: 70,
        //         color: Colors.primaries[index % Colors.primaries.length],
        //         alignment: Alignment.center,
        //         child: Text(
        //           '$index',
        //           style: TextStyle(color: Colors.white, fontSize: 20),
        //         ),
        //       ));
        //
        //   },itemCount: 20,)
        );
  }
}
