import 'payment_item.dart';

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
  Map<String, Object> map() {
    return <String, Object>{
      itemsArg: items.map((item) => item.map()).toList(),
      currencyCodeArg: currencyCode,
      countryCodeArg: countryCode,
    };
  }
}
