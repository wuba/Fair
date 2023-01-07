import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class @@PageName@@ extends StatefulWidget {
  const @@PageName@@({Key? key}) : super(key: key);

  @override
  State<@@PageName@@> createState() => _@@PageName@@State();
}

class _@@PageName@@State extends State<@@PageName@@> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer'),
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: CircleAvatar(
                    child: Text('FAIR'),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('电话'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('邮箱'),
            ),
            ListTile(
              leading: Icon(Icons.pin_drop_sharp),
              title: Text('位置'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            ),
          ],
        ),
      ),
    );
  }
}
