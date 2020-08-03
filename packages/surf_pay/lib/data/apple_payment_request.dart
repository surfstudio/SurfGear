import 'package:surfpay/data/payment_item.dart';

const String itemsArg = 'items';
const String countryCodeArg = 'countryCode';
const String currencyCodeArg = 'currencyCode';

/// Apple Pay request data
class ApplePaymentRequest {
  ApplePaymentRequest(
    this.items,
    this.currencyCode,
    this.countryCode,
  );

  final List<PaymentItem> items;
  final String currencyCode;
  final String countryCode;

  /// Cast to Map for sanding to native
  Map<String, dynamic> map() {
    return <String, dynamic>{
      itemsArg: items.map((e) => e.map()).toList(),
      currencyCodeArg: currencyCode,
      countryCodeArg: countryCode,
    };
  }
}
