import 'package:flutter/services.dart';

class QsCancelProductIdStream {
  static const EventChannel _channel = EventChannel(
    "qs_ios_purchase/cancel_product_id",
  );
  static Stream<dynamic> get cancelProductIdStream =>
      _channel.receiveBroadcastStream();
}
