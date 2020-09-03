class Result<T> {
  final T data;
  final Exception error;

  Result(this.data, {this.error});

  factory Result.fromError(Exception e) => Result(null, error: e);
}
