import 'package:surfpay/src/data/apple_payment_request.dart';

const String priceArg = 'price';
const String merchantInfoArg = 'merchantInfo';
const String phoneNumberRequiredArg = 'phoneNumberRequired';
const String allowedCountryCodesArg = 'allowedCountryCodes';
const String shippingAddressRequiredArg = 'shippingAddressRequired';

class GooglePaymentRequest {
  GooglePaymentRequest(this.price,
      this.merchantInfo,
    // ignore: avoid_positional_boolean_parameters
    this.phoneNumberRequired,
      this.allowedCountryCodes,
      this.shippingAddressRequired,
      this.countryCode,
      this.currencyCode,);

  final String price;
  final Map<String, String> merchantInfo;
  final bool phoneNumberRequired;
  final List<String> allowedCountryCodes;
  final bool shippingAddressRequired;
  final String countryCode;
  final String currencyCode;

  Map<String, Object> map() {
    return <String, Object>{
      priceArg: price,
      merchantInfoArg: merchantInfo,
      phoneNumberRequiredArg: phoneNumberRequired,
      allowedCountryCodesArg: allowedCountryCodes,
      shippingAddressRequiredArg: shippingAddressRequired,
      countryCodeArg: countryCode,
      currencyCodeArg: currencyCode,
    };
  }
}
