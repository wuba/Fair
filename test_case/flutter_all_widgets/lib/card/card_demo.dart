import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class CardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterCardPage(),
          FairWidget(
            path: 'assets/bundle/card/lib_card_card_widget.fair.json',
          )
        ],
      ),
    );
  }

}

class FlutterCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text('Buy tickets')),
                SizedBox(width: 8,),
                TextButton(onPressed: () {}, child: Text('List')),
                SizedBox(width: 8,)

              ],
            )
          ],
        ),
      ),
    );
  }

}