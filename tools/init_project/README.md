# init project

Creating a project template.

## Описание

Утилита создаёт проект на основе шаблона.

### FAQ
Обязательные опции:

    -n, --name      -   Имя шаблонного проекта.

    -r, --remote    -   Указать репозиторий для загрузки template.
    
    -i, --orgId     -   Указать идентификатор организации.

Необязательные опции:

    -o, --out       -   Путь для шаблонного проекта, по умолчанию принимает директорию утилиты.

    -b, --branch    -   Ветка для зависимостей flutter-standard, по умолчанию "Dev".

    -h, --help      -   Показать help.

#### Exception

    Exception: Enter project name.  -   Не указано имя проекта.

    Exception: Enter the URL of the remote repository.  -   Не указан путь до репозитория.
    
    Exception: Enter organization identifier.  -  Укажите идентификатор организации.

    Exception: git not found, install git of https://git-scm.com -  Не установлен GIT.