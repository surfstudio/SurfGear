package jitsimeet.jitsi_meet

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import jdk.nashorn.internal.objects.NativeFunction.call
import org.jitsi.meet.sdk.JitsiMeetView

class JitsiMeetController : PlatformView, MethodChannel.MethodCallHandler {
  val CHANNEL_NAME: String = "surf_jitsi_meet_";

  private lateinit var jitsiView: JitsiMeetView
  private lateinit var methodChannel: MethodChannel
  private var pluginRegistrar: PluginRegistry.Registrar? = null

  val view: android.view.View
    get() = jitsiView

  constructor(id: Int, context: Context, registrar: PluginRegistry.Registrar) {
    jitsiView = JitsiMeetView(context)
    pluginRegistrar = registrar
    methodChannel = MethodChannel(registrar.messenger(), "$CHANNEL_NAME$id")
    methodChannel.setMethodCallHandler(this)
  }

  fun dispose() {
//    mapView.onStop()
//    MapKitFactory.getInstance().onStop()
  }

  fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "showUserLayer" -> {
//        showUserLayer(call)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }
}