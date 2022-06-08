import 'dart:io';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@FairPatch()
class SignInWithAppleExamplePage extends StatefulWidget {
  final String title;
  SignInWithAppleExamplePage({required Key key, required this.title}) : super(key: key);

  @override
  _SignInWithAppleExamplePageState createState() {
    return _SignInWithAppleExamplePageState();
  }
}

class _SignInWithAppleExamplePageState extends State<SignInWithAppleExamplePage> {
  @FairWell('_signInRequest')
  Future<void> _signInRequest() async {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: SignInWithAppleButton(
              onPressed: () async {
                _signInRequest();
              },
            ),
          ),
        ),
      ),
    );
  }
}