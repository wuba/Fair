import 'package:example/entity/top_model.dart';
import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    FairApp(
      child: FairChangeNotifierProvider<TopModel>(
        initialJson: '''
{
    "intField":99
}        
        ''',
        child: const MyApp(),
      ),
    ),
    adapters: [FairProviderAdapter()],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Lab'),
            ),
            body: Builder(
              builder: (context) => ListView(
                children: [
                  addItem("计数器示例", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FairWidget(
                            name: "lib_ui_counter_page",
                            path: "assets/fair/lib_ui_counter_page.fair.json",
                          ),
                        ));
                  }),
                  addItem("基本使用示例", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FairWidget(
                            name: "lib_ui_example_page",
                            path: "assets/fair/lib_ui_example_page.fair.json",
                          ),
                        ));
                  }),
                  addItem("跨页面共享状态", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FairWidget(
                            name: "lib_ui_example_page2",
                            path: "assets/fair/lib_ui_example_page2.fair.json",
                          ),
                        ));
                  }),
                ],
              ),
            )));
  }
}

Widget addItem(String itemName, dynamic onPress) {
  return GestureDetector(
      onTap: onPress,
      child: Container(
          alignment: Alignment.centerLeft,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 0.5))),
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            itemName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
          )));
}
