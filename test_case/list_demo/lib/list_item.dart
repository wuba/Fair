import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class ListItem extends StatefulWidget {
  const ListItem({Key? key}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90.5,
        width: Sugar.width(context),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 15, bottom: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: Sugar.netWorkImage(
                                "https://img.iplaysoft.com/wp-content/uploads/2019/free-images/free_stock_photo.jpg!0x0.webp"))),
                    width: 70,
                    height: 70,
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Store/Location Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "123 Address St,City,ST",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.black26),
                        ),
                        Text(
                          "1.7mi",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepPurple),
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.chevron_right_rounded),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                color: Colors.black12,
                height: 0.5,
                width: Sugar.width(context),
              ),
            ),
          ],
        ));
  }
}
