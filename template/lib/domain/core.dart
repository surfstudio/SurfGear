/// Примитивные типы данных

/// Пара
class Pair<T1, T2> {
  Pair(this.first, this.second);

  final T1 first;
  final T2 second;
}

/// Объект для передачи трех значений
class Triple<T1, T2, T3> {
  Triple(this.first, this.second, this.third);

  final T1 first;
  final T2 second;
  final T3 third;
}
