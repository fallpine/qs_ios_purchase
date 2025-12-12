//
//  QSCancelFreeTrialStream.swift
//  Runner
//
//  Created by ht on 2025/12/9.
//

import Flutter
import UIKit

class QSCancelFreeTrialStream {
    // MARK: - Func

    /// 获取通道
    static func register(messenger: FlutterBinaryMessenger?) {
        guard let messenger = messenger else { return }

        let channel = FlutterEventChannel(name: "qs_ios_purchase/cancel_free_trial", binaryMessenger: messenger)

        let streamHandler = QSCancelFreeTrialStreamHandler()
        channel.setStreamHandler(streamHandler)
    }

    // MARK: - Property

    static var cancelFreeTrialStream: FlutterEventSink?
}

class QSCancelFreeTrialStreamHandler: FlutterViewController, FlutterStreamHandler {
    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        QSCancelFreeTrialStream.cancelFreeTrialStream = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        QSCancelFreeTrialStream.cancelFreeTrialStream = nil
        return nil
    }
}
