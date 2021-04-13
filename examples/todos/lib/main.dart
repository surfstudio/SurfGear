import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/ui/app/app.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppProvider(),
      child: App(),
    ),
  );
}
