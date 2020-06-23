package jitsimeet.jitsi_meet

import com.unact.yandexmapkit.JitsiMeetController
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class JitsiMeetFactory(registrar: Registrar) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  private val pluginRegistrar: Registrar
  fun create(context: android.content.Context?, id: Int, o: Any?): PlatformView {
    return JitsiMeetController(id, context, pluginRegistrar)
  }

  init {
    pluginRegistrar = registrar
  }
}
