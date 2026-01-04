import 'package:flutter/services.dart';

class QsCancelAutoRenewStream {
  static const EventChannel _channel = EventChannel(
    "qs_ios_purchase/cancel_auto_renew",
  );
  static Stream<dynamic> get cancelAutoRenewStream =>
      _channel.receiveBroadcastStream();
}
