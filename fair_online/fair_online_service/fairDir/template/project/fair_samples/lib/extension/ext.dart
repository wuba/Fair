extension MapExt on Map {
  dynamic fuzzyMatching(String src) {
    var result;
    forEach((key, value) {
      //尾包含，比如传入 lib_listview_hotel_listview，map 里 有key是hotel_listview
      if (src.endsWith(key)) {
        result = this[key];
        return;
      }
    });
    return result;
  }
}

extension ListExt on List {
  bool fuzzyMatching(String src) {
    var result = false;
    forEach((element) {
      if (src.endsWith(element)) {
        result = true;
        return;
      }
    });
    return result;
  }
}

