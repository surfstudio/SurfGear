# Connection check

[Main](../main.md)

# Connectivity

Checking your network connection is very important for almost any application. 
There are cases when you need to check the application’s connection to the Internet or to a wi-fi network.
If the user has an Internet connection, the application continues to work,
for example, receiving data via the Internet, etc., and if the user does not have an Internet connection,
The application shows a warning window that you need to turn on wi-fi or cellular.

To test the Internet connection in studio practice, a [Connectivity](https://pub.dev/packages/connectivity) plugin is used. 
This plugin allows Flutter applications to detect network connectivity and configure
yourself accordingly. He knows the difference between cellular and wi-fi.
This plugin works for iOS and Android.

You can read more about this in [article](https://medium.com/flutter-community/build-a-network-sensitive-ui-in-flutter-using-provider-and-connectivity-ddad140c9ff8) on the Medium.

# Usage

```dart
import 'package:connectivity/connectivity.dart';

var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  print("Connected to Mobile Network");
} else if (connectivityResult == ConnectivityResult.wifi) {
  print("Connected to WiFi");
} else {
  print("Unable to connect. Please Check Internet Connection");
}
```

You can also listen to network status changes by subscribing to the stream provided by the plug-in.
Thus, you can find out when the status of the network has changed.

```dart
initState() {
  subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    print("Connection Status has Changed");
  });
}

dispose() {
  subscription.cancel();
}
```