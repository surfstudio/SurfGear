import 'package:flutter/widgets.dart';

/// Глобальное хранилище контекста
class ContextHolderStorage {
  BuildContext context;

  static final ContextHolderStorage _instance =
      ContextHolderStorage._internal();

  factory ContextHolderStorage() => _instance;

  ContextHolderStorage._internal();
}
