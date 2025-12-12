import 'package:flutter/services.dart';

class QsCancelFreeTrialStream {
  static const EventChannel _channel = EventChannel(
    "qs_ios_purchase/cancel_free_trial",
  );
  static Stream<dynamic> get cancelFreeTrialStream =>
      _channel.receiveBroadcastStream();
}
