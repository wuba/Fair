import 'package:fair/fair.dart';
import 'package:fair_provider/fair_provider.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    FairApp(
      generated: FairAppModule(),
      child: const MyApp(),
      dynamicWidgetBuilder: (proxyMirror, page, bound, {bundle}) =>
          ProviderDynamicWidgetBuilder(proxyMirror, page, bound,
              bundle: bundle),
    ),
    plugins: {'FairProvider': FairProvider()},
    jsPlugins: {'fair_provider': 'packages/fair_provider/assets/plugin/fair_provider_plugin.js'}
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            // MyHomePage(title: "dasdasdsa",),
            Scaffold(
                appBar: AppBar(
                  title: const Text('Flutter Lab'),
                ),
                body: Builder(
                  builder: (context) => ListView(
                    children: [
                      addItem("CounterProvider Fair", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FairWidget(
                                name: "CounterProvider",
                                path:
                                    "assets/fair/lib_ui_counter_page_provider.fair.json",
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            test(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget test() {
    return Container();
  }
}
