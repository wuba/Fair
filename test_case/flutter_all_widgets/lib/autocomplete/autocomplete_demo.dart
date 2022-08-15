
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class AutocompleteDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autocomplete'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlutterAutocompletePage(),
          FairWidget(
            path: 'assets/bundle/autocomplete/lib_autocomplete_autocomplete_widget.fair.json',
          )
        ],
      ),
    );
  }

}


class FlutterAutocompletePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_FlutterAutocompletePage();


}

class _FlutterAutocompletePage extends State<FlutterAutocompletePage>{

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
        optionsBuilder:(TextEditingValue textEditingValue){
          if(textEditingValue.text == ''){
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },
      onSelected: (String selection){
          debugPrint('You just selected $selection');
      },
    );
  }

}