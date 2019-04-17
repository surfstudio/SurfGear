///Ответ сервера
class Response {
  final Map<String, dynamic> body;
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
