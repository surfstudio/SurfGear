import Flutter
import UIKit
import JitsiMeet

let CHANNEL_NAME = "surf_jitsi_meet_screen"

/// Methods
let JOIN = "join"

public class SwiftJitsiMeetScreenPlugin: NSObject, FlutterPlugin {
    var flutterViewController: FlutterViewController? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftJitsiMeetScreenPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method{
        case JOIN:
            joinRoom(call)
            break
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }
    
    private func joinRoom(_ call: FlutterMethodCall) {
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.room = "SurfTestRoom"
            builder.welcomePageEnabled = false
        }
        let jitsiView = JitsiMeetView()
        jitsiView.delegate = self
        jitsiView.join(options)
        let ui  = UIViewController()
        ui.modalPresentationStyle = .fullScreen
        ui.view = jitsiView
        
        flutterViewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
        flutterViewController?.present(ui, animated: true, completion: nil)
    }
}

extension SwiftJitsiMeetScreenPlugin: JitsiMeetViewDelegate {
    public func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        flutterViewController?.dismiss(animated: true, completion: nil)
    }
}
