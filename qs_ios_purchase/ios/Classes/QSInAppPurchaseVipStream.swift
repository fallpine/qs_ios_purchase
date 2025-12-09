//
//  QSInAppPurchaseVipStream.swift
//  Runner
//
//  Created by ht on 2025/12/9.
//

import Flutter
import UIKit

class QSInAppPurchaseVipStream {
    // MARK: - Func

    /// 获取通道
    static func register(messenger: FlutterBinaryMessenger?) {
        guard let messenger = messenger else { return }

        let channel = FlutterEventChannel(name: "qs_ios_purchase/vip", binaryMessenger: messenger)

        let streamHandler = QSVipStreamHandler()
        channel.setStreamHandler(streamHandler)
    }

    // MARK: - Property

    static var vipStream: FlutterEventSink?
}

class QSVipStreamHandler: FlutterViewController, FlutterStreamHandler {
    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        QSInAppPurchaseVipStream.vipStream = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        QSInAppPurchaseVipStream.vipStream = nil
        return nil
    }
}
