abstract class MessageController<T> {
  /// Show msg according to [msgType]
  ///
  /// [msgType] is defined on concrete widget(UI Layer)
  void show({required String message, T msgType});
}
