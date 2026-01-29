import 'package:qs_ios_purchase/qs_purchase_result.dart';

import 'qs_ios_purchase_platform_interface.dart';

class QsIosPurchase {
  /// Func
  /// 初始化
  static Future<void> initialize({
    required Function(bool isVip) onVipChange,
    required Function(String transactionId) onCancelFreeTrial,
    required Function(String transactionId) onCancelAutoRenew,
  }) {
    return QsIosPurchasePlatform.instance.initialize(
      onVipChange: onVipChange,
      onCancelFreeTrial: onCancelFreeTrial,
      onCancelAutoRenew: onCancelAutoRenew,
    );
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

  /// 校验交易订单
  static Future<QsPurchaseResult?> checkTransactions() async {
    return await QsIosPurchasePlatform.instance.checkTransactions();
  }

  /// 是否有历史交易记录
  static Future<int> historyTransactionCount() async {
    return await QsIosPurchasePlatform.instance.historyTransactionCount();
  }

  /// 取消续订处理失败
  static Future<void> handleCancelAutoRenewFailure({required String id}) {
    return QsIosPurchasePlatform.instance.handleCancelAutoRenewFailure(id: id);
  }

  /// 取消试订处理失败
  static Future<void> handleCancelFreeTrialFailure({required String id}) {
    return QsIosPurchasePlatform.instance.handleCancelFreeTrialFailure(id: id);
  }
}
