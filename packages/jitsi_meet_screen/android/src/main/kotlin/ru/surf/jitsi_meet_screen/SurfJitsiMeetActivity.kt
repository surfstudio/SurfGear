package ru.surf.jitsi_meet_screen

import android.content.Context
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions

class SurfJitsiMeetActivity: JitsiMeetActivity() {
    override fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        JitsiMeetScreenPlugin.onConferenceWillJoin(data)
        super.onConferenceWillJoin(data)
    }

    override fun onConferenceJoined(data: MutableMap<String, Any>?) {
        JitsiMeetScreenPlugin.onConferenceJoined(data)
        super.onConferenceJoined(data)
    }

    override fun onConferenceTerminated(data: MutableMap<String, Any>?) {
        JitsiMeetScreenPlugin.onConferenceTerminated(data)
        super.onConferenceTerminated(data)
    }

    companion object {
        fun ktLaunch(context: Context, options: JitsiMeetConferenceOptions) {
            launch(context, options)
        }
    }
}