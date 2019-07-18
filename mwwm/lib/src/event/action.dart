import 'dart:async';

import 'package:mwwm/src/event/event.dart';
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
///     onTap: someAction.accept,
///   )
///
///   someAction.action.listen(doSomething);
/// ```
class Action<T> implements Event<T> {
  PublishSubject<T> _actionSubject = PublishSubject();
  final void Function(T data) onChanged;
  T value;

  @override
  Observable<T> get stream => _actionSubject.stream;

  Subject<T> get subject => _actionSubject;

  Action([void Function(T data) onChanged])
      : this.onChanged = onChanged ?? ((a) {});

  @override
  Future<void> accept([T data]) async {
    value = data;
    _actionSubject.add(data);
    onChanged(value);
    return _actionSubject.stream.first.wrapped;
  }

  call([T data]) => accept(data);

  /// Close stream
  void dispose() {
    _actionSubject.close();
  }
}
