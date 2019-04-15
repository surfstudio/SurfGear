/// Interface for mapping
abstract class Transformable<T> {
  T transform();
}

/// Interface for creating from [T]
abstract class Creator<T> {
  Creator from(T t);
}
