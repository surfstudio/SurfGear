import Flutter
import UIKit
import JitsiMeet

let CHANNEL_NAME = "surf_jitsi_meet_screen"

/// Methods
let JOIN_ROOM: String = "join_room"
let LEAVE_ROOM: String = "leave_room"
let ON_JOINED: String = "on_joined"
let ON_WILL_JOIN: String = "on_will_join"
let ON_TERMINATED: String = "on_terminated"
let SET_USER: String = "set_user"
let SET_FEATURE_FLAG: String = "set_feature_flag"

/// Variables
let ROOM = "room"
let AUDIO_MUTED = "audioMuted"
let VIDEO_MUTED = "videoMuted"
let AUDIO_ONLY = "audioOnly"

let USERNAME = "displayName"
let EMAIL = "email"
let AVATAR_URL = "avatarURL"

let FLAG = "flag"
let FLAG_VALUE = "flag_value"


public class SwiftJitsiMeetScreenPlugin: NSObject, FlutterPlugin {
    /// CUSTOM Picture in Picture
    //    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    private let methodChannel: FlutterMethodChannel!
    var flutterViewController: FlutterViewController?
    private var jitsiView: JitsiMeetView?
    private var userInfo: JitsiMeetUserInfo?
    private var features: [String: Bool] = [:]
    
    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftJitsiMeetScreenPlugin(methodChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method{
        case JOIN_ROOM:
            joinRoom(call)
            break
        case LEAVE_ROOM:
            leaveRoom(call)
            result(nil)
        case SET_USER:
            setUser(call)
            result(nil)
        case SET_FEATURE_FLAG:
            setFeatureFlag(call)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }
    
    fileprivate func cleanUp() {
        jitsiView?.removeFromSuperview()
        jitsiView = nil
        //        pipViewCoordinator = nil
    }
    
    /// Leave room
    private func leaveRoom(_ call: FlutterMethodCall) {
        jitsiView?.leave()
    }
    
    /// Join Room
    private func joinRoom(_ call: FlutterMethodCall) {
        cleanUp()
        
        let params = call.arguments as! [String: Any]
        let room = params[ROOM] as! String
        let audioMuted = params[AUDIO_MUTED] as? Bool
        let videoMuted = params[VIDEO_MUTED] as? Bool
        let audioOnly = params[AUDIO_ONLY] as? Bool
        
        
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.room = room
            builder.userInfo = self.userInfo
            if let audio = audioMuted {
                builder.audioMuted = audio
            }
            if let video = videoMuted {
                builder.videoMuted = video
            }
            if let audio = audioOnly {
                builder.audioOnly = audio
            }
            
            self.features.forEach { (key: String, value: Bool) in
                builder.setFeatureFlag(key, withValue: value)
            }
        }
        
        jitsiView = JitsiMeetView()
        jitsiView?.delegate = self
        jitsiView?.join(options)
        let ui  = UIViewController()
        ui.modalPresentationStyle = .fullScreen
        ui.view = jitsiView
        
        flutterViewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
        flutterViewController?.present(ui, animated: true, completion: nil)
        
        /// For CUSTOM Picture in Picture
        //        pipViewCoordinator = PiPViewCoordinator(withView: jitsiView!)
        //        flutterViewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
        //        pipViewCoordinator?.configureAsStickyView(withParentView: flutterViewController?.view)
        //
        //        // animate in
        //        jitsiView?.alpha = 0
        //        pipViewCoordinator?.show()
    }
    
    /// Set information about user
    private func setUser(_ call: FlutterMethodCall) {
        let params = call.arguments as! [String: Any]
        
        userInfo?.displayName = params[USERNAME] as? String
        userInfo?.email = params[EMAIL] as? String
        
        let avatarUrl = params[AVATAR_URL] as? String
        if let url = avatarUrl {
            userInfo?.avatar = URL(string: url)
        }
    }
    
    /// Set enabled feature state
    private func setFeatureFlag(_ call: FlutterMethodCall) {
        let params = call.arguments as! [String: Any]
        
        let flag = params[FLAG] as? String
        let value = params[FLAG_VALUE] as? Bool
        
        if flag != nil && value != nil {
            features[flag!] = value!
        }
    }
}

extension SwiftJitsiMeetScreenPlugin: JitsiMeetViewDelegate {
    public func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        flutterViewController?.dismiss(animated: true, completion: nil)
        methodChannel.invokeMethod(ON_TERMINATED, arguments: data)
        /// CUSTOM Picture in Picture
        //        DispatchQueue.main.async {
        //            self.pipViewCoordinator?.hide() { _ in
        //                self.methodChannel.invokeMethod(ON_TERMINATED, arguments: data)
        //                self.cleanUp()
        //            }
        //        }
    }
    
    public func conferenceJoined(_ data: [AnyHashable: Any]!) {
        methodChannel.invokeMethod(ON_JOINED, arguments: data)
    }
    
    public func conferenceWillJoin(_ data: [AnyHashable: Any]!) {
        methodChannel.invokeMethod(ON_WILL_JOIN, arguments: data)
    }
    /// CUSTOM Picture in Picture
    //    public func enterPicture(inPicture data: [AnyHashable : Any]!) {
    //        DispatchQueue.main.async {
    //            self.pipViewCoordinator?.enterPictureInPicture()
    //        }
    //    }
}
