import 'dart:ui';

import 'package:best_flutter_ui_templates/hotel_booking/hotel_app_theme.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/hotel_list_data.dart';
import 'package:fair/fair.dart';
import 'package:flutter/widgets.dart';

class HotelListContentProxy extends FairDelegate {
  final Color primaryColor = HotelAppTheme.buildLightTheme().primaryColor;
  final Color backgroundColor = HotelAppTheme.buildLightTheme().backgroundColor;
  final VoidCallback? callBack;
  final HotelListData? hotelData;

  HotelListContentProxy(this.callBack, this.hotelData);

  void onItemTap() {
    callBack!();
  }

  @override
  Map<String, PropertyValue> bindValue() {
    var value = super.bindValue();
    value['primaryColor'] = () => primaryColor;
    value['backgroundColor'] = () => backgroundColor;
    return value;
  }

  @override
  Map<String, Function> bindFunction() {
    var fun = super.bindFunction();
    fun['onItemTap'] = onItemTap;
    fun['perNight'] = (props) => perNight();
    fun['reviews'] = (props) => reviews();
    fun['distance'] = (props) => distance();
    return fun;
  }

  String perNight() => '${hotelData!.perNight}';

  String reviews() => '${hotelData!.reviews} Reviews';

  String distance() => '${hotelData!.dist.toStringAsFixed(1)} km to city';
}
