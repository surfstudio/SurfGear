import 'package:rxdart/rxdart.dart';

/// Action
/// It's wrapper over an action on screen.
/// It may be a tap on button, text changes, focus changes and so on.
///
/// It is **reactive**.
///
/// Usage:
/// ```
///   SomeWidget(
///     onTap: someAction.doAction,
///   )
///
///   someAction.action.listen(doSomething);
/// ```
class Action<T> {
  PublishSubject<T> _actionSubject = PublishSubject();

  Observable<T> get action => _actionSubject.stream;

  void doAction({T data}) {
    _actionSubject.add(data);
  }

  /// Close stream
  dispose() {
    _actionSubject.close();
  }
}
