///  Http instance may have interceptor(s) by which you can intercept
///  requests or responses before they are handled.
///  [RQ] - type of request
///  [RS] - type of response
///  [E] - exception
abstract class Interceptor<RQ, RS, E> {
  /// The callback will be executed before the request is initiated.
  void onRequest(RQ options) => options;

  /// The callback will be executed on success.
  void onResponse(RS response) => response;

  /// The callback will be executed on error.
  void onError(E err) => err;
}
