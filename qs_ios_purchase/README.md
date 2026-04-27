# qs_ios_purchase

一个基于 iOS StoreKit 2 的 Flutter 内购插件，支持获取商品、发起购买、恢复购买、校验交易、监听 VIP 状态变化，以及处理取消免费试用/自动续订相关事件。

> 当前插件仅支持 iOS，最低系统版本为 iOS 15.0。

## 安装

在项目的 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_ios_purchase: ^1.0.3
```

如果是本地调试，可以使用路径依赖：

```yaml
dependencies:
  qs_ios_purchase:
    path: ../qs_ios_purchase
```

然后执行：

```bash
flutter pub get
```

## iOS 配置

1. 在 App Store Connect 中创建内购商品，并记录商品 ID。
2. 确认 Flutter 工程的 iOS Deployment Target 不低于 `15.0`。
3. 在真机或 Sandbox 账号环境下测试内购流程，模拟器可能无法完整验证真实支付行为。

## 使用方法

### 1. 初始化

建议在应用启动后先调用 `initialize`，用于注册原生内购监听。

```dart
import 'package:qs_ios_purchase/qs_ios_purchase.dart';

Future<void> initPurchase() async {
  await QsIosPurchase.initialize(
    onVipChange: (isVip) {
      // VIP 状态变化
      print('isVip: $isVip');
    },
    onCancelFreeTrial: (transactionId) {
      // 用户取消免费试用事件
      print('cancel free trial: $transactionId');
    },
    onCancelAutoRenew: (transactionId) {
      // 用户取消自动续订事件
      print('cancel auto renew: $transactionId');
    },
  );
}
```

### 2. 获取商品列表

```dart
final products = await QsIosPurchase.getProducts(
  productIds: [
    'your_product_id',
    'your_subscription_id',
  ],
);

print(products);
```

成功时返回 `List<QsProductDetail>`，商品信息包含价格、币种、订阅周期、试用周期、优惠信息等字段。失败时可能返回错误字符串。

### 3. 发起购买

```dart
final result = await QsIosPurchase.requestPurchase(
  productId: 'your_product_id',
);

switch (result.status) {
  case QsPurchaseStatus.success:
    print('购买成功: ${result.transactionID}');
    break;
  case QsPurchaseStatus.cancel:
    print('用户取消购买');
    break;
  case QsPurchaseStatus.error:
  default:
    print('购买失败: ${result.errorMessage}');
    break;
}
```

### 4. 恢复购买

```dart
final result = await QsIosPurchase.restorePurchase();

if (result.status == QsPurchaseStatus.success) {
  print('恢复购买成功');
} else {
  print('恢复购买失败: ${result.errorMessage}');
}
```

### 5. 校验交易

```dart
final result = await QsIosPurchase.checkTransactions();

if (result?.status == QsPurchaseStatus.success) {
  print('存在有效交易');
} else {
  print('没有有效交易: ${result?.errorMessage}');
}
```

### 6. 查询历史交易数量

```dart
final count = await QsIosPurchase.historyTransactionCount();
print('历史交易数量: $count');
```

### 7. 取消续订/试用处理失败后的补偿

如果业务侧处理取消自动续订或取消免费试用事件失败，可以调用对应方法通知原生侧重新处理。

```dart
await QsIosPurchase.handleCancelAutoRenewFailure(id: transactionId);
await QsIosPurchase.handleCancelFreeTrialFailure(id: transactionId);
```

## 常用状态

`QsPurchaseResult.status` 可能为：

- `QsPurchaseStatus.success`：操作成功
- `QsPurchaseStatus.cancel`：用户取消
- `QsPurchaseStatus.error`：操作失败，可读取 `errorMessage`

## 注意事项

- 请先调用 `initialize`，再执行购买、恢复购买或交易校验相关逻辑。
- 商品 ID 必须与 App Store Connect 中配置的一致。
- 内购流程建议在真机、Sandbox 账号和 TestFlight 环境中完整测试。
