import Flutter
import QSInAppPurchase
import StoreKit
import UIKit

public class QsIosPurchasePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qs_ios_purchase", binaryMessenger: registrar.messenger())

    // 注册流
    QSVipStream.register(messenger: registrar.messenger())
    QSCancelFreeTrialStream.register(messenger: registrar.messenger())
    QSCancelProductIdStream.register(messenger: registrar.messenger())

    let instance = QsIosPurchasePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    case "initialize":
      initialize()

    case "getProducts":
      let arguments = call.arguments as? [String: Any]
      if let productIds = arguments?["productIds"] as? [String] {
        getProducts(productIds: productIds, onSuccess: { products in
          result(products)
        }) { error in
          result(error)
        }
      }

    case "requestPurchase":
      let arguments = call.arguments as? [String: Any]
      if let productId = arguments?["productId"] as? String {
        requestPurchase(productId: productId, onCompletion: { dict in
          result(dict)
        })
      }

    case "restorePurchase":
      restorePurchase { dict in
        result(dict)
      }

    case "checkTransactions":
      checkTransactions { dict in
        result(dict)
      }

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  // MARK: - Func

  /// 初始化
  private func initialize() {
    Task {
      await MainActor.run {
        QSPurchase.shared.vipAction = { isVip in
          QSVipStream.vipStream?(isVip)
          QSCancelProductIdStream.cancelProductIdStream?(QSPurchase.shared.cancelProductId)
        }

        QSPurchase.shared.cancelFreeTrialAction = {
          QSCancelFreeTrialStream.cancelFreeTrialStream?(true)
        }
      }
    }
  }

  /// 获取商品
  private func getProducts(productIds: [String],
                           onSuccess: @escaping ([[String: Any]]) -> Void,
                           onFailure: @escaping (String) -> Void)
  {
    Task {
      await QSPurchase.shared.getProducts(productIds: productIds, onSuccess: { products in
        var dictArr = [[String: Any]]()
        for product in products {
          let dict = [
            "id": product.id,
            "productType": getProductTypeValue(type: product.type),
            "currencyPrice": product.currencyPrice,
            "discountCurrencyPrice": product.discountCurrencyPrice,
            "discountRate": product.discountRate,
            "trialPeriodValue": product.trialPeriodValue,
            "trialPeriodUnit": getPeriodUnitValue(unit: product.trialPeriodUnit) ?? "",
            "subscriptionPeriodValue": product.subscriptionPeriodValue,
            "subscriptionPeriodUnit": getPeriodUnitValue(unit: product.subscriptionPeriodUnit) ?? "",
            "languageCode": product.priceFormatStyle.locale.languageCode,
            "regionCode": product.priceFormatStyle.locale.regionCode
          ]
          dictArr.append(dict)
        }
        onSuccess(dictArr)
      }) { error in
        onFailure(error)
      }
    }
  }

  /// 购买产品
  private func requestPurchase(productId: String,
                               onCompletion: @escaping (([String: Any]) -> Void))
  {
    Task {
      if let product = await QSPurchase.shared.getProduct(by: productId) {
        await QSPurchase.shared.requestPurchase(product: product) { purchaseId, subscriptionDate in
          let dict = [
            "status": "success",
            "originalPurchaseId": purchaseId,
            "originalSubscriptionDate": subscriptionDate,
          ]
          onCompletion(dict)
        } onFailure: { error in
          let dict = [
            "status": "error",
            "errorMessage": error,
          ]
          onCompletion(dict)
        } onCancel: {
          let dict = [
            "status": "cancel",
          ]
          onCompletion(dict)
        }
      } else {
        let dict = [
          "status": "error",
          "errorMessage": "没有对应的商品",
        ]
        onCompletion(dict)
      }
    }
  }

  /// 恢复购买
  private func restorePurchase(onCompletion: @escaping ([String: Any]) -> Void) {
    Task {
      await QSPurchase.shared.restorePurchase {
        let dict = [
          "status": "success",
        ]
        onCompletion(dict)
      } onFailure: { error in
        let dict = [
          "status": "error",
          "errorMessage": error,
        ]
        onCompletion(dict)
      }
    }
  }

  /// 校验交易订单
  public func checkTransactions(onCompletion: @escaping ([String: Any]) -> Void) {
    Task {
      await QSPurchase.shared.checkTransactions(onSuccess: {
        let dict = [
          "status": "success",
        ]
        onCompletion(dict)
      }, onFailure: {
        let dict = [
          "status": "error",
          "errorMessage": "没有有效的商品",
        ]
        onCompletion(dict)
      })
    }
  }

  /// 获取商品类型名
  private func getProductTypeValue(type: Product.ProductType) -> String {
    switch type {
    case .consumable:
      return "consumable"
    case .nonConsumable:
      return "nonConsumable"
    case .nonRenewable:
      return "nonRenewable"
    case .autoRenewable:
      return "autoRenewable"
    default:
      return ""
    }
  }

  /// 获取周期单位名
  private func getPeriodUnitValue(unit: Product.SubscriptionPeriod.Unit?) -> String? {
    if let unit = unit {
      switch unit {
      case .day:
        return "day"
      case .week:
        return "week"
      case .month:
        return "month"
      case .year:
        return "year"
      @unknown default:
        return nil
      }
    }
    return nil
  }
}
