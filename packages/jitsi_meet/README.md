#### [SurfGear](https://github.com/surfstudio/SurfGear)

# jitsi_meet

Plugin for jitsi meet service

# Discription 

This widget show native JitsiView

# Installation 

## Android

1. Add dependency to gradle:

``` gradle
implementation ('org.jitsi.react:jitsi-meet-sdk:2.8.2')
```
2. Change your MainActivity, FlutterActivity to FlutterFragmentActivity, and implement JitsiMeetActivityInterface

``` kotlin 
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
```
3. Add camera permission, request permission before show `JitsiMeetWidget`
``` xml
<uses-permission android:name="android.permission.CAMERA"/>
```

4. Set minSdkVersion and gradle version

``` gradle 
...
minSdkVersion 23
...
classpath 'com.android.tools.build:gradle:3.3.2'
...
```

## IOS

1. Set IOS vertion to 11
1. Add to info.plist
``` xml
	<key>io.flutter.embedded_views_preview</key>
	<string>YES</string>
```
3. Add permissions Camera and Microphone