import Flutter
import UIKit

class QSCancelFreeTrialEveryTimeStream {
  // MARK: - Func

  /// 获取通道
  static func register(messenger: FlutterBinaryMessenger?) {
    guard let messenger = messenger else { return }

    let channel = FlutterEventChannel(
      name: "qs_ios_purchase/cancel_free_trial_every_time_stream", binaryMessenger: messenger)

    let streamHandler = QSCancelFreeTrialEveryTimeStreamHandler()
    channel.setStreamHandler(streamHandler)
  }

  // MARK: - Property

  static var cancelFreeTrialEveryTimeStream: FlutterEventSink?
}

class QSCancelFreeTrialEveryTimeStreamHandler: NSObject, FlutterStreamHandler {
  func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    QSCancelFreeTrialEveryTimeStream.cancelFreeTrialEveryTimeStream = events
    return nil
  }

  func onCancel(withArguments _: Any?) -> FlutterError? {
    QSCancelFreeTrialEveryTimeStream.cancelFreeTrialEveryTimeStream = nil
    return nil
  }
}