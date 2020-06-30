/// Holder for working with manager.
/// Can be completed by mixin with different functional.
abstract class DbHolder {
  final DbManager manager;

  DbHolder(this.manager);
}

/// Interface for managing manager work;
abstract class DbManager {
  /// Open manager.
  void openDb();

  /// Close manager.
  void closeDb();
}
