import 'package:flutter/widgets.dart';
import 'package:surf_controllers/surf_controllers.dart';

/// Dialog widget builder
class DialogBuilder<T extends DialogData> {
  DialogBuilder(this.builder);

  final Widget Function(BuildContext context, {required T data}) builder;

  // ignore: avoid-returning-widgets
  Widget call(BuildContext context, {required T data}) =>
      builder(context, data: data);
}

/// Register dialogs
mixin DialogOwner {
  Map<dynamic, DialogBuilder> get registeredDialogs;
}
