import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qs_ios_purchase/qs_ios_purchase_method_channel.dart';
import 'package:qs_ios_purchase/qs_ios_purchase_platform_interface.dart';
import 'package:qs_ios_purchase/qs_product_detail.dart';
import 'package:qs_ios_purchase/qs_purchase_result.dart';

class MockQsIosPurchasePlatform
    with MockPlatformInterfaceMixin
    implements QsIosPurchasePlatform {
  @override
  Future<List<QsProductDetail>> getProducts({
    required List<String> productIds,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> initialize({
    required Function(bool isVip) onVipChange,
    required Function(String transactionId) onCancelFreeTrial,
    required Function(String transactionId) onCancelAutoRenew,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> requestPurchase({required String productId}) {
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> restorePurchase() {
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> checkTransactions() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasHistoryTransactions() async {
    // TODO: implement hasHistoryTransactions
    return false;
  }

  @override
  Future<void> handleCancelAutoRenewFailure({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> handleCancelFreeTrialFailure({required String id}) {
    throw UnimplementedError();
  }
}

void main() {
  final QsIosPurchasePlatform initialPlatform = QsIosPurchasePlatform.instance;

  test('$MethodChannelQsIosPurchase is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQsIosPurchase>());
  });
}
