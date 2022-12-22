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
    return Container(
      child: NestedScrollView(
        headerSliverBuilder: Sugar.isNestedScrollViewHeaderSliversBuilder(
            context: context,
            innerBoxIsScrolled: false,
            headerSliverBuilder: <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 200,
                snap: false,
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Image.network(
                    'https://pic3.58cdn.com.cn/nowater/frs/n_v30298bfe0255a4f42a38399e559dadd1e.png',
                    height: 22,
                    width: 22,
                  ),
                  onPressed: (() => {}),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 10, 2),
                        child: Text(
                          '欢迎来到妮妮朋友圈',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  //标题居中
                  centerTitle: true,
                  background: Image.network(
                    'https://img1.baidu.com/it/u=1500716295,3279382336&fm=253&fmt=auto&app=120&f=JPEG',
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ]),
        body: Container(
          color: Colors.white,
          child: Sugar.listBuilder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return FairWidget(
                    name: 'item',
                    path:
                        'assets/fair/lib_page_list_card_list_card_item.fair.json',
                    data: const {'': ''});
              }),
        ),
      ),
    );
  }
}
