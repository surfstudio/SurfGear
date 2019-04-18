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
  final void Function(T data) onChanged;
  T value;

  Action([void Function(T data) onChanged])
      : this.onChanged = onChanged ?? ((a) {});

  Observable<T> get action => _actionSubject.stream;

  Future<void> accept({T data}) async {
    value = data;
    _actionSubject.add(data);
    onChanged(value);
    return _actionSubject.stream.first.wrapped;
  }

  call([T data]) => accept(data: data);

  /// Close stream
  dispose() {
    _actionSubject.close();
  }
}
