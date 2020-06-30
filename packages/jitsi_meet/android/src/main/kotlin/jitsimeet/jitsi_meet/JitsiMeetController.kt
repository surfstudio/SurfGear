package jitsimeet.jitsi_meet

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import org.jitsi.meet.sdk.JitsiMeetUserInfo
import org.jitsi.meet.sdk.JitsiMeetView
import org.jitsi.meet.sdk.JitsiMeetViewListener
import java.net.URL
import kotlin.collections.HashMap


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

/// Controller to interact with dart part
class JitsiMeetController : PlatformView, MethodChannel.MethodCallHandler, JitsiMeetViewListener {
    val CHANNEL_NAME: String = "surf_jitsi_meet_";

    private var jitsiView: JitsiMeetView
    private var methodChannel: MethodChannel
    private var pluginContext: Context
    private var user: JitsiMeetUserInfo? = null
    private val features = HashMap<String, Boolean>()

    override fun getView(): android.view.View = jitsiView

    constructor(context: Context, messanger: BinaryMessenger, id: Int) {
        jitsiView = getJitsiView(context)
        pluginContext = context
        methodChannel = MethodChannel(messanger, "$CHANNEL_NAME$id")
        methodChannel.setMethodCallHandler(this)
    }

    override fun dispose() {
        jitsiView.leave()
        jitsiView.dispose()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
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

    /// Call terminated by user or error
    override fun onConferenceTerminated(data: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_TERMINATED, data)
    }

    /// User joined the room
    override fun onConferenceJoined(data: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_JOINED, data)
    }

    /// Room found/created but user not joined yet
    override fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_WILL_JOIN, data)
    }

    /// Leave room
    private fun leaveRoom(call: MethodCall) {
        jitsiView.leave()
    }

    /// Configuring JitsiMeetView
    private fun getJitsiView(context: Context): JitsiMeetView {
        val view = JitsiMeetView(context)
        view.listener = this
        return view
    }

    /// Join the room with parameters
    private fun joinRoom(call: MethodCall) {
        val params = call.arguments as Map<String, Any>
        val room = params[ROOM] as String
        val audioMuted = params[AUDIO_MUTED] as? Boolean
        val videoMuted = params[VIDEO_MUTED] as? Boolean
        val audioOnly = params[AUDIO_ONLY] as? Boolean

        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom(room)
                .setWelcomePageEnabled(false)
                .setUserInfo(user)
                /// disable picture in picture mode
                .setFeatureFlag("pip.enabled", false)
                /// disable chat, can't open keyboard
                .setFeatureFlag("chat.enabled", false)
                /// disable password creation, can't open keyboard
                .setFeatureFlag("meeting-password.enabled", false)

        if (audioMuted != null) options.setAudioMuted(audioMuted)
        if (videoMuted != null) options.setVideoMuted(videoMuted)
        if (audioOnly != null) options.setAudioOnly(audioOnly)

        features.forEach { (flag, value) -> options.setFeatureFlag(flag, value) }

        jitsiView.join(options.build())
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
}