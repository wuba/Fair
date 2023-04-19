import 'package:fair/fair.dart';
import 'package:fair_extension/toast/fair_toast_plugin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

@FairPatch()
class ToastPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast Example'),
      ),
      body: Column(
        children: [
          Image.network(
            'https://img.58cdn.com.cn/logo/58/252_84/logo-o.png',
            width: 500,
            height: 250,
          ),
          const Text(
            '点击弹出Toast',
            style: TextStyle(fontSize: 15),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: shortToast,
            child: const Text(
              'Short Toast',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: longToast,
            child: const Text(
              'Long Toast',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: largeFontSize,
            child: const Text(
              '字体变大',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: topGravity,
            child: const Text(
              '设置ToastGravity.TOP',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: changeColor,
            child: const Text(
              '改变字体和背景颜色',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void shortToast() {
    FairToast.show(
      msg: '这是一个 `Short Toast`',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void longToast() {
    FairToast.show(
      msg: '这是一个 `Long Toast`',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void largeFontSize(){
    FairToast.show(
      msg: '字体变大',
      fontSize: 30.0,
    );
  }

  void topGravity(){
    FairToast.show(
      msg: 'ToastGravity.TOP',
      gravity: ToastGravity.TOP,
    );
  }

  void changeColor(){
    FairToast.show(
      msg: '改变字体和背景颜色',
      backgroundColor: Color(0xff00f0ff),
      textColor: Color(0xffffe80c),
    );
  }

}