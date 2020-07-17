import Flutter
import UIKit

public class SwiftJitsiMeetPlugin: NSObject, FlutterPlugin {
  
    public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(
      JitsiMeetFactory(registrar: registrar),
      withId: "surfstudio/jitsi_meet"
    )
  }
}
