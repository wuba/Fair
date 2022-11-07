import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fair/fair.dart';

class ActiveItemBuilderDelegate extends FairDelegate {
  final List<Map<String, dynamic>> data;

  ActiveItemBuilderDelegate(this.data);

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun.addAll({
      '_activeItemBuilder': _activeItemBuilder,
    });
    return fun;
  }

  Widget _activeItemBuilder(context, index) {
    return InkWell(
      onTap: () => _clickCardAction(index),
      child: Container(
        height: 140,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          // clipBehavior: Clip.hardEdge,
          // color: Colors.amber,
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(data[index]['imageUrl'],
                            fit: BoxFit.cover),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    // color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data[index]['title'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('SubTitle-SubTitle'),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: data[index]['isSelected'] == true
                    ? Icon(
                        Icons.radio_button_on_outlined,
                        color: Color(0xFF1565C0),
                      )
                    : Icon(
                        Icons.radio_button_off,
                        color: Color(0xFF1565C0),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _clickCardAction(int index) {
    setState(() {
      data[index]['isSelected'] = !data[index]['isSelected'];
    });
  }
}
