import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

/**
 * Autocomplete:自动填充
 */
@FairPatch()
class FairAutocompletePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FairAutocompletePageState();
}

class _FairAutocompletePageState extends State {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  Iterable<String> _builderAutoComplete( TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    }
    return _kOptions.where((String option) {
      return option.contains(textEditingValue.text.toLowerCase());
    });
  }

  void _onSelected(String selection) {
      debugPrint('You just selected $selection');
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: _builderAutoComplete,
      onSelected: _onSelected,
    );
  }
}
