import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class FairWidgetPage extends StatelessWidget {
  final String fairPath;
  final String fairName;

  final Map? fairArguments;

  const FairWidgetPage({
    Key? key,
    this.fairArguments,
    required this.fairPath,
    required this.fairName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: fairName,
      path: fairPath,
      data: {
        'fairProps': jsonEncode(fairArguments??{}),
      },
    );
  }
}
