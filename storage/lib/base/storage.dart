/// Key-value storage
abstract class Storage<K, V> {

  /// Get object or null if it doesn't exist
  Future<V> get(K key);

  /// Save object or rewrite it if there is the same key
  /// Descendants can change this logic.
  void put(K key, V value);

  /// Remove object
  void remove(K key);

  /// Clear storage
  void clear();
}