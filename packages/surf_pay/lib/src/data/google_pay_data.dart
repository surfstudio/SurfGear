const String allowedAuthMethodsArg = 'allowedAuthMethods';
const String allowedCardNetworksArg = 'allowedCardNetworks';
const String billingAddressRequiredArg = 'billingAddressRequired';
const String billingAddressParametersArg = 'billingAddressParameters';
const String typeArg = 'type';
const String gatewayArg = 'gateway';
const String gatewayMerchantIdArg = 'gatewayMerchantId';
const String gatewayTypeArg = 'gatewayType';

/// Google Pay payment system information
class GooglePayData {
  GooglePayData(
    this.allowedAuthMethods,
    this.allowedCardNetworks,
    // ignore: avoid_positional_boolean_parameters
    this.billingAddressRequired,
    this.billingAddressParameters,
    this.cardPaymentMethod,
    this.gateway,
    this.gatewayMerchantId,
    this.gatewayType,
  );

  /// Payment data tokenization for the CARD payment method
  final String gateway;
  final String gatewayMerchantId;
  final String gatewayType;

  final List<String> allowedAuthMethods;
  final List<String> allowedCardNetworks;

  /// You can add billing address/phone number associated with a CARD payment method.
  final bool billingAddressRequired;
  final Map<String, String> billingAddressParameters;

  /// Payment type
  final String cardPaymentMethod;

  /// Cast to Map for sanding to native
  Map<String, Object> map() {
    return <String, Object>{
      allowedAuthMethodsArg: allowedAuthMethods,
      allowedCardNetworksArg: allowedCardNetworks,
      billingAddressRequiredArg: billingAddressRequired,
      billingAddressParametersArg: billingAddressParameters,
      typeArg: cardPaymentMethod,
      gatewayArg: gateway,
      gatewayMerchantIdArg: gatewayMerchantId,
      gatewayTypeArg: gatewayType,
    };
  }
}
