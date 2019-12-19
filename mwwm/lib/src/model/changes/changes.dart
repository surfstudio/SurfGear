/// An abstract change of model
/// D  - type of data inside
/// R - type of expected result
abstract class Change<D, R> {
  final D data;

  Change(this.data);

  @override
  String toString() {
    return "${this.runtimeType} with ${data}";
  }
}


