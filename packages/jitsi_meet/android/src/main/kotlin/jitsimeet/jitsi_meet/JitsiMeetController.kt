package jitsimeet.jitsi_meet

import android.content.Context
import android.os.Bundle
import com.dropbox.core.v2.sharing.UserInfo
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
import java.util.*


/// Methods
const val JOIN_ROOM: String = "join_room"
const val LEAVE_ROOM: String = "leave_room"
const val ON_JOINED: String = "on_joined"
const val ON_WILL_JOIN: String = "on_will_join"
const val ON_TERMINATED: String = "on_terminated"
const val SET_USER: String = "set_user"

/// Variables
const val ROOM = "room"
const val AUDIO_MUTED = "audioMuted"
const val VIDEO_MUTED = "videoMuted"
const val AUDIO_ONLY = "audioOnly"

const val USERNAME = "displayName"
const val EMAIL = "email"
const val AVATAR_URL = "avatarURL"

class JitsiMeetController : PlatformView, MethodChannel.MethodCallHandler, JitsiMeetViewListener {
    val CHANNEL_NAME: String = "surf_jitsi_meet_";

    private var jitsiView: JitsiMeetView
    private var methodChannel: MethodChannel
    private var pluginContext: Context
    private var user: JitsiMeetUserInfo? = null

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
            else -> result.notImplemented()
        }
    }

    /// Call terminated by user or error
    override fun onConferenceTerminated(p0: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_TERMINATED, p0)
    }

    /// User joined the room
    override fun onConferenceJoined(p0: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_JOINED, p0)
    }

    /// Room found/created but user not joined yet
    override fun onConferenceWillJoin(p0: MutableMap<String, Any>?) {
        methodChannel.invokeMethod(ON_WILL_JOIN, p0)
    }


    private fun getJitsiView(context: Context): JitsiMeetView {
        val view = JitsiMeetView(context)
        view.listener = this
        return view
    }

    private fun leaveRoom(call: MethodCall) {
        jitsiView.leave()
    }

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
                .setFeatureFlag("pip.enabled", false)

        if (audioMuted != null) options.setAudioMuted(audioMuted)
        if (videoMuted != null) options.setVideoMuted(videoMuted)
        if (audioOnly != null) options.setAudioOnly(audioOnly)

        jitsiView.join(options.build())
    }

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
}