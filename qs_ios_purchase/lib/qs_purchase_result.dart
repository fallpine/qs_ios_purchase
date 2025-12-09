class QsPurchaseResult {
  QsPurchaseResult({
    required this.status,
    required this.errorMessage,
    required this.originalPurchaseId,
    required this.originalSubscriptionDate,
  });
  late final QsPurchaseStatus? status;
  late final String? errorMessage;
  late final String? originalPurchaseId;
  late final String? originalSubscriptionDate;

  QsPurchaseResult.fromJson(Map<String, dynamic> json) {
    try {
      status = QsPurchaseStatus.values.firstWhere(
        (element) => element.name == json['status'],
      );
    } catch (_) {
      status = null;
    }

    errorMessage = json['errorMessage'];
    originalPurchaseId = json['originalPurchaseId'];
    originalSubscriptionDate = json['originalSubscriptionDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status?.name;
    data['errorMessage'] = errorMessage;
    data['originalPurchaseId'] = originalPurchaseId;
    data['originalSubscriptionDate'] = originalSubscriptionDate;
    return data;
  }
}

enum QsPurchaseStatus { success, error, cancel }
