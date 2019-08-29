import 'dart:convert';

///Ответ сервера
class Response<T> {
  final T bodyRaw;
  final int statusCode;

  Map<String, dynamic> get body => bodyRaw is String
      ? jsonDecode(bodyRaw as String)
      : bodyRaw as Map<String, dynamic>;

  Response(
    this.bodyRaw,
    this.statusCode,
  );

  @override
  String toString() {
    return bodyRaw.toString();
  }
}
