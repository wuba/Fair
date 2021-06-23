import 'package:dio/dio.dart';
import 'package:fair/fair.dart';

//todo 网络请求
class FairNet extends IFairPlugin {
  FairNet() {
    registerMethod('request', request);
  }

  @override
  dynamic invoke(dynamic par) => Function.apply(c[getMethodName(par)], ['null']);

  dynamic request(par) async {
    // var method=p
    var dio = Dio();
    var response = await dio.get<String>('http://www.google.com');

    return Future.value(response.toString());
  }
}
