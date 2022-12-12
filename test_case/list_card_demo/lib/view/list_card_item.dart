import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ListCardItem extends StatefulWidget {
  const ListCardItem({Key key}) : super(key: key);

  @override
  State<ListCardItem> createState() => _ListCardItemState();
}

class _ListCardItemState extends State<ListCardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: Sugar.netWorkImage(
                          "http://c-ssl.duitang.com/uploads/item/202003/26/20200326223552_nayyt.jpeg"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "贝贝",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    )
                  ],
                )),
                Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/images/more.png'),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "换个头像换个心情😊",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ))
                ],
              ),
            ),
            Card(
              child: Image(
                image: Sugar.netWorkImage(
                    "https://img2.baidu.com/it/u=4114138728,2649938841&fm=253&fmt=auto&app=138&f=JPEG"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/like.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "125",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/comment.png'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "66",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.black54),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/share-one.png'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
