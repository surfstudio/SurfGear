package ru.surf.jitsi_meet_screen

import android.app.Activity
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions

const val CHANNEL_NAME = "surf_jitsi_meet_screen"

/// Methods
const val JOIN_ROOM: String = "join_room"
const val LEAVE_ROOM: String = "leave_room"
const val ON_JOINED: String = "on_joined"
const val ON_WILL_JOIN: String = "on_will_join"
const val ON_TERMINATED: String = "on_terminated"
const val SET_USER: String = "set_user"
const val SET_FEATURE_FLAG: String = "set_feature_flag"

/// Variables
const val ROOM = "room"
const val AUDIO_MUTED = "audioMuted"
const val VIDEO_MUTED = "videoMuted"
const val AUDIO_ONLY = "audioOnly"

const val USERNAME = "displayName"
const val EMAIL = "email"
const val AVATAR_URL = "avatarURL"

const val FLAG = "flag"
const val FLAG_VALUE = "flag_value"


/** JitsiMeetScreenPlugin */
public class JitsiMeetScreenPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME)
        channel?.setMethodCallHandler(this)
    }

    companion object {
        private var channel: MethodChannel? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
            channel?.setMethodCallHandler(JitsiMeetScreenPlugin())
        }

        fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
            channel?.invokeMethod(ON_WILL_JOIN, data)
        }

        fun onConferenceJoined(data: MutableMap<String, Any>?) {
            channel?.invokeMethod(ON_JOINED, data)
        }

        fun onConferenceTerminated(data: MutableMap<String, Any>?) {
            channel?.invokeMethod(ON_TERMINATED, data)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            JOIN_ROOM -> {
                join(call)
                result.success(null)
            }
        }
    }

    fun join(call: MethodCall) {
        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom("SurfTestRoom")
                .setWelcomePageEnabled(false)
        SurfJitsiMeetActivity.ktLaunch(activity, options.build())
    }

    /// ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
