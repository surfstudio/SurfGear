package ru.surf.jitsi_meet_screen

import android.content.Context
import android.content.Intent
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions

typealias ClickHandler = (MutableMap<String, Any>) -> Unit

class SurfJitsiMeetActivity : JitsiMeetActivity() {

    override fun join(options: JitsiMeetConferenceOptions?) {
        JitsiMeetScreenPlugin.jitsiMeetView = jitsiView
        super.join(options)
    }

    override fun onConferenceWillJoin(data: MutableMap<String, Any>) {
        onConferenceWillJoinCallback?.invoke(data)
        super.onConferenceWillJoin(data)
    }

    override fun onConferenceJoined(data: MutableMap<String, Any>) {
        onConferenceJoinedCallback?.invoke(data)
        super.onConferenceJoined(data)
    }

    override fun onConferenceTerminated(data: MutableMap<String, Any>) {
        onConferenceTerminatedCallback?.invoke(data)
        super.onConferenceTerminated(data)
    }

    companion object {
        fun ktLaunch(context: Context, options: JitsiMeetConferenceOptions) {
            val intent = Intent(context, SurfJitsiMeetActivity::class.java)
            intent.action = "org.jitsi.meet.CONFERENCE"
            intent.putExtra("JitsiMeetConferenceOptions", options)
            context.startActivity(intent)
        }

        var onConferenceWillJoinCallback: ClickHandler? = null
        var onConferenceJoinedCallback: ClickHandler? = null
        var onConferenceTerminatedCallback: ClickHandler? = null
    }
}