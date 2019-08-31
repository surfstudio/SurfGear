Стандарты разработки приложений в Surf
=============================

[Правила ведения и оформления](rules.md)

Общая структура вики
--------------------

1. [Git flow в репозитории](git/flow.md)
1. **Общие сведения о построении приложения**
    1. [Требования к коду](todo)
        1. [Java Code Style](todo)
        1. [Koltin Code Style](todod)
        1. [Dart Code Style](todo)
    1. [Архитектура приложения](common/arch.md)
    1. [Инъекция зависимостей](common/di.md)
    1. [Логгирование](todo) //todo
    1. [Асинхронные взаимодействия](todo)
    1. [Пуш-уведомления](../push/README.md) //todo

1. [**Слой Model**](todo)
    1. [Interactor](todo)
    1. [Проверка соединения](todo)
    1. [Работа с Broadcast](todo)
    1. [Работа с файловым хранилищем](todo)
    1. [Работа с SharedPrefs](todo) 

1. [UI слой]()
    1. [Структура UI-слоя](ui/structure.md)
        1. [WidgetModel](todo)
        1. [Widget](todo)
    1. [Навигация](сommon/navigation.md)
    1. [Создание экрана](ui/create_screen.md)
    1. [Диалоги](todo)

1. [Инициализация приложения](common/init_project.md)
    1. [Подготовка проекта к выгрузке в fabric](todo link to android)
    1. [Сборка и выгрузка проекта](common/build.md)
    1. [Continious Delivery](common/cd.md)
    1. [Подключение зависимостей в проект](common/dependencies.md)



1. [Лучшие практики](best_practice/best_practice.md)
    1. [Поиск утечек](best_practice/memory_leak.md)
    2. [CI](https://github.com/surfstudio/jenkins-pipeline-lib)
    3. [Настройки и плагины для Android Studio](best_practice/android_studio_settings.md)