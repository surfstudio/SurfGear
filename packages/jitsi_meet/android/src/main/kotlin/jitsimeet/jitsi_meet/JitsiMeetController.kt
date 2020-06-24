package jitsimeet.jitsi_meet

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import org.jitsi.meet.sdk.JitsiMeetView
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import io.flutter.plugin.common.BinaryMessenger

class JitsiMeetController : PlatformView, MethodChannel.MethodCallHandler {
    val CHANNEL_NAME: String = "surf_jitsi_meet_";

    private var jitsiView: JitsiMeetView
    private var methodChannel: MethodChannel
    private var pluginContext: Context

    override fun getView(): android.view.View = jitsiView

    constructor(context: Context, messanger: BinaryMessenger, id: Int) {
        jitsiView = getJitsiView(context)
        pluginContext = context
        methodChannel = MethodChannel(messanger, "$CHANNEL_NAME$id")
        methodChannel.setMethodCallHandler(this)

        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom("SurfTestRoom")
                .build()

        jitsiView.join(options)
    }

    override fun dispose() {
//    mapView.onStop()
//    MapKitFactory.getInstance().onStop()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "showUserLayer" -> {
//        showUserLayer(call)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }


    private fun getJitsiView(context: Context): JitsiMeetView {
        return JitsiMeetView(context)
    }
}