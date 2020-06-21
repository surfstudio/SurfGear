# Application Development Standards at Surf

[Rules for text layout and documentation](rules.md)

## Common wiki structure

1. **Building Application Overview**
    1. Code requirements
        1. [Java Code Style][java_codestyle]
        1. [Koltin Code Style][kotlin_codestyle]
        1. [Dart Code Style](common/code_style.md)
    1. [Application architecture](common/arch.md)
    1. [Dependency injection](common/di.md)
    1. [Logging](common/logging.md)
    1. [Asynchronous interactions](common/async.md)
    1. [Testing](common/testing.md)

1. Layer [Model](model/model.md)
    1. [Interactor](model/interactor.md)
    1. [Work with file storage](model/file_storage.md)
    1. [Work with SharedPrefs](model/shared_preferences.md)

1. Layer UI
    1. [UI-layer structure](ui/structure.md)
        1. [WidgetModel](ui/widget_model.md)
        1. [Widget](ui/widget.md)
    1. [Navigation](common/navigation.md)
    1. [Screen creation](ui/create_screen.md)
    1. [Dialogs](ui/dialog.md)
    1. [Messages](common/message.md)

1. Best practics
    1. [CI](https://github.com/surfstudio/jenkins-pipeline-lib)
    1. [Flutter Flavors](best_practice/flavors/flavors_for_devs.md)
    1. [Reduce application size](best_practice/reduce_app_size.md)

1. [FAQ](faq/faq.md)

[java_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/java_codestyle.md

[kotlin_codestyle]:https://github.com/surfstudio/SurfAndroidStandard/blob/snapshot-0.4.0/docs/common/codestyle/kotlin_codestyle.md