
///Базовый класс контроллера отображения сообщений
abstract class MessageController {

  /// Show msg according to msgType
  /// msgType is defined on concrete widget(UI Layer)
  dynamic show({String msg, dynamic msgType});
}