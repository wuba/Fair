import 'dart:convert';

import 'package:fair/src/extension.dart';
import 'package:flutter/material.dart';

class StackTraceDetailPage extends StatelessWidget {
  final String stackTrace;
  final String? name;
  final Map? errorJson;
  final dynamic error;
  final List<int>? highlightLines;

  StackTraceDetailPage(
      {required this.stackTrace, this.name, this.errorJson, this.error,this.highlightLines});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackTrace'),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _stackTraceHeader(),
            _stackTraceDetails(),
          ],
        ),
      ),
    );
  }

  Widget _stackTraceHeader() => RichText(
        text: TextSpan(
          text: '══╡ EXCEPTION CAUGHT BY FAIR RUNTIME ╞══\n',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            ..._getErrorTagNode(),
            TextSpan(
              text: '\n\nRuntime Error:\n',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: '$error',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  List<TextSpan> _getErrorTagNode() {
    if (errorJson == null) return [];

    return [
      TextSpan(
        text: '\nError Tag:',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      TextSpan(
          text: name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            background: Paint()..color = Colors.redAccent,
          )),
      TextSpan(
        text: ', while parsing:\n',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      _buildFormattedJsonSpan()
    ];
  }

  TextSpan _buildFormattedJsonSpan() {
    var encoder = JsonEncoder.withIndent('  ');
    final formattedJson = encoder.convert(errorJson);
    return TextSpan(
      text: formattedJson,
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  final String PKG_PREFIX = 'package:';
  final String DART_SUFFIX = '.dart';

  RichText _stackTraceDetails() {
    final splitter = LineSplitter();
    final stackTraceLines = splitter.convert(stackTrace);

    final defaultTextStyle =
        TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w500);


    final spans = stackTraceLines.mapEach((index, e) {
      if (highlightLines?.isNotEmpty == true) {
        //lineNumber => index+1
        if (highlightLines?.contains(index + 1) == true) {
          //highlight
          return TextSpan(
              text: '$e\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                background: Paint()..color = Colors.redAccent,
              ));
        } else {
          return TextSpan(text: '$e\n');
        }
      } else {
        if (e.contains(PKG_PREFIX)) {
          final span1 = e.substring(0, e.indexOf(PKG_PREFIX));
          final highlightSpan = e.substring(
              e.indexOf(PKG_PREFIX), e.lastIndexOf(DART_SUFFIX) + 5);
          final span2 = e.substring(e.lastIndexOf(DART_SUFFIX) + 5);

          return TextSpan(text: span1, style: defaultTextStyle, children: [
            TextSpan(
                text: highlightSpan,
                style: TextStyle(color: Color(0xFF3978C4))),
            TextSpan(text: span2, style: defaultTextStyle),
            TextSpan(text: '\n', style: defaultTextStyle),
          ]);
        } else {
          return TextSpan(text: '$e\n');
        }
      }
    }).toList();

    return RichText(
        text: TextSpan(
            text: '\nWhen the exception was thrown, this was the stack:\n\n',
            children: spans,
            style: defaultTextStyle));
  }
}
