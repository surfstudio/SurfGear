import Flutter
import UIKit

let PAY = "pay"
let PAYMENT_RESPONSE = "payment_response"

public class SwiftSurfpayPlugin: NSObject, FlutterPlugin {
    var channel :FlutterMethodChannel
    
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
         case PAY:
             pay()
             break
         default:
             result(FlutterMethodNotImplemented)
             return
         }
  }
    
    func pay(){
        self.channel.invokeMethod(PAYMENT_RESPONSE, arguments: "ass")
    }
    
    
}
