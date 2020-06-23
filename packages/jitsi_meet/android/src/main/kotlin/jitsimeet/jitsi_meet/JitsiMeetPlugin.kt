package jitsimeet.jitsi_meet

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class JitsiMeetPlugin {
    companion object {
        private val VIEW_TYPE: String = "surfstudio/jitsi_meet"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrar.platformViewRegistry().registerViewFactory(
                    VIEW_TYPE,
                    JitsiMeetFactory(registrar)
            );
        }
    }
}