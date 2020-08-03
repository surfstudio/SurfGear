const String priceArg = 'price';
const String merchantInfoArg = 'merchantInfo';
const String phoneNumberRequiredArg = 'phoneNumberRequired';
const String allowedCountryCodesArg = 'allowedCountryCodes';
const String shippingAddressRequiredArg = 'shippingAddressRequired';
const String countryCodeArg = 'countryCode';
const String currencyCodeArg = 'currencyCode';

class GooglePaymentRequest {
  GooglePaymentRequest(
    this.price,
    this.merchantInfo,
    this.phoneNumberRequired,
    this.allowedCountryCodes,
    this.shippingAddressRequired,
    this.countryCode,
    this.currencyCode,
  );

  final String price;
  final Map<String, String> merchantInfo;
  final bool phoneNumberRequired;
  final List<String> allowedCountryCodes;
  final bool shippingAddressRequired;
  final String countryCode;
  final String currencyCode;

  Map<String, dynamic> map() {
    return <String, dynamic>{
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
