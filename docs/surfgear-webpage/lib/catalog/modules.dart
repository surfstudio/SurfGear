enum ModuleStatus { surf, alpha, beta, release }

class Module {
  final String name;
  final String link;
  final ModuleStatus status;
  final String description;

  Module({
    this.name,
    this.link,
    this.status,
    this.description,
  });
}

final modules = <Module>[
  Module(
    name: 'analytics',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/analytics',
    status: ModuleStatus.surf,
    description: 'Единый интерфейс для работы с сервисами аналитики',
  ),
  Module(
    name: 'auto_reload',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/auto_reload',
    status: ModuleStatus.surf,
    description:
        'Библиотека, позволяющая выполнять какие-либо действия с заданной периодичностью',
  ),
  Module(
    name: 'background_worker',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/background_worker',
    status: ModuleStatus.surf,
    description: 'Хелпер для работы с изолятами',
  ),
  Module(
    name: 'bottom_navigation_bar',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/bottom_navigation_bar',
    status: ModuleStatus.surf,
    description: 'Виджет с кнопками навигации между экранами',
  ),
  Module(
    name: 'bottom_sheet',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/bottom_sheet',
    status: ModuleStatus.surf,
    description: 'Виджет раскрывающейся шторки с возможностью прокрутки',
  ),
  Module(
    name: 'build_context_holder',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/build_context_holder',
    status: ModuleStatus.surf,
    description: 'Хранитель контекста последнего созданного виджета',
  ),
  Module(
    name: 'datalist',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/datalist',
    status: ModuleStatus.surf,
    description: 'Список, упрощающий работу с пагинацией',
  ),
  Module(
    name: 'db_holder',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/db_holder',
    status: ModuleStatus.surf,
    description: 'Интерфейс для работы с базами данных',
  ),
  Module(
    name: 'event_filter',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/event_filter',
    status: ModuleStatus.surf,
    description: 'Интерфейс для фильтрации событий',
  ),
  Module(
    name: 'geolocation',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/geolocation',
    status: ModuleStatus.surf,
    description: 'Библиотека для работы с геопозицией',
  ),
  Module(
    name: 'injector',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/injector',
    status: ModuleStatus.surf,
    description: 'Инструмент для внедрения зависимостей',
  ),
  Module(
    name: 'logger',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/logger',
    status: ModuleStatus.surf,
    description: 'Библиотека для логирования',
  ),
  Module(
    name: 'mixed_list',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/mixed_list',
    status: ModuleStatus.surf,
    description: 'Виджет для отображения элементов разного типа в виде списка',
  ),
  Module(
    name: 'mwwm',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/mwwm',
    status: ModuleStatus.alpha,
    description: 'Библиотека с компонентами архитектуры MWWM',
  ),
  Module(
    name: 'network',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/network',
    status: ModuleStatus.surf,
    description: 'Библиотека для работы с запросами к серверу',
  ),
  Module(
    name: 'network_cache',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/network_cache',
    status: ModuleStatus.surf,
    description: 'Утилита для кеширования ответов от сервера',
  ),
  Module(
    name: 'permission',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/permission',
    status: ModuleStatus.surf,
    description:
        'Библиотека для запроса доступа к различным функциям устройства (геолокация, список контактов и т.д.)',
  ),
  Module(
    name: 'push',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/push',
    status: ModuleStatus.surf,
    description: 'Библиотека для работы с уведомлениями',
  ),
  Module(
    name: 'relation',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/relation',
    status: ModuleStatus.surf,
    description: 'Связь Widget—Wm, используемая в Surf',
  ),
  Module(
    name: 'storage',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/storage',
    status: ModuleStatus.surf,
    description: 'Интерфейс для работы с хранилищами',
  ),
  Module(
    name: 'surf_mwwm',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/surf_mwwm',
    status: ModuleStatus.surf,
    description:
        'Пакет, объединяющий в себе mwwm, injector, relation и различные методы расширения',
  ),
  Module(
    name: 'surf_util',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/surf_util',
    status: ModuleStatus.surf,
    description: 'Набор утилит',
  ),
  Module(
    name: 'swipe_refresh',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/swipe_refresh',
    status: ModuleStatus.surf,
    description: 'Виджет для работы с pull-to-refresh',
  ),
  Module(
    name: 'tabnavigator',
    link: 'https://github.com/surfstudio/SurfGear/tree/dev/packages/tabnavigator',
    status: ModuleStatus.surf,
    description: 'Библиотека для навигации между табами главного экрана',
  ),
];
