import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairCardPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _FairCardPageState();

}

class _FairCardPageState extends State<FairCardPage>{

  void onTap(){

  }

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
                TextButton(onPressed: onTap, child: Text('Buy tickets')),
                SizedBox(width: 8,),
                TextButton(onPressed: onTap, child: Text('List')),
                SizedBox(width: 8,)
              ],
            )
          ],
        ),
      ),
    );
  }

}