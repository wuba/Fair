import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnackBarDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Fair Sample'),
                ));
              },
              child: Text('Click To Show SnackBar'),
            ),
          ),
          Expanded(
            child: FairWidget(
              path: 'assets/bundle/snackbar/lib_snackbar_snackbar_fair.fair.json',
              data: {
                'fairProps': jsonEncode({'content': 'Fair Sample'})
              },
            ),
          )
        ],
      ),
    );
  }
}
