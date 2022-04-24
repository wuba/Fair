
import 'dart:async';
import 'dart:io';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class PackageInfoDelegate extends FairDelegate{
  String _appName = "";
  String _packageName = "";
  String _version = "";
  String _buildNumber = "";

  TextAlign _textAlign = TextAlign.center;

  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
       _appName = packageInfo.appName;
       _packageName = packageInfo.packageName;
       _version = packageInfo.version;
       _buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_appName'] = () => _appName;
    value['_packageName'] = () => _packageName;
    value['_version'] = () => _version;
    value['_buildNumber'] = () => _buildNumber;
    value['_textAlign'] = () => _textAlign;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_getPackageInfo'] = _getPackageInfo;
    fun['_pop'] = ()=>Navigator.pop(context);
    return fun;
  }
}