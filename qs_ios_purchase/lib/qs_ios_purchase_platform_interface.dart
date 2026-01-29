import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qs_ios_purchase/qs_purchase_result.dart';

import 'qs_ios_purchase_method_channel.dart';

abstract class QsIosPurchasePlatform extends PlatformInterface {
  /// Constructs a QsIosPurchasePlatform.
  QsIosPurchasePlatform() : super(token: _token);

  static final Object _token = Object();

  static QsIosPurchasePlatform _instance = MethodChannelQsIosPurchase();

  /// The default instance of [QsIosPurchasePlatform] to use.
  ///
  /// Defaults to [MethodChannelQsIosPurchase].
  static QsIosPurchasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QsIosPurchasePlatform] when
  /// they register themselves.
  static set instance(QsIosPurchasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Func
  /// 初始化
  Future<void> initialize({
    required Function(bool isVip) onVipChange,
    required Function(String transactionId) onCancelFreeTrial,
    required Function(String transactionId) onCancelAutoRenew,
  }) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// 获取商品
  Future<dynamic> getProducts({required List<String> productIds}) {
    throw UnimplementedError('getProducts() has not been implemented.');
  }

  /// 请求购买商品
  Future<QsPurchaseResult> requestPurchase({required String productId}) {
    throw UnimplementedError('requestPurchase() has not been implemented.');
  }

  /// 恢复购买
  Future<QsPurchaseResult> restorePurchase() {
    throw UnimplementedError('restorePurchase() has not been implemented.');
  }

  /// 校验交易订单
  Future<QsPurchaseResult> checkTransactions() async {
    throw UnimplementedError('checkTransactions() has not been implemented.');
  }

  /// 校验交易订单
  Future<int> historyTransactionCount() async {
    throw UnimplementedError(
      'historyTransactionCount() has not been implemented.',
    );
  }

  /// 取消续订处理失败
  Future<void> handleCancelAutoRenewFailure({required String id}) {
    throw UnimplementedError(
      'handleCancelAutoRenewFailure() has not been implemented.',
    );
  }

  /// 取消试订处理失败
  Future<void> handleCancelFreeTrialFailure({required String id}) {
    throw UnimplementedError(
      'handleCancelFreeTrialFailure() has not been implemented.',
    );
  }
}
