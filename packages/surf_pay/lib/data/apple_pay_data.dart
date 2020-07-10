const MERCHANT_IDENTIFIER = "merchantIdentifier";
const MERCHANT_CAPABILITIES = "merchantCapabilities";
const SUPPORTED_NETWORKS = "supported_networks";

/// Apple Pay immutable data
class ApplePayData {
  final MerchantCapabilities merchantCapabilities;

  /// Set in XCode in Signing & Capabilities
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

  const PaymentNetwork._(this._value);

  //available(iOS 8.0, *)
  static const amex = PaymentNetwork._('AmEx');

  //iOS, introduced: 10.3, deprecated: 11.0, message: "Use PKPaymentNetworkCartesBancaires instead."
  static const carteBancaire = PaymentNetwork._('CarteBancaire');

  //available(iOS, introduced: 11.0, deprecated: 11.2, message: "Use PKPaymentNetworkCartesBancaires instead.")
  static const carteBancaires = PaymentNetwork._('CarteBancaires');

  //available(iOS 11.2, *)
  static const cartesBancaires = PaymentNetwork._('CartesBancaires');

  //available(iOS 9.2, *)
  static const chinaUnionPay = PaymentNetwork._('ChinaUnionPay');

  //available(iOS 9.0, *)
  static const discover = PaymentNetwork._('Discover');

  //available(iOS 12.0, *)
  static const eftpos = PaymentNetwork._('Eftpos');

  //available(iOS 12.0, *)
  static const electron = PaymentNetwork._('Electron');

  //available(iOS 12.1.1, *)
  static const elo = PaymentNetwork._('Elo');

  //available(iOS 10.3, *)
  static const idCredit = PaymentNetwork._('iD');

  //available(iOS 9.2, *)
  static const interac = PaymentNetwork._('Interac');

  //available(iOS 10.1, *)
  static const JCB = PaymentNetwork._('JCB');

  //available(iOS 12.1.1, *)
  static const mada = PaymentNetwork._('mada');

  //available(iOS 12.0, *)
  static const maestro = PaymentNetwork._('Maestro');

  //available(iOS 8.0, *)
  static const masterCard = PaymentNetwork._('MasterCard');

  //available(iOS 9.0, *)
  static const privateLabel = PaymentNetwork._('PrivateLabel');

  //available(iOS 10.3, *)
  static const quicPay = PaymentNetwork._('QUICPay');

  //available(iOS 10.1, *)
  static const suica = PaymentNetwork._('Suica');

  //available(iOS 8.0, *)
  static const visa = PaymentNetwork._('Visa');

  //available(iOS 12.0, *)
  static const vPay = PaymentNetwork._('VPay');
}

/// https://developer.apple.com/documentation/passkit/pkpaymentmethodtype
class PaymentMethodType {
  final int _value;

  int get value => _value;

  const PaymentMethodType._(this._value);

  factory PaymentMethodType.byValue(int value) {
    switch(value) {
      case 0:
        return unknown;
      case 1:
        return debit;
      case 2:
        return credit;
      case 3:
        return prepaid;
      case 4:
        return store;
      default:
        return unknown;
    }
  }

  static const unknown = PaymentMethodType._(0);
  static const debit = PaymentMethodType._(1);
  static const credit = PaymentMethodType._(2);
  static const prepaid = PaymentMethodType._(3);
  static const store = PaymentMethodType._(4);
}