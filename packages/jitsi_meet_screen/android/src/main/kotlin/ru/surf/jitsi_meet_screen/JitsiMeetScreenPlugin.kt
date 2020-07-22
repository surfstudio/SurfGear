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
import org.jitsi.meet.sdk.JitsiMeetUserInfo
import org.jitsi.meet.sdk.JitsiMeetView
import java.net.URL

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
    private lateinit var channel: MethodChannel
    private var user: JitsiMeetUserInfo? = null
    private val features = HashMap<String, Boolean>()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    constructor() {
        SurfJitsiMeetActivity.onConferenceJoinedCallback = {data -> onConferenceJoined(data)}
        SurfJitsiMeetActivity.onConferenceWillJoinCallback = {data -> onConferenceWillJoin(data)}
        SurfJitsiMeetActivity.onConferenceTerminatedCallback = {data -> onConferenceTerminated(data)}
    }

    constructor(channel: MethodChannel) : this() {
        this.channel
    }

    companion object {
        var jitsiMeetView: JitsiMeetView? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
            channel.setMethodCallHandler(JitsiMeetScreenPlugin(channel))
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            JOIN_ROOM -> {
                joinRoom(call)
                result.success(null)
            }
            LEAVE_ROOM -> {
                leaveRoom(call)
                result.success(null)
            }
            SET_USER -> {
                setUser(call)
                result.success(null)
            }
            SET_FEATURE_FLAG -> {
                setFeatureFlag(call)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    fun joinRoom(call: MethodCall) {
        val params = call.arguments as Map<String, Any>
        val room = params[ROOM] as String
        val audioMuted = params[AUDIO_MUTED] as? Boolean
        val videoMuted = params[VIDEO_MUTED] as? Boolean
        val audioOnly = params[AUDIO_ONLY] as? Boolean

        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom(room)
                .setUserInfo(user)

        if (audioMuted != null) options.setAudioMuted(audioMuted)
        if (videoMuted != null) options.setVideoMuted(videoMuted)
        if (audioOnly != null) options.setAudioOnly(audioOnly)

        features.forEach { (flag, value) -> options.setFeatureFlag(flag, value) }

        SurfJitsiMeetActivity.ktLaunch(activity, options.build())
    }

    /// Set user information
    private fun setUser(call: MethodCall) {
        val params = call.arguments as Map<String, Any>
        user = JitsiMeetUserInfo()
        user!!.displayName = params[USERNAME] as? String
        user!!.email = params[EMAIL] as? String
        val avatarUrl = params[AVATAR_URL] as? String
        if (avatarUrl != null) {
            user!!.avatar = URL(avatarUrl)
        }
    }

    /// set enabled state of feature
    private fun setFeatureFlag(call: MethodCall) {
        val params = call.arguments as Map<String, Any>
        val feature = params[FLAG] as? String
        val value = params[FLAG_VALUE] as? Boolean

        if (feature != null && value != null) {
            features[feature] = value
        }
    }

    /// Leave room
    private fun leaveRoom(call: MethodCall) {
        jitsiMeetView?.leave()
    }

    fun onConferenceWillJoin(data: MutableMap<String, Any>) {
        channel.invokeMethod(ON_WILL_JOIN, data)
    }

    fun onConferenceJoined(data: MutableMap<String, Any>){
        channel.invokeMethod(ON_JOINED, data)
    }

    fun onConferenceTerminated(data: MutableMap<String, Any>) {
        channel.invokeMethod(ON_TERMINATED, data)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /// ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
