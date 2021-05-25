import 'package:counter/data/counter/repository/counter_repository.dart';
import 'package:counter/data/counter/storage/shared_prefs.dart';
import 'package:counter/ui/app.dart';
import 'package:counter/ui/counter_screen/counter_wm.dart';
import 'package:counter/ui/counter_screen/exceptions/default_error_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
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
        ChangeNotifierProvider<CounterWidgetModel>(
          create: (context) => CounterWidgetModel(
            WidgetModelDependencies(
              errorHandler: DefaultErrorHandler(),
            ),
            context.read<CounterRepository>(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
