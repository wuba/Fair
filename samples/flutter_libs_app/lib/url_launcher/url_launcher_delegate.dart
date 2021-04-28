
import 'dart:async';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common_delegate.dart';

class UrlLauncherDelegate extends CommonDelegate{
  String _deviceInfo = "";

  TextAlign _textAlign = TextAlign.center;

  TextEditingController _editingController = TextEditingController(
    text: "http://www.58.com"
  );

  Future<void> _launchByInput() async {
    String url = _editingController.value.text;
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future<void> _launch() async {
    String url = "http://www.baidu.com";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future<void> _email() async {
    String url = "mailto:smith@example.org?subject=News&body=New%20plugin";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future<void> _tel() async {
    String url = "tel:+8617600000019";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future<void> _sms() async {
    String url = "sms:17600000019";
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_deviceInfo'] = () => _deviceInfo;
    value['_textAlign'] = () => _textAlign;
    value['_editingController'] = ()=> ValueNotifier(
      _editingController
    );
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_launch'] = _launch;
    fun['_launchByInput'] = _launchByInput;
    fun['_email'] = _email;
    fun['_tel'] = _tel;
    fun['_sms'] = _sms;
    return fun;
  }
}