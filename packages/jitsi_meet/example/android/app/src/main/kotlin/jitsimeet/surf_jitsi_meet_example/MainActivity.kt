package jitsimeet.surf_jitsi_meet_example

import android.content.Intent
import com.facebook.react.modules.core.PermissionListener
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jitsi.meet.sdk.JitsiMeetActivityDelegate
import org.jitsi.meet.sdk.JitsiMeetActivityInterface

class MainActivity : FlutterFragmentActivity(), JitsiMeetActivityInterface {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onDestroy() {
        flutterEngine?.platformViewsController?.onFlutterViewDestroyed()
        JitsiMeetActivityDelegate.onHostDestroy(this)
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        JitsiMeetActivityDelegate.onNewIntent(intent)
    }

    override fun requestPermissions(p0: Array<out String>?, p1: Int, p2: PermissionListener?) {
    }
}
