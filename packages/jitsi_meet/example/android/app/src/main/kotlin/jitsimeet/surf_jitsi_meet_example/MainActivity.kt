package jitsimeet.surf_jitsi_meet_example

import com.facebook.react.modules.core.PermissionListener
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jitsi.meet.sdk.JitsiMeetActivityInterface

class MainActivity : FlutterFragmentActivity(), JitsiMeetActivityInterface {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onDestroy() {
        flutterEngine?.platformViewsController?.onFlutterViewDestroyed()
        super.onDestroy()
    }

    override fun requestPermissions(p0: Array<out String>?, p1: Int, p2: PermissionListener?) {
    }
}
