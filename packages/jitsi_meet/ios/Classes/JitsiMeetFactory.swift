import Flutter
import UIKit


public class JitsiMeetFactory: NSObject, FlutterPlatformViewFactory {
  private let pluginRegistrar: FlutterPluginRegistrar!

  public init(registrar: FlutterPluginRegistrar) {
    self.pluginRegistrar = registrar
  }

  public func create(withFrame frame: CGRect,
                     viewIdentifier viewId: Int64,
                     arguments args: Any?) -> FlutterPlatformView {
    return JitsiMeetController(id: viewId, frame: frame, registrar: self.pluginRegistrar)
  }
}
