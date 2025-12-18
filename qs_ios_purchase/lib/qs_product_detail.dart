class QsProductDetail {
  QsProductDetail({
    required this.id,
    required this.productType,
    required this.currencyPrice,
    required this.discountCurrencyPrice,
    required this.discountRate,
    required this.trialPeriodValue,
    required this.trialPeriodUnit,
    required this.subscriptionPeriodValue,
    required this.subscriptionPeriodUnit,
    required this.languageCode,
    required this.regionCode,
    required this.weekAveragePrice,
  });
  late final String id;
  late final QsProductType? productType;
  late final String? currencyPrice;
  late final String? discountCurrencyPrice;
  late final int? discountRate;
  late final int? trialPeriodValue;
  late final QsPeriodUnit? trialPeriodUnit;
  late final int? subscriptionPeriodValue;
  late final QsPeriodUnit? subscriptionPeriodUnit;
  late final String? languageCode;
  late final String? regionCode;
  late final String? weekAveragePrice;

  QsProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    try {
      productType = QsProductType.values.firstWhere(
        (element) => element.name == json['productType'],
      );
    } catch (_) {
      productType = null;
    }

    currencyPrice = json['currencyPrice'];
    discountCurrencyPrice = json['discountCurrencyPrice'];
    discountRate = json['discountRate'];
    trialPeriodValue = json['trialPeriodValue'];
    languageCode = json['languageCode'];
    regionCode = json['regionCode'];
    weekAveragePrice = json['weekAveragePrice'];

    try {
      trialPeriodUnit = QsPeriodUnit.values.firstWhere(
        (element) => element.name == json['trialPeriodUnit'],
      );
    } catch (_) {
      trialPeriodUnit = null;
    }

    subscriptionPeriodValue = json['subscriptionPeriodValue'];

    try {
      subscriptionPeriodUnit = QsPeriodUnit.values.firstWhere(
        (element) => element.name == json['subscriptionPeriodUnit'],
      );
    } catch (_) {
      subscriptionPeriodUnit = null;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productType'] = productType?.name;
    data['currencyPrice'] = currencyPrice;
    data['discountCurrencyPrice'] = discountCurrencyPrice;
    data['discountRate'] = discountRate;
    data['trialPeriodValue'] = trialPeriodValue;
    data['trialPeriodUnit'] = trialPeriodUnit?.name;
    data['subscriptionPeriodValue'] = subscriptionPeriodValue;
    data['subscriptionPeriodUnit'] = subscriptionPeriodUnit?.name;
    data['languageCode'] = languageCode;
    data['regionCode'] = regionCode;
    data['weekAveragePrice'] = weekAveragePrice;
    return data;
  }
}

enum QsProductType { consumable, nonConsumable, nonRenewable, autoRenewable }

enum QsPeriodUnit { day, week, month, year }
