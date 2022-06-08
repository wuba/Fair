
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

class CommonDelegate extends FairDelegate{

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['_pop'] = ()=>Navigator.pop(context);
    return fun;
  }
}