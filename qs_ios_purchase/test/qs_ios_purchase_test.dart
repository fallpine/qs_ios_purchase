import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qs_ios_purchase/qs_ios_purchase_platform_interface.dart';
import 'package:qs_ios_purchase/qs_ios_purchase_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:qs_ios_purchase/qs_purchase_result.dart';

class MockQsIosPurchasePlatform
    with MockPlatformInterfaceMixin
    implements QsIosPurchasePlatform {
  @override
  Future<dynamic> getProducts({required List<String> productIds}) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<void> initialize({
    required Function(bool isVip) onVipChange,
    required VoidCallback onCancelFreeTrial,
    required VoidCallback onCancelAutoRenew,
  }) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> requestPurchase({required String productId}) {
    // TODO: implement requestPurchase
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> restorePurchase() {
    // TODO: implement restorePurchase
    throw UnimplementedError();
  }

  @override
  Future<QsPurchaseResult> checkTransactions() {
    // TODO: implement checkTransactions
    throw UnimplementedError();
  }

  @override
  Future<bool> hasHistoryTransaction() {
    // TODO: implement hasHistoryTransaction
    throw UnimplementedError();
  }
}

void main() {
  final QsIosPurchasePlatform initialPlatform = QsIosPurchasePlatform.instance;

  test('$MethodChannelQsIosPurchase is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQsIosPurchase>());
  });
}
