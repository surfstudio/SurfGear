extension JsonExceptions on Map<String, dynamic> {
  T get<T>(String key, {T defaultValue}) {
    final dynamic value = this[key];

    if (value == null) return defaultValue;
    if (value is T) {
      return value;
    } else {
      throw Exception(
        'JsonExtension.get() Exception. ${value.runtimeType} is not $T',
      );
    }
  }
}
