[Main](../main.md)

# Project Structure

- / - project folder
- /res
    - /assets - graphic resource location directory
- /docs - project's documentation(technical doc, technical debt)
- /android - folder with native Android code
- /ios - folder with native iOS code
- /lib - Dart code , Flutter-application
    - /domain - Domain-layer
    - /interactor - Interactor-layer
        - /common - common classes used
        - /*some_interactor*/repository - repository for interactor
    - /ui - UI-layer
        - /app - package with the main application widget
        - /base - base classes for ui
        - /common - commonly used UI classes
        - /res - package with resources (colors.dart, text_styles.dart, etc.)
          - /strings - string resources
            - /common_strings.dart - strings that commmon for all projects
            - /strings.dart - strings that specific for project
        - /screen - packages of specific screens / widgets (widget + WM)
            - /*some_screen*/di - DI for screen
    - /util - utilities
- /test - tests
