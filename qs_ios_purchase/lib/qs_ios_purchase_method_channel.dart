import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qs_ios_purchase/qs_cancel_free_trial_stream.dart';
import 'package:qs_ios_purchase/qs_product_detail.dart';
import 'package:qs_ios_purchase/qs_purchase_result.dart';
import 'package:qs_ios_purchase/qs_vip_stream.dart';

import 'qs_ios_purchase_platform_interface.dart';

/// An implementation of [QsIosPurchasePlatform] that uses method channels.
class MethodChannelQsIosPurchase extends QsIosPurchasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qs_ios_purchase');

  /// 初始化
  @override
  Future<void> initialize({
    required Function(bool isVip) onVipChange,
    required VoidCallback onCancelFreeTrialChange,
  }) async {
    QsVipStream.vipStream.listen((event) {
      if (event is bool) {
        onVipChange(event);
      }
    });

    QsCancelFreeTrialStream.cancelFreeTrialStream.listen((event) {
      if (event is bool) {
        onCancelFreeTrialChange();
      }
    });

    await _invokeNativeMethod("initialize");
  }

  /// 获取商品
  @override
  Future<dynamic> getProducts({required List<String> productIds}) async {
    var result = await _invokeNativeMethod("getProducts", {
      "productIds": productIds,
    });
    if (result != null) {
      if (result is List<dynamic>) {
        final List<QsProductDetail> productList = result
            .map(
              (e) => QsProductDetail.fromJson(
                _convertObjectMapToMapStringDynamic(e as Map<Object?, Object?>),
              ),
            )
            .toList();

        return productList;
      } else if (result is String) {
        return result;
      }
    }

    return null;
  }

  /// 请求购买商品
  @override
  Future<QsPurchaseResult> requestPurchase({required String productId}) async {
    var result = await _invokeNativeMethod("requestPurchase", {
      "productId": productId,
    });
    if (result != null) {
      if (result is Map<Object?, Object?>) {
        final QsPurchaseResult purchaseResult = QsPurchaseResult.fromJson(
          _convertObjectMapToMapStringDynamic(result),
        );
        return purchaseResult;
      }
    }

    return QsPurchaseResult(
      status: QsPurchaseStatus.error,
      errorMessage: "未知错误",
      originalPurchaseId: null,
      originalSubscriptionDate: null,
    );
  }

  /// 恢复购买
  @override
  Future<QsPurchaseResult> restorePurchase() async {
    var result = await _invokeNativeMethod("restorePurchase");
    if (result != null) {
      if (result is Map<Object?, Object?>) {
        final QsPurchaseResult purchaseResult = QsPurchaseResult.fromJson(
          _convertObjectMapToMapStringDynamic(result),
        );
        return purchaseResult;
      }
    }

    return QsPurchaseResult(
      status: QsPurchaseStatus.error,
      errorMessage: "未知错误",
      originalPurchaseId: null,
      originalSubscriptionDate: null,
    );
  }

  /// 校验交易订单
  @override
  Future<QsPurchaseResult> checkTransactions() async {
    var result = await _invokeNativeMethod("checkTransactions");
    if (result != null) {
      if (result is Map<Object?, Object?>) {
        final QsPurchaseResult purchaseResult = QsPurchaseResult.fromJson(
          _convertObjectMapToMapStringDynamic(result),
        );
        return purchaseResult;
      }
    }

    return QsPurchaseResult(
      status: QsPurchaseStatus.error,
      errorMessage: "未知错误",
      originalPurchaseId: null,
      originalSubscriptionDate: null,
    );
  }

  /// 调用原生方法
  Future<dynamic> _invokeNativeMethod(
    String method, [
    dynamic arguments,
  ]) async {
    try {
      var result = await methodChannel.invokeMethod(method, arguments);
      return result;
    } on PlatformException catch (e) {
      return "Failed to invoke: '${e.message}'.";
    }
  }

  /// 将 Map<Object?, Object?> 转换为 Map<String, dynamic>
  static Map<String, dynamic> _convertObjectMapToMapStringDynamic(
    Map<Object?, Object?> map,
  ) {
    final Map<String, dynamic> result = {};
    map.forEach((key, value) {
      if (key is String) {
        result[key] = value;
      }
    });
    return result;
  }
}
