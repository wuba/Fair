import 'package:fair/fair.dart';
import 'package:fair_extension/log/log.dart';
import 'package:flutter/material.dart';

@FairPatch()
class LogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogPageState();
}

class LogPageState extends State<LogPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Example'),
      ),
      body: Column(
        children: [
          Image.network(
            'https://img.58cdn.com.cn/logo/58/252_84/logo-o.png',
            width: 500,
            height: 250,
          ),
          Text(
            '点击打印日志: count value: $_count',
            style: const TextStyle(fontSize: 15),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          MaterialButton(
            color: Colors.grey,
            onPressed: showLog,
            child: const Text(
              'Click Show Log',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: plusCount,
        child: const Icon(Icons.add),
      ),
    );
  }

  void plusCount() {
    _count++;
    setState(() {});
    FairLog.log('点击 plusCount >> Count Value:: $_count');
  }

  void showLog() {
    FairLog.log('点击展示 Count Value:: $_count');
  }
}
