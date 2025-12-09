import 'package:flutter/services.dart';

class QsVipStream {
  static const EventChannel _channel = EventChannel("qs_ios_purchase/vip");
  static Stream<dynamic> get vipStream => _channel.receiveBroadcastStream();
}
