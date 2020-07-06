extension FutureExtensions<T> on Future<T> {
  Future<T> catchType<E>(
    Function(E error) onError, {
    bool Function(E error) test,
  }) {
    return catchError(
      (e) => onError(e as E),
      test: (e) => e is E && (test?.call(e) ?? true),
    );
  }
}
