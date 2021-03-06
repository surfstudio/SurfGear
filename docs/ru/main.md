# Стандарты разработки приложений в Surf

[Правила ведения и оформления](rules.md)

## Общая структура вики

1. **Общие сведения о построении приложения**
    1. Требования к коду
        1. [Java Code Style][java_codestyle]
        1. [Koltin Code Style][kotlin_codestyle]
        1. [Dart Code Style](common/code_style.md)
    1. [Архитектура приложения](common/arch.md)
    1. [Инъекция зависимостей](common/di.md)
    1. [Логирование](common/logging.md)
    1. [Асинхронные взаимодействия](common/async.md)
    1. [Тестирование](common/testing.md)

1. Слой [Model](model/model.md)
    1. [Interactor](model/interactor.md)
    2. [Работа с SharedPrefs](model/shared_preferences.md)

2. Cлой UI
    1. [Структура UI-слоя](ui/structure.md)
        1. [WidgetModel](ui/widget_model.md)
        2. [Widget](ui/widget.md)
    2. [Навигация](common/navigation.md)
    3. [Создание экрана](ui/create_screen.md)
    4. [Диалоги](ui/dialog.md)
    5. [Сообщения](common/message.md)

3. Лучшие практики
    1. [CI](https://github.com/surfstudio/jenkins-pipeline-lib)
    2. [Flutter Flavors](best_practice/flavors/flavors_for_devs.md)
    3. [Уменьшение размеров сборки](best_practice/reduce_app_size.md)

4. [FAQ](faq/faq.md)

[java_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/java_codestyle.md

[kotlin_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/kotlin_codestyle.md