package jitsimeet.jitsi_meet

import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.BinaryMessenger

class JitsiMeetFactory(private val messanger: BinaryMessenger,
                       private val activityContext: android.content.Context?
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: android.content.Context, i: Int, o: Any?): PlatformView {
        return JitsiMeetController(activityContext ?: context, messanger, i)
    }
}