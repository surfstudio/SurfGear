import 'package:mwwm/mwwm.dart';

class Increment extends Change<int, int> {
  Increment(int data) : super(data);
}

class Decrement extends Change<int, int> {
  Decrement(int data) : super(data);
}

class Incrementor extends Broadcast<Increment, int> {
  int c = 0;

  @override
  Future<int> performInternal(Increment change) {
    c += change.data;
    var result = Future.value(c);
    return result;
  }
}
