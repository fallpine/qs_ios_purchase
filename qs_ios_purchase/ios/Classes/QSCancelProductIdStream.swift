//
//  QSVipStream.swift
//  Runner
//
//  Created by ht on 2025/12/9.
//

import Flutter
import UIKit

class QSCancelProductIdStream {
    // MARK: - Func

    /// 获取通道
    static func register(messenger: FlutterBinaryMessenger?) {
        guard let messenger = messenger else { return }

        let channel = FlutterEventChannel(name: "qs_ios_purchase/cancel_product_id", binaryMessenger: messenger)

        let streamHandler = QSCancelProductIdStreamHandler()
        channel.setStreamHandler(streamHandler)
    }

    // MARK: - Property

    static var cancelProductIdStream: FlutterEventSink?
}

class QSCancelProductIdStreamHandler: FlutterViewController, FlutterStreamHandler {
    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        QSCancelProductIdStream.cancelProductIdStream = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        QSCancelProductIdStream.cancelProductIdStream = nil
        return nil
    }
}
