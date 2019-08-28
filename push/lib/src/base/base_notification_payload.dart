/// Базовый класс данных нотификации
abstract class BaseNotificationPayload {
  String title;
  String body;

  /// Исходные данные сообщения
  Map<String, dynamic> messageData;

  /// извлечение данных
  void extractDataFromMap(Map<String, dynamic> map) {
    messageData = Map<String, dynamic>.from(map);
    title = map['title'];
    body = map['body'];
  }
}
