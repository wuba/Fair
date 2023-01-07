const FLUTTER_EXAMPLE_CODE = r'''
import 'package:flutter/material.dart';

class test_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Test CompileDDC');
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
          children: [
            const Text('Compile DDC'),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
}

''';

const JAVASCRIPT_EXAMPLE_CODE = """
replaceJavaScript = function (value) {
    // Remove the old node.
    var oldNode = document.getElementById('compiledJsScript');
    if (oldNode && oldNode.parentNode) {
        oldNode.parentNode.removeChild(oldNode);
    }

    // Create a new node.
    var scriptNode = document.createElement('script');
    scriptNode.setAttribute('id', 'compiledJsScript');
    scriptNode.async = false;
    scriptNode.text = value;
    document.head.appendChild(scriptNode);
};

/**
 * Adds a script tag, with url as "src" and id as "id", unless a script tag with
 * that id already exists.
 *
 * Executes onload after the script has loaded, if the script did not already
 * exist, and executes onload immediately otherwise.
 */
addScript = function (id, url, onload) {
    let existingScript = document.getElementById(id);
    if (existingScript && existingScript.parentNode) {
        if (onload !== undefined) {
            onload();
        }
        return;
    }

    let scriptNode = document.createElement('script');
    scriptNode.setAttribute('id', id);
    scriptNode.async = false;
    if (onload !== undefined) {
        scriptNode.onload = onload;
    }
    scriptNode.setAttribute('src', url);
    document.head.appendChild(scriptNode);
}

/**
 * Executes userJs, a user script, after first loading RequireJS.
 */
executeWithRequireJs = function (userJs) {
    addScript('require', 'require.js', function () {
        // User script must be added after RequireJS loads.
        replaceJavaScript(userJs);
    });
}

/**
 * Handles any incoming messages.
 *
 * In particular, understands the following commands on e: 'setCss', 'setHtml',
 * and 'execute'.
 */
messageHandler = function (e) {
    var obj = e.data;
    var command = obj.command;
    var body = document.body;

    if (command === 'setCss') {
        document.getElementById('styleId').innerHTML = obj.css;
    } else if (command === 'setHtml') {
        body.innerHTML = obj.html;
    } else if (command === 'execute') {
        // Replace HTML, CSS, possible Firebase JS, RequireJS, and app.
        body.innerHTML = obj.html;
        document.getElementById('styleId').innerHTML = obj.css;
        if (obj.addRequireJs) {
            executeWithRequireJs(obj.js);
        } else {
            replaceJavaScript(obj.js);
        }
    }
};

window.addEventListener('load', function () {
    window.addEventListener('message', messageHandler, false);
    parent.postMessage({ 'sender': 'frame', 'type': 'ready' }, '*');
});

""";

const JSON_EXAMPLE_CODE = """
{
  "className": "Scaffold",
  "na": {
    "appBar": {
      "className": "AppBar",
      "na": {
        "title": {
          "className": "Text",
          "pa": [
            "^(_title)"
          ]
        }
      }
    },
    "body": {
      "className": "Center",
      "na": {
        "child": {
          "className": "Column",
          "na": {
            "mainAxisAlignment": "#(MainAxisAlignment.center)",
            "children": [
              {
                "className": "Text",
                "pa": [
                  "You have pushed the button this many timesssss:"
                ]
              },
              {
                "className": "Text",
                "pa": [
                  "1"
                ],
                "na": {
                  "style": {
                    "className": "TextStyle",
                    "na": {
                      "fontSize": 40,
                      "color": {
                        "className": "Color",
                        "pa": [
                          "0xffeb4237"
                        ]
                      },
                      "wordSpacing": 0
                    }
                  }
                }
              }
            ]
          }
        }
      }
    },
    "floatingActionButton": {
      "className": "FloatingActionButton",
      "na": {
        "onPressed": "@(_incrementCounter)",
        "tooltip": "Increment",
        "child": {
          "className": "Icon",
          "pa": [
            "#(Icons.add)"
          ]
        }
      }
    }
  },
  "methodMap": {}
}
""";