import 'package:counter/data/counter/storage/shared_prefs.dart';
import 'package:counter/data/counter/repository/counter_repository.dart';
import 'package:counter/ui/app.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => SharedPrefs(),
        ),
        Provider(
          create: (context) => CounterRepository(
            context.read<SharedPrefs>(),
          ),
        ),
      ],
      child: App(),
    ),
  );
}
