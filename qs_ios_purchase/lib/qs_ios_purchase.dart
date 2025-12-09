import 'package:qs_ios_purchase/qs_purchase_result.dart';

import 'qs_ios_purchase_platform_interface.dart';

class QsIosPurchase {
  /// 初始化
  static Future<void> initialize({required Function(bool isVip) onVipChange}) {
    return QsIosPurchasePlatform.instance.initialize(onVipChange: onVipChange);
  }

  /// 获取商品
  static Future<dynamic> getProducts({required List<String> productIds}) {
    return QsIosPurchasePlatform.instance.getProducts(productIds: productIds);
  }

  /// 请求购买商品
  static Future<QsPurchaseResult> requestPurchase({required String productId}) {
    return QsIosPurchasePlatform.instance.requestPurchase(productId: productId);
  }

  /// 恢复购买
  static Future<QsPurchaseResult> restorePurchase() {
    return QsIosPurchasePlatform.instance.restorePurchase();
  }
}
