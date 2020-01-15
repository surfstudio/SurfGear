Стандарты разработки приложений в Surf
=============================

[Правила ведения и оформления](rules.md)

Общая структура вики
--------------------

1. **Работа с репозиторием**
    1. [Git flow в репозитории](repo_guides/gitflow.md)
    2. [Синхронизация модулей](repo_guides/sync.md)
1. **Общие сведения о построении приложения**
    1. [Требования к коду](todo)
        1. [Java Code Style][java_codestyle]
        1. [Koltin Code Style][kotlin_codestyle]
        1. [Dart Code Style](common/code_style.md)
    1. [Архитектура приложения](common/arch.md)
    1. [Инъекция зависимостей](common/di.md)
    1. [Логгирование](common/logging.md)
    1. [Асинхронные взаимодействия](common/async.md) 
    1. [Пуш-уведомления](../push/README.md)
    1. [Тестирование](common/testing.md)

1. [**Слой Model**](todo)
    1. [Interactor](common/interactor.md)
    1. [Проверка соединения](todo) 
    1. [Работа с файловым хранилищем](common/file_storage.md)
    1. [Работа с SharedPrefs](common/shared_preferences.md)

1. [UI слой]()
    1. [Структура UI-слоя](ui/structure.md)
        1. [WidgetModel](ui/widget_model.md)
        1. [Widget](ui/widget.md)
    1. [Навигация](сommon/navigation.md)
    1. [Создание экрана](ui/create_screen.md)
    1. [Диалоги](todo)
    1. [Сообщения](common/message.md)

1. [Инициализация приложения](common/init_project.md)
    1. [Подготовка проекта к выгрузке в fabric](todo link to android)
    1. [Сборка и выгрузка проекта](common/build.md)
    1. [Continious Delivery](common/cd.md)
    1. [Подключение зависимостей в проект](common/dependencies.md)

1. [Лучшие практики](best_practice/best_practice.md)
    1. [Поиск утечек](best_practice/memory_leak.md)
    2. [CI](https://github.com/surfstudio/jenkins-pipeline-lib)
    3. [Настройки и плагины для Android Studio](best_practice/android_studio_settings.md) 
    1. [Flutter Flavors](best_practices/flavors_for_devs.md)
    
1. [FAQ](faq/faq.md)

[java_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/java_codestyle.md

[kotlin_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/kotlin_codestyle.md