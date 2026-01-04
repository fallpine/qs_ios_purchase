import Flutter
import UIKit

class QSCancelAutoRenewStream {
    // MARK: - Func

    /// 获取通道
    static func register(messenger: FlutterBinaryMessenger?) {
        guard let messenger = messenger else { return }

        let channel = FlutterEventChannel(name: "qs_ios_purchase/cancel_auto_renew", binaryMessenger: messenger)

        let streamHandler = QSCancelAutoRenewStreamHandler()
        channel.setStreamHandler(streamHandler)
    }

    // MARK: - Property

    static var cancelAutoRenewStream: FlutterEventSink?
}

class QSCancelAutoRenewStreamHandler: FlutterViewController, FlutterStreamHandler {
    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        QSCancelAutoRenewStream.cancelAutoRenewStream = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        QSCancelAutoRenewStream.cancelAutoRenewStream = nil
        return nil
    }
}
