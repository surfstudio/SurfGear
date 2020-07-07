const MERCHANT_IDENTIFIER = "merchantIdentifier";
const MERCHANT_CAPABILITIES = "merchantCapabilities";
const SUPPORTED_NETWORKS = "supported_networks";

/// Apple Pay init data
class ApplePayData {
  final MerchantCapabilities merchantCapabilities;

  /// Set in project in Signing & Capabilities
  final String merchantIdentifier;

  final List<PaymentNetwork> supportedNetworks;

  ApplePayData(
    this.merchantCapabilities,
    this.merchantIdentifier,
    this.supportedNetworks,
  );

  Map<String, dynamic> map() {
    return {
      MERCHANT_IDENTIFIER: merchantIdentifier,
      MERCHANT_CAPABILITIES: merchantCapabilities.value,
      SUPPORTED_NETWORKS:
          supportedNetworks.map<String>((e) => e.value).toList(),
    };
  }
}

/// https://developer.apple.com/documentation/passkit/pkmerchantcapability
class MerchantCapabilities {
  final int _value;

  int get value => _value;

  MerchantCapabilities._(this._value);

  static final capability3DS = MerchantCapabilities._(1);
  static final capabilityEMV = MerchantCapabilities._(2);
  static final capabilityCredit = MerchantCapabilities._(4);
  static final capabilityDebit = MerchantCapabilities._(8);
}

/// https://developer.apple.com/documentation/passkit/pkpaymentnetwork
class PaymentNetwork {
  final String _value;

  String get value => _value;

  PaymentNetwork._(this._value);

  //available(iOS 8.0, *)
  static final amex = PaymentNetwork._('AmEx');

  //iOS, introduced: 10.3, deprecated: 11.0, message: "Use PKPaymentNetworkCartesBancaires instead."
  static final carteBancaire = PaymentNetwork._('CarteBancaire');

  //available(iOS, introduced: 11.0, deprecated: 11.2, message: "Use PKPaymentNetworkCartesBancaires instead.")
  static final carteBancaires = PaymentNetwork._('CarteBancaires');

  //available(iOS 11.2, *)
  static final cartesBancaires = PaymentNetwork._('CartesBancaires');

  //available(iOS 9.2, *)
  static final chinaUnionPay = PaymentNetwork._('ChinaUnionPay');

  //available(iOS 9.0, *)
  static final discover = PaymentNetwork._('Discover');

  //available(iOS 12.0, *)
  static final eftpos = PaymentNetwork._('Eftpos');

  //available(iOS 12.0, *)
  static final electron = PaymentNetwork._('Electron');

  //available(iOS 12.1.1, *)
  static final elo = PaymentNetwork._('Elo');

  //available(iOS 10.3, *)
  static final idCredit = PaymentNetwork._('iD');

  //available(iOS 9.2, *)
  static final interac = PaymentNetwork._('Interac');

  //available(iOS 10.1, *)
  static final JCB = PaymentNetwork._('JCB');

  //available(iOS 12.1.1, *)
  static final mada = PaymentNetwork._('mada');

  //available(iOS 12.0, *)
  static final maestro = PaymentNetwork._('Maestro');

  //available(iOS 8.0, *)
  static final masterCard = PaymentNetwork._('MasterCard');

  //available(iOS 9.0, *)
  static final privateLabel = PaymentNetwork._('PrivateLabel');

  //available(iOS 10.3, *)
  static final quicPay = PaymentNetwork._('QUICPay');

  //available(iOS 10.1, *)
  static final suica = PaymentNetwork._('Suica');

  //available(iOS 8.0, *)
  static final visa = PaymentNetwork._('Visa');

  //available(iOS 12.0, *)
  static final vPay = PaymentNetwork._('VPay');
}
