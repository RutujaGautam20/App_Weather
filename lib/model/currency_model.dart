class CurrencyModel {
  final String currency;
  final Map<String, dynamic> exchangeRateData;
  final String baseCode;
  final String provider;
  final String documentation;

  CurrencyModel({
    required this.currency,
    required this.exchangeRateData,
    required this.baseCode,
    required this.provider,
    required this.documentation,
  });

  factory CurrencyModel.fromJson(String currency, Map<String, dynamic> json) {
    return CurrencyModel(
      currency: currency,
      exchangeRateData: json['rates'],
      baseCode: json['base_code'],
      provider: json['provider'],
      documentation: json['documentation'],
    );
  }
}
