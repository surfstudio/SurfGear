import 'package:context_holder/context_holder.dart';
import 'package:flutter/widgets.dart';

/// Получение контекста через подмешивание к виджету
mixin ContextHolderStateMixin<T extends StatefulWidget> on State<T> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    ContextHolderStorage().context = context;
  }
}
