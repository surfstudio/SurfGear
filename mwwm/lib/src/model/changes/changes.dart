/// Signal for [Model] to perform some action,
/// i.e. download or upload data.
/// 
/// `R` is a type of result which is returned after
/// performing the action.
abstract class Change<R> {
  @override
  String toString() {
    return '${runtimeType}';
  }
}
