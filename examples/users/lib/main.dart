import 'package:example2/data/repo/users_repo.dart';
import 'package:example2/data/storage/api_client.dart';
import 'package:example2/ui/app.dart';
import 'package:example2/ui/users_screen/exceptions/default_error_handler.dart';
import 'package:example2/ui/users_screen/user_screen_wm.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ApiClient(httpClient: http.Client()),
        ),
        Provider(
          create: (context) => UsersRepo(apiClient: context.read<ApiClient>()),
        ),
        ChangeNotifierProvider<UserScreenWidgetModel>(
          create: (context) => UserScreenWidgetModel(
            WidgetModelDependencies(errorHandler: DefaultErrorHandler()),
            context.read<UsersRepo>(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
