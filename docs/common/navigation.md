# Навигация

[Главная](../main.md)

Навигация осуществляется при помощи виджета Navigator.

Общий алгоритм работы с навигатором очень похож на работу Intent из Android.
Необходимо указать какой виджет открывать, выбрать тип роута и если необходимо, передать параметры.
Для более детального изучения навигации во Flutter можно обратиться к [официальной документации](https://flutter.dev/docs/cookbook/navigation).

# Пример использования в студийном проекте

```dart
class InputNumberRoute extends CupertinoPageRoute {
  InputNumberRoute() : super(builder: (ctx) => InputNumberScreen());
}

class SomeWidgetModel{
   void _goToNextScreen() {
      _navigator.push(InputNumberRoute());
    }
}
```

Примечание. 
В студийной практике навигатор используется только в сущности WidgetModel.