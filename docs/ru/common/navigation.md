[Главная](../main.md)

# Навигация

Навигация осуществляется при помощи стандартного механизма фреймворка — [Navigator](https://flutter.dev/docs/cookbook/navigation)

В студийной практике навигатор используется только в сущности [WidgetModel](../ui/widget_model.md).

## Пример использования

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

## Пример использования с передачей параметров

```dart

class Screen2Route extends CupertinoPageRoute {
  Screen2Route(String param) : super(builder: (ctx) => Screen2(param));
}

class Screen1 extends StatelessWidget {
  
  void goToScreen2(){
    _navigator.push(Screen2Route("Hello from first screen!"));
  }
}


class Screen2 extends StatelessWidget {
  final String someParam;

  // In the constructor, require a Todo.
  DetailScreen({Key key, @required this.someParam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("screen2"),
      ),
      body: Padding(
        child: Text(someParam),
      ),
    );
  }
}
```

# Route

Route определяют анимацию перехода.
Наиболее часто используемые MaterialPageRoute и CupertinoPageRoute.
Более подробно с созданием роутов можно ознакомиться в [этой статье][route_link]


[route_link]:https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171