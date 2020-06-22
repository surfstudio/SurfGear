[Main](../main.md)

# Navigation

Navigation is done using the standard framework mechanism — [Navigator](https://flutter.dev/docs/cookbook/navigation)

In studio practice, the navigator is used only in entity of [WidgetModel](../ui/widget_model.md).

## Usage example

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

## Usage example with arguments

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

The route defines the transition animation.
The most commonly used MaterialPageRoute and CupertinoPageRoute.
For more information on creating routes, see [this article][route_link]


[route_link]:https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171