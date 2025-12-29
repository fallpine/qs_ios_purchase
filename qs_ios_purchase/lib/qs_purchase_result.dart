class QsPurchaseResult {
  QsPurchaseResult({
    required this.status,
    required this.errorMessage,
    required this.productID,
    required this.transactionID,
    required this.originalTransactionID,
    required this.subscriptionDate,
    required this.originalSubscriptionDate,
    required this.price,
  });
  late final QsPurchaseStatus? status;
  late final String? errorMessage;
  late final String? productID;
  late final String? transactionID;
  late final String? originalTransactionID;
  late final String? subscriptionDate;
  late final String? originalSubscriptionDate;
  late final String? price;

  QsPurchaseResult.fromJson(Map<String, dynamic> json) {
    try {
      status = QsPurchaseStatus.values.firstWhere(
        (element) => element.name == json['status'],
      );
    } catch (_) {
      status = null;
    }

    errorMessage = json['errorMessage'];
    productID = json['productID'];
    transactionID = json['transactionID'];
    originalTransactionID = json['originalTransactionID'];
    subscriptionDate = json['subscriptionDate'];
    originalSubscriptionDate = json['originalSubscriptionDate'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status?.name;
    data['errorMessage'] = errorMessage;
    data['productID'] = productID;
    data['transactionID'] = transactionID;
    data['originalTransactionID'] = originalTransactionID;
    data['subscriptionDate'] = subscriptionDate;
    data['originalSubscriptionDate'] = originalSubscriptionDate;
    data['price'] = price;
    return data;
  }
}

enum QsPurchaseStatus { success, error, cancel }
