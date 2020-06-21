[Главная](../main.md)

# Структура проекта | Project Structure

- / - папка проекта
- /res
    - /assets - директория расположения графических ресурсов
- /docs - документация проекта(тех.док, тех.долг)
- /android - папка, содержащая нативный код для Android
- /ios - аналогично для iOS
- /lib - код на Dart, Flutter-приложение
    - /domain - Domain -слой
    - /interactor - Interactor-слой
        - /common - общееиспользуемые классы
        - /*some_interactor*/repository - репозиторий для интерактора
    - /ui - UI-слой
        - /app - пакет с главным виджетом приложения
        - /base - базовые классы для ui
        - /common - общеиспользуемые классы UI
        - /res - пакет для ресурсов(colors.dart, text_styles.dart, etc.)
          - /strings - строковые ресурсы
            - /common_strings.dart - строки, общие для всех проектов
            - /strings.dart - строки, специфичные для проекта
        - /screen - пакеты конкретных экранов/виджетов(сам виджет + WM)
            - /*some_screen*/di - DI для экрана
    - /util - утилиты
- /test - тесты
