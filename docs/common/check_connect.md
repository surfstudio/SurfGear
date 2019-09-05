# Проверка соединения

[Главная](../main.md)

# Connectivity

Проверка сетевого подключения очень важна практически для любого приложения. 
Встречаются кейсы, когда необходимо проверить подключение приложения к Интернету или к сети wi-fi.
Если у пользователя есть подключение к Интернету,приложение продолжает работу,
например, получать данные через Интернет и т.д, и если у пользователя нет подключения к Интернету,
приложение показывает окно с предупреждением, что нужно включить wi-fi или мобильный данные.

Для проверки подключения к интернету в студийной практике используется плагин [Connectivity](https://pub.dev/packages/connectivity)
Этот плагин позволяет приложениям Flutter обнаруживать подключение к сети и настраивать
себя соответственно. Он может отличить сотовое соединение от wi-fi.
Этот плагин работает для iOS и Android.

Более подробно об этом можно почитать в [статье](https://medium.com/flutter-community/build-a-network-sensitive-ui-in-flutter-using-provider-and-connectivity-ddad140c9ff8) на Medium.

# Использование

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

Так-же можно слушать изменения состояния сети, подписавшись на поток, предоставляемый подключаемым модулем.
Таким образом, можно узнать когда состояние сети изменилось.

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