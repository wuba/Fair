
import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class DeviceInfoDelegate extends FairDelegate{
  String _deviceInfo = "";

  TextAlign _textAlign = TextAlign.center;

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
      setState(() {
        _deviceInfo = androidInfo.model;
      });
    } else if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
      setState(() {
        _deviceInfo = iosInfo.model;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['_deviceInfo'] = () => _deviceInfo;
    value['_textAlign'] = () => _textAlign;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_getDeviceInfo'] = _getDeviceInfo;
    fun['_pop'] = ()=>Navigator.pop(context);
    return fun;
  }
}