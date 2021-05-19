import 'package:cat_facts/interactor/facts/facts_interactor.dart';
import 'package:cat_facts/interactor/theme/theme_interactor.dart';
import 'package:cat_facts/ui/app/app.dart';
import 'package:cat_facts/ui/app/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

/// Обертка для мокирования зависимостей
class GoldenAppWrapper extends AppDependencies {
  final MockThemeInteractor? themeInteractor;
  final MockFactsInteractor? factsInteractor;

  const GoldenAppWrapper({
    Key? key,
    required App app,
    this.themeInteractor,
    this.factsInteractor,
  }) : super(
          key: key,
          app: app,
        );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeInteractor>(
          create: (_) => themeInteractor ?? ThemeInteractor(),
        ),
        Provider<FactsInteractor>(
          create: (_) => factsInteractor ?? MockFactsInteractor(),
        ),
      ],
      child: app,
    );
  }
}

class MockThemeInteractor extends Mock implements ThemeInteractor {}

class MockFactsInteractor extends Mock implements FactsInteractor {}
