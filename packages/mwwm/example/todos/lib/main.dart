import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/storage/app_storage.dart';
import 'package:todos/ui/app/app.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppStorage(),
      child: App(),
    ),
  );
}
