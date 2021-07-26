import 'package:fair_example/src/page/logic_home_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('58 Fair'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addItem('纯布局动态化', () {
              Navigator.pushNamed(context, 'sample_layout_home_page');
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
            addItem('带逻辑动态化', () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => LogicHomePage(),
              ));
            }),
            Container(height: 0.5, color: Color(0xFFE7EBEE)),
          ],
        ));
  }

  Widget addItem(String itemName, dynamic onPress) {
    return GestureDetector(
      child: Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          height: 100,
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            itemName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
          )),
      onTap: onPress,
    );
  }
}
