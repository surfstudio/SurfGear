///Ответ сервера
class Response {
  final dynamic body;
  final int statusCode;

  Response(
    this.body,
    this.statusCode,
  );

  @override
  String toString() {
    return body.toString();
  }
}
