# jitsi_meet_screen

Plugin to show JitsiMeetView as new native screen

# Installation 

## Android
1. Add camera permission, request permission before show `JitsiMeetWidget`
``` xml
<uses-permission android:name="android.permission.CAMERA"/>
```

2. Set minSdkVersion and gradle version

``` gradle 
...
minSdkVersion 23
...
classpath 'com.android.tools.build:gradle:3.3.2'
...
```
[Dropbox integration](https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-android-sdk#dropbox-integration)
## IOS

1. Set IOS version to 11
1. Add permissions Camera and Microphone

[Dropbox integration](https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-ios-sdk#dropbox-integration)
