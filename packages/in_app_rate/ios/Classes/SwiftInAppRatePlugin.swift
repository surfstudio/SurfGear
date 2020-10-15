import Flutter
import UIKit
import StoreKit

/// Channel
let channelName = "in_app_rate"

/// Methods
let openRatingDialogMethod = "openRatingDialog"

/// Arguments
let isTestEnvironment = "isTestEnvironment"

public class SwiftInAppRatePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = SwiftInAppRatePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case openRatingDialogMethod:
            openRatingDialog(result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func openRatingDialog(_ result: FlutterResult) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            result(true)
        } else {
            result(
                FlutterError( code: "low version",
                              message: "iOS version is Low, min - 10.3",
                              details: nil)
            )
        }
    }
}
