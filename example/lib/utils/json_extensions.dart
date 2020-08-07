extension JsonExtensions on Map<String, dynamic> {
  /// Return [T] value from json by [key]
  T get<T>(String key, {T defaultValue}) {
    if (key == null) return defaultValue;

    final dynamic value = this[key];
    if (value == null) return defaultValue;

    if (value is T) {
      return value;
    } else {
      throw Exception('Type: $T is not value type: ${value.runtimeType}');
    }
  }
}
