import 'package:rxdart/rxdart.dart';

///Интерфейс модели
///полностью на action/stream | action/observable
abstract class ViewModel {

  List<Subject> _subjects = List();

  BehaviorSubject<T> createSubject<T>() {
    BehaviorSubject<T> bs = BehaviorSubject<T>();
    _subjects.add(bs);
    return bs;
  }

  dispose() {
    _subjects.forEach(
            (s) => s.close()
    );
  }

}