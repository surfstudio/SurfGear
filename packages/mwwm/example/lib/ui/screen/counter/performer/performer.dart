import 'package:mwwm/mwwm.dart';

class Increment extends Change<int> {
  final int data;

  Increment(this.data);
}

class Decrement extends Change<int> {
  final int data;

  Decrement(this.data);
}

class Incrementor extends Broadcast<int, Increment> {
  int c = 0;

  @override
  Future<int> performInternal(Increment change) {
    c += change.data;
    var result = Future.value(c);
    return result;
  }
}
