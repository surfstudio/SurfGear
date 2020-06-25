import CoreLocation
import Flutter
import UIKit
import JitsiMeet

/// Methods
let JOIN_ROOM: String = "join_room"
let LEAVE_ROOM: String = "leave_room"
let ON_JOINED: String = "on_joined"
let ON_WILL_JOIN: String = "on_will_join"
let ON_TERMINATED: String = "on_terminated"
let SET_USER: String = "set_user"

/// Variables
let ROOM = "room"
let AUDIO_MUTED = "audioMuted"
let VIDEO_MUTED = "videoMuted"
let AUDIO_ONLY = "audioOnly"

let USERNAME = "displayName"
let EMAIL = "email"
let AVATAR_URL = "avatarURL"

public class JitsiMeetController: NSObject, FlutterPlatformView {
    private let methodChannel: FlutterMethodChannel!
    private let pluginRegistrar: FlutterPluginRegistrar!
    private let jitsiView: JitsiMeetView
    private var userInfo: JitsiMeetUserInfo?
    
    public required init(id: Int64, frame: CGRect, registrar: FlutterPluginRegistrar) {
        self.pluginRegistrar = registrar
        self.jitsiView = JitsiMeetView()
        self.methodChannel = FlutterMethodChannel(
            name: "surf_jitsi_meet_\(id)",
            binaryMessenger: registrar.messenger()
        )
        super.init()
        jitsiView.delegate = self
        self.methodChannel.setMethodCallHandler(self.handle)
    }
    
    public func view() -> UIView {
        return self.jitsiView
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case JOIN_ROOM:
            joinRoom(call)
            result(nil)
        case LEAVE_ROOM:
            leaveRoom(call)
            result(nil)
        case SET_USER:
            setUser(call)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func leaveRoom(_ call: FlutterMethodCall) {
        jitsiView.leave()
    }
    
    private func joinRoom(_ call: FlutterMethodCall) {
        let params = call.arguments as! [String: Any]
        let room = params[ROOM] as! String
        let audioMuted = params[AUDIO_MUTED] as? Bool
        let videoMuted = params[VIDEO_MUTED] as? Bool
        let audioOnly = params[AUDIO_ONLY] as? Bool
        
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.room = room
            builder.setFeatureFlag("pip.enabled", withValue: false)
            builder.welcomePageEnabled = false
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
        }
        
        jitsiView.join(options)
    }
    
    private func setUser(_ call: FlutterMethodCall) {
        let params = call.arguments as! [String: Any]
        
        userInfo?.displayName = params[USERNAME] as? String
        userInfo?.email = params[EMAIL] as? String
        
        let avatarUrl = params[AVATAR_URL] as? String
        if let url = avatarUrl {
            userInfo?.avatar = URL(string: url)
        }
    }
}

extension JitsiMeetController: JitsiMeetViewDelegate {
    public func conferenceTerminated(_ data: [AnyHashable: Any]!) {
        methodChannel.invokeMethod(ON_TERMINATED, arguments: data)
    }
}

