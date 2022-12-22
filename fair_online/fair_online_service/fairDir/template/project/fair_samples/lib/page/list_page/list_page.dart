import 'package:fair/fair.dart';
import '../../fair_common.dart';
import 'package:flutter/material.dart';

@FairPreviewPage()
@FairPatch()
class ListDemoPage extends StatefulWidget {
  const ListDemoPage({Key? key}) : super(key: key);

  @override
  State<ListDemoPage> createState() => _ListDemoPageState();
}

class _ListDemoPageState extends State<ListDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size(Sugar.width(context), 44),
            child: const Material(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.settings_input_component),
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
            ),
          )),
      body: Container(
        color: Colors.white,
        child: Sugar.listBuilder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return FairWidget(
                  name: 'item',
                  path:
                      'assets/fair/lib_page_list_page_list_item.fair.json',
                  data: const {'': ''});
            }),
      ),
    );
  }
}
