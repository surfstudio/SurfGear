import 'package:flutter/widgets.dart';

/// Глобальное хранилище контекста
class ContextHolderStorage {
  BuildContext context;

  static final ContextHolderStorage _singleton =
      ContextHolderStorage._internal();

  factory ContextHolderStorage() => _singleton;

  ContextHolderStorage._internal();
}
