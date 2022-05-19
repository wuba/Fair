import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class SignInWithApplePage extends StatefulWidget {
  Map<String, dynamic> params;
  SignInWithApplePage({required Key key,required this.params}) : super(key: key);

  @override
  _SignInWithApplePageState createState() {
    return _SignInWithApplePageState();
  }
}

class _SignInWithApplePageState extends State<SignInWithApplePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FairWidget(
      name: "sign_in_with_app",
      path: "assets/bundle/lib_sign_in_with_app_sign_in_with_apple_widget.fair.json",
      data: {
        'title': "Sign In With Apple Page"
      },
    );
  }
}