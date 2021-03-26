import 'package:cat_facts/storage/app/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:cat_facts/ui/app/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppStorage(),
      child: App(),
    ),
  );
}
