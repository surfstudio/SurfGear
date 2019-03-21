import 'package:flutter_template/ui/base/action.dart';
import 'package:rxdart/rxdart.dart';

///WidgetModel - interface
///WM is logical representation of widget.
///полностью на action/stream | action/observable
abstract class WidgetModel {
  List<Subject> _subjects = List();
  List<Action> _actions = List();

  /// Method to create subject
  BehaviorSubject<T> createSubject<T>() {
    BehaviorSubject<T> bs = BehaviorSubject<T>();
    _subjects.add(bs);
    return bs;
  }

  ///Method to create an action.
  ///Ot automatically ad created action to list of actions.
  Action<T> createAction<T>() {
    Action<T> act = Action();
    _actions.add(act);
    return act;
  }

  /// Close streams of WM
  dispose() {
    _subjects.forEach((s) => s.close());
    _actions.forEach((a) => a.dispose());
  }
}
