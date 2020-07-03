const String ALLOWED_AUTH_METHODS = "allowedAuthMethods";
const String ALLOWED_CARD_NETWORKS = "allowedCardNetworks";
const String BILLING_ADDRESS_REQUIRED = "billingAddressRequired";
const String BILLING_ADDRESS_PARAMETERS = "billingAddressParameters";
const String TYPE = "type";

/// Base google pay data
class GooglePayData {
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
  );

  Map<String, dynamic> map() {
    return {
      ALLOWED_AUTH_METHODS: allowedAuthMethods,
      ALLOWED_CARD_NETWORKS: allowedCardNetworks,
      BILLING_ADDRESS_REQUIRED: billingAddressRequired,
      BILLING_ADDRESS_PARAMETERS: billingAddressParameters,
      TYPE: type,
    };
  }
}
