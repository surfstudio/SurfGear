const String PRICE = "price";
const String MERCHANT_INFO = "merchantInfo";
const String PHONE_NUMBER_REQUIRED = "phoneNumberRequired";
const String ALLOWED_COUNTRY_CODES = "allowedCountryCodes";
const String SHIPPING_ADDRESS_REQUIRED = "shippingAddressRequired";

class GooglePaymentRequest {
  final String price;
  final Map<String, String> merchantInfo;
  final bool phoneNumberRequired;
  final List<String> allowedCountryCodes;
  final bool shippingAddressRequired;

  GooglePaymentRequest(
    this.price,
    this.merchantInfo,
    this.phoneNumberRequired,
    this.allowedCountryCodes,
    this.shippingAddressRequired,
  );

  Map<String, dynamic> map() {
    return <String, dynamic>{
      PRICE: price,
      MERCHANT_INFO: merchantInfo,
      PHONE_NUMBER_REQUIRED: phoneNumberRequired,
      ALLOWED_COUNTRY_CODES: allowedCountryCodes,
      SHIPPING_ADDRESS_REQUIRED: shippingAddressRequired,
    };
  }
}
