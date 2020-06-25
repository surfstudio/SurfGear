package jitsimeet.jitsi_meet

import android.app.Activity
import android.app.Application
import android.os.Bundle
import androidx.lifecycle.Lifecycle
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.jitsi.meet.sdk.JitsiMeetActivityDelegate


class JitsiMeetPlugin : FlutterPlugin, ActivityAware, Application.ActivityLifecycleCallbacks {
    private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private var activity: Activity? = null
    private val lifecycle: Lifecycle? = null

    // FlutterPlugin
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = null
    }

    companion object {
        val VIEW_TYPE: String = "surfstudio/jitsi_meet"

        fun registerWith(registrar: Registrar) {
            registrar
                    .platformViewRegistry()
                    .registerViewFactory(
                            VIEW_TYPE, JitsiMeetFactory(registrar.messenger(), null))
        }
    }

    /// ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
        pluginBinding!!.getPlatformViewRegistry()
                .registerViewFactory(
                        VIEW_TYPE,
                        JitsiMeetFactory(
                                pluginBinding!!.getBinaryMessenger(),
                                binding.getActivity()))
    }

    override fun onDetachedFromActivity() {
        JitsiMeetActivityDelegate.onHostDestroy(activity!!)
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.getActivity()
    }

    /// Application.ActivityLifecycleCallbacks
    override fun onActivityPaused(p0: Activity?) {
        TODO("Not yet implemented")
    }

    override fun onActivityResumed(p0: Activity?) {
        TODO("Not yet implemented")
    }

    override fun onActivityStarted(p0: Activity?) {
        TODO("Not yet implemented")
    }

    override fun onActivityDestroyed(p0: Activity?) {
        TODO("Not yet implemented")
    }

    override fun onActivitySaveInstanceState(p0: Activity?, p1: Bundle?) {
        TODO("Not yet implemented")
    }

    override fun onActivityStopped(p0: Activity?) {
        TODO("Not yet implemented")
    }

    override fun onActivityCreated(p0: Activity?, p1: Bundle?) {
        TODO("Not yet implemented")
    }
}