import 'package:surfpay/data/payment_item.dart';

const String ITEMS = "items";
const String COUNTRY_CODE = "countryCode";
const String CURRENCY_CODE = "currencyCode";

/// Apple Pay request data
class ApplePaymentRequest {
  final List<PaymentItem> items;
  final String currencyCode;
  final String countryCode;

  ApplePaymentRequest(
    this.items,
    this.currencyCode,
    this.countryCode,
  );

  Map<String, dynamic> map() {
    return <String, dynamic>{
      ITEMS: items.map((e) => e.map()).toList(),
      CURRENCY_CODE: currencyCode,
      COUNTRY_CODE: countryCode,
    };
  }
}
