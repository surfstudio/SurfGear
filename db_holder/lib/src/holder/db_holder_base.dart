import 'package:db_holder/src/manager/db_manager_base.dart';

/// Holder for working with manager.
/// Can be completed by mixin with different functional.
abstract class DbHolderBase {
  final DbManagerBase manager;

  DbHolderBase(this.manager);
}