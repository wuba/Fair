import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class @@PageName@@Item extends StatefulWidget {
  dynamic fairProps;

  @@PageName@@Item({Key? key, required this.fairProps}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _@@PageName@@ItemState();
}

class _@@PageName@@ItemState extends State<@@PageName@@Item> {
  @FairProps()
  var fairProps;

  String _getImagePath() {
    return fairProps['imageUrl'];
  }

  String _getTitle() {
    return fairProps['title'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(_getImagePath(), fit: BoxFit.cover),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  // color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_getTitle(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('SubTitle-SubTitle'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
