import Flutter
import UIKit
import PassKit

// Methods
let PAYMENT_RESPONSE = "payment_response"
let IS_READY_TO_PAY = "is_ready_to_pay"
let PAY = "pay"
let INIT = "init"
let ON_PAYMENT_TOKEN = "onPaymentToken"
let ON_PAYMENT_RESULT = "onPaymentResult"

let ON_SUCCESS = "payment_success"
let ON_CANCEL = "payment_cancel"
let ON_ERROR = "payment_error"

// Arguments
let SUPPORTED_NETWORKS = "supportedNetworks"
let MERCHANT_IDENTIFIER = "merchantIdentifier"
let MERCHANT_CAPABILITIES = "merchantCapabilities"

let ITEMS = "items"

let ITEM_LABEL = "itemLabel"
let ITEM_AMOUNT = "itemAmount"
let ITEM_IS_FINAL = "itemType"

let COUNTRY_CODE = "countryCode"
let CURRENCY_CODE = "currencyCode"

let PAYMENT_ERROR_STATUS = "status"

let PAYMENT_TOKEN_DATA = "paymentTokenData"
let PAYMENT_TOKEN_TRANSITION = "paymentTokenTransition"
let PAYMENT_TOKEN_NETWORK = "paymentTokenNetwork"

let IS_PAYMENT_SUCCESS = "isPaymentSuccess"

public class SwiftSurfpayPlugin: NSObject, FlutterPlugin {
    var channel :FlutterMethodChannel
    
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var isCanceled = true
    
    var paymentController: PKPaymentAuthorizationController?
    var merchantCapabilities: PKMerchantCapability?
    var supportedNetworks = [PKPaymentNetwork]()
    var merchantIdentifier: String?
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "surfpay", binaryMessenger: registrar.messenger())
        let instance = SwiftSurfpayPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method{
        case INIT:
            initPlugin(call: call)
            break
        case PAY:
            pay(call: call)
            break
        case IS_READY_TO_PAY:
            result(isApplePayAvailable(call: call))
            break
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }
    
    func initPlugin(call: FlutterMethodCall) {
        let params = call.arguments as! [String: Any]
        
        self.merchantIdentifier = params[MERCHANT_IDENTIFIER] as? String
        self.merchantCapabilities = PKMerchantCapability.init(rawValue: params[MERCHANT_CAPABILITIES] as! UInt)
        
        if let networks = params[SUPPORTED_NETWORKS] as? Array<String> {
            networks.forEach { (network) in
                supportedNetworks.append(PKPaymentNetwork.init(rawValue: network))
            }
        }
    }
    
    func pay(call: FlutterMethodCall){
        let params = call.arguments as! [String: Any]
        paymentStatus = PKPaymentAuthorizationStatus.failure
        isCanceled = true
        
        let itemsRaw = params[ITEMS] as? Array<Dictionary<String, Any>>
        
        if let items = itemsRaw{
            var paymentSummaryItems = [PKPaymentSummaryItem]()
            items.forEach { (item) in
                let isFinal = item[ITEM_IS_FINAL] as! Bool
                paymentSummaryItems.append(PKPaymentSummaryItem(label: item[ITEM_LABEL] as! String, amount: NSDecimalNumber(string: item[ITEM_AMOUNT] as! String), type: isFinal ? .final : .pending))
            }
            
            // Create our payment request
            // paymentRequest.requiredShippingContactFields need IOS 11+
            let paymentRequest = PKPaymentRequest()
            paymentRequest.paymentSummaryItems = paymentSummaryItems
            paymentRequest.merchantIdentifier = self.merchantIdentifier!
            paymentRequest.merchantCapabilities = self.merchantCapabilities!
            paymentRequest.supportedNetworks = self.supportedNetworks
            paymentRequest.countryCode = params[COUNTRY_CODE] as! String
            paymentRequest.currencyCode = params[CURRENCY_CODE] as! String
            
            // Display our payment request
            paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
            paymentController?.delegate = self
            paymentController?.present(completion: { (presented: Bool) in
                if presented {
                    debugPrint("Presented payment controller")
                } else {
                    debugPrint("Failed to present payment controller")
                    self.isCanceled = false
                    self.channel.invokeMethod(PAYMENT_ERROR_STATUS, arguments: [PAYMENT_ERROR_STATUS: 21])
                }
            })
        }
    }
    
    // supportedNetworks - available cards
    // if PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks)
    // if user hsasn't available card - still can show button, apple pay suggest to enter available card, not a list of cards
    func isApplePayAvailable(call: FlutterMethodCall) -> Bool{
        return PKPaymentAuthorizationController.canMakePayments() && PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks)
    }
}

extension SwiftSurfpayPlugin : PKPaymentAuthorizationControllerDelegate {
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        isCanceled = false
        
        let args: Dictionary<String, Any> = [
            PAYMENT_TOKEN_DATA: String(data: payment.token.paymentData.base64EncodedData(), encoding: .utf8),
            PAYMENT_TOKEN_TRANSITION: payment.token.transactionIdentifier,
            PAYMENT_TOKEN_NETWORK: payment.token.paymentMethod.type.rawValue
        ]
        
        self.channel.invokeMethod(ON_PAYMENT_RESULT, arguments: args) { (isSuccessRaw) in
            if let isSuccess = isSuccessRaw as? Bool {
                if isSuccess {
                    self.paymentStatus = .success
                    completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
                } else {
                    self.paymentStatus = .failure
                    completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                }
            }
        }
    }
    
    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            // We are responsible for dismissing the payment sheet once it has finished
            DispatchQueue.main.async {
                if self.isCanceled {
                    self.channel.invokeMethod(ON_CANCEL, arguments: Dictionary<String, String>())
                    return
                }
                if self.paymentStatus == .success {
                    self.channel.invokeMethod(ON_SUCCESS, arguments: Dictionary<String, String>())
                } else {
                    self.channel.invokeMethod(ON_ERROR, arguments: [PAYMENT_ERROR_STATUS: 22])
                }
            }
        }
    }
}
