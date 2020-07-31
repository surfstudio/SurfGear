/// Holder for working with manager.
/// Can be completed by mixin with different functional.
abstract class DbHolder {
  DbHolder(this.manager);

  final DbManager manager;
}

/// Interface for managing manager work;
abstract class DbManager {
  /// Open manager.
  void openDb();

  /// Close manager.
  void closeDb();
}
