import '../../fair_common.dart';

void requestData() {
  var listData = <HotelModel>[];
  FairNet().requestData({
    'pageName': '#FairKey#',
    'method': 'GET',
    'url':
    'https://wos2.58cdn.com.cn/DeFazYxWvDti/frsupload/3be6c61070d3b48c8165af5d18464c0e_hotel_list_data.json',
    'data': {'page': 1},
    'success': (resp) {
      if (resp == null) {
        return;
      }
      var data = resp['data'];
      data.forEach((item) {
        var dataItem = HotelModel();
        try {
          dataItem.imagePath = item.imagePath;
          dataItem.titleTxt = item.titleTxt;
          dataItem.subTxt = item.subTxt;
          dataItem.dist = item.dist + ' km';
          dataItem.reviews = item.reviews + ' reviews';
          dataItem.perNight = item.perNight + '';
        } catch (e) {
          dataItem.imagePath = item['imagePath'];
          dataItem.titleTxt = item['titleTxt'];
          dataItem.subTxt = item['subTxt'];
          dataItem.dist = '${item['dist']} km';
          dataItem.reviews = '${item['reviews']} reviews';
          dataItem.perNight = '${item['perNight']}';
        }
        listData.add(dataItem);
      });
    }
  });
}

class HotelModel extends Object {
  String imagePath = '';
  String titleTxt = '';
  String subTxt = '';
  String dist = '';
  String reviews = '';
  String perNight = '';
}











