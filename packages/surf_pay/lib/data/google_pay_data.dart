const String ALLOWED_AUTH_METHODS = "allowedAuthMethods";
const String ALLOWED_CARD_NETWORKS = "allowedCardNetworks";
const String BILLING_ADDRESS_REQUIRED = "billingAddressRequired";
const String BILLING_ADDRESS_PARAMETERS = "billingAddressParameters";
const String TYPE = "type";
const String GATEWAY = "gateway";
const String GATEWAY_MERCHANT_ID = "gatewayMerchantId";
const String GATEWAY_TYPE = "gatewayType";

/// Google Pay immutable data
class GooglePayData {
  final String gateway;
  final String gatewayMerchantId;
  final String gatewayType;
  final List<String> allowedAuthMethods;
  final List<String> allowedCardNetworks;
  final bool billingAddressRequired;
  final Map<String, String> billingAddressParameters;
  final String type;

  GooglePayData(
    this.allowedAuthMethods,
    this.allowedCardNetworks,
    this.billingAddressRequired,
    this.billingAddressParameters,
    this.type,
    this.gateway,
    this.gatewayMerchantId,
    this.gatewayType,
  );

  Map<String, dynamic> map() {
    return {
      ALLOWED_AUTH_METHODS: allowedAuthMethods,
      ALLOWED_CARD_NETWORKS: allowedCardNetworks,
      BILLING_ADDRESS_REQUIRED: billingAddressRequired,
      BILLING_ADDRESS_PARAMETERS: billingAddressParameters,
      TYPE: type,
      GATEWAY: gateway,
      GATEWAY_MERCHANT_ID: gatewayMerchantId,
      GATEWAY_TYPE: gatewayType,
    };
  }
}
