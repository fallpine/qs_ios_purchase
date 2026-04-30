import 'package:flutter/services.dart';

class QsCancelFreeTrialEveryTimeStream {
  static const EventChannel _channel = EventChannel(
    "qs_ios_purchase/cancel_free_trial_every_time_stream",
  );
  static Stream<void> get cancelFreeTrialEveryTimeStream =>
      _channel.receiveBroadcastStream();
}
