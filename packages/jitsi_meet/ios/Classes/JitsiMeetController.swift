import CoreLocation
import Flutter
import UIKit
import JitsiMeet

public class JitsiMeetController: NSObject, FlutterPlatformView {
  private let methodChannel: FlutterMethodChannel!
  private let pluginRegistrar: FlutterPluginRegistrar!
  public let jitsiView: JitsiMeetView

  public required init(id: Int64, frame: CGRect, registrar: FlutterPluginRegistrar) {
    self.pluginRegistrar = registrar
    self.jitsiView = JitsiMeetView()
    self.methodChannel = FlutterMethodChannel(
      name: "surf_jitsi_meet_\(id)",
      binaryMessenger: registrar.messenger()
    )
    super.init()
    self.methodChannel.setMethodCallHandler(self.handle)
    
    let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
        builder.welcomePageEnabled = false
        builder.room = "SurfTestRoom"
    }
    
    jitsiView.join(options)
  }

  public func view() -> UIView {
    return self.jitsiView
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

