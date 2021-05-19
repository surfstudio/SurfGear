import 'package:cat_facts/config/url_config.dart';
import 'package:cat_facts/interactor/facts/facts_interactor.dart';
import 'package:cat_facts/interactor/theme/theme_interactor.dart';
import 'package:cat_facts/repository/api_client.dart';
import 'package:cat_facts/repository/facts_repository.dart';
import 'package:cat_facts/ui/app/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AppDependencies extends StatelessWidget {
  final App app;

  const AppDependencies({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final http = Client();
    final apiClient = ApiClient(UrlConfig.baseUrl, http);
    final factRepository = FactsRepository(apiClient);
    final themeInteractor = ThemeInteractor();
    final factsInteractor = FactsInteractor(factRepository);

    return MultiProvider(
      providers: [
        Provider<ThemeInteractor>(create: (_) => themeInteractor),
        Provider<FactsInteractor>(create: (_) => factsInteractor),
      ],
      child: app,
    );
  }
}
