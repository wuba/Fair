import 'dart:convert';

import 'package:flutter/services.dart';
/// 注意：开发中，暂时不可用。。。
/// dart - js通讯
const FairBasicMessageChannel_name = 'com.fair/FairBasicMessageChannel';
BasicMessageChannel<String> _commonChannel;

const channels = <String, FairBasicMessageChannel>{};

class FairBasicMessageChannel {
  final String name;
  Future<String> Function(String message) _handler;

  FairBasicMessageChannel(this.name) {
    if (channels == null) {
      throw StateError('初始化失败，请确实是否调用setupMessageChannel()');
    }
    channels.putIfAbsent(name, () => this);
  }

  ///发送消息到dart并接收js返回的消息
  Future<String> send(String message) async {
    var sendMessageMap = {
      'name': name,
      'args': message,
    };
    var result = await _commonChannel.send(jsonEncode(sendMessageMap));
    return result;
  }

  ///接收js返回的消息,回复指定的结果
  void setMessageHandler(Future<String> Function(String message) handler) {
    _handler = handler;
  }

  Future<String> Function(String message) get messageHandler => _handler;

  static void setupMessageChannel() {
    _init();
    _registerChannel();
  }

  static void _init() {
    _commonChannel ??= BasicMessageChannel(FairBasicMessageChannel_name, StringCodec());
  }

  /*
   * 注册消息回调，接收native端返回的消息，然后对消息进行分发处理
   */
  static void _registerChannel() {
    _commonChannel.setMessageHandler((msg) async {
      var jsMsg = jsonDecode(msg);
      var args = jsMsg['args'];
      var targetChannel = channels.remove('name');
      if (targetChannel == null) {
        throw StateError('目标channel不存在，请检查是否注册');
      }

      var replyFromDart = await targetChannel?.messageHandler?.call(args);
      var resultMap = {
        'name': targetChannel,
        'args': replyFromDart,
      };
      //回复消息到js侧
      return jsonEncode(resultMap);
    });
  }
}

void test() {
  //创建通信管道
  var mFairBasicMessageChannel = FairBasicMessageChannel('com.wuba.fair.js/channel');

  //发送消息并获取js侧结果
  var result = mFairBasicMessageChannel.send('hi 58');

  //接收js侧发送的消息
  mFairBasicMessageChannel.setMessageHandler((message) async {
    //将处理后的结果发送到js侧面
    return 'reply from dart';
  });
}

// class FairMethodChannel {
//   void setMethodCallHandler(
//       Future<dynamic> Function(MethodCall call) handler) {}
//
//   Future<T> invokeMethod<T>(String method, [dynamic arguments]) {
//     return Future.value(null);
//   }
// }
