[Main](../main.md)

# Testing

## Widget testing

Files with tests are usually located in the `test` subdirectory of the project.
By default, tests are run from all files, with the mask `* _test.dart` from the` test` subdirectory.

The test is described using the `testWidgets` function. 
To interact with the widget, the user is provided with WidgetTester.
```dart
  testWidgets('Test name', (WidgetTester tester) async {
    // Test's code
  });
```

Tests can be grouped using `group`:
```dart
  group('Group of test name', () {
    testWidgets('Test name', (WidgetTester tester) async {
        // Test's code
      });
    
    testWidgets('Test name', (WidgetTester tester) async {
        // Test's code
      });    
  });
```

The `setUp` and `tearDown` functions allow you to execute some code before and after each test.
```dart
  setUp(() {
    // test initialization code
  });
  tearDown(() {
    // test finalization code
  });
```

### Test widget interaction

The `WidgetTester` class provides functions for creating a test widget and waiting for its state to change,
as well as perform some actions on widgets.

* `pumpWidget` — creating a test widget
* `pump` — waiting for the state of the tested widget to change during the specified time (100 ms by default)
* `pumpAndSettle` — calls `pump` in a loop to change states for a given time (100 ms by default)
* `tap` — send widget click
* `longPress` — long press
* `fling` — swipe
* `drag` — drag
* `enterText` — enter text


### Widget search

To perform any action on a nested widget, you need to find it in the widget tree.
To do this, there is a global object `find`, which allows you to find widgets:

* in a tree by text — `find.text`, `find.widgetWithText`
* by key — `find.byKey`
* by icon — `find.byIcon`, `find.widgetWithIcon`
* by type — `find.byType`
* by position in the tree — `find.descendant` and `find.ancestor`
* using a widget predicate — `find.byWidgetPredicate`


### Mocking

Dependency mocks are created as descendants of the `Mock` class and implement the dependency interface.
```dart
class AuthInteractorMock extends Mock implements AuthInteractor {}
```

To determine the functionality of the mock, the `when` function is used,
which allows you to determine the response of the mock to the call of a function.
```dart
when(authInteractor.checkAccess(any))
  .thenAnswer((_) => Future.value(true));
```


### Verify

During the test, you can check for widgets on the screen:
```dart
expect(find.text('Phone number'), findsOneWidget);
expect(find.text('Code from SMS'), findsNothing);
```

After completing the test, you can check how the layout was used by the widget:
```dart
verify(appComponent.authInteractor).called(1);
verify(authInteractor.checkAccess(any)).called(1);
verifyNever(appComponent.profileInteractor);
```


### Debugging

Tests are performed in the console without any graphics.
You can run tests in debug mode and set breakpoints in the widget code.

In order to get information about what is happening in the widget tree, you can use
function `debugDumpApp()`, which displays the console text representation of the hierarchy of the entire widget tree.

To get an idea of how the widget uses moсkы, the `logInvocations([])` function is used.
The function accepts a list of mocks, and issues to the console a sequence of 
method calls on these mocks that the tested widget made.

### Preparation

All interactors and other dependencies should be transferred to the tested widget in the form of mock:
```dart
class AppComponentMock extends Mock implements AppComponent {}
class AuthInteractorMock extends Mock implements AuthInteractor {}
```

At the root of the widget tree should be `Injector` and `MaterialApp`.
```dart
    await tester.pumpWidget(
      Injector<AppComponent>(
        component: appComponentMock,
        builder: (context) {
          return MaterialApp(
            home: PhoneInputScreen(),
          );
        },
      ),
    );
    await tester.pumpAndSettle();
```
In the sample code, `PhoneInputScreen` is the test widget.
It is also seen that `Injector` receives the `AppComponent` mock as a parameter and, 
as usual, extracts the necessary dependencies from it, which must first be created 
and put into the `AppComponent` mock using `when`.

After creating a test widget and after any actions with it, 
you need to call `tester.pumpAndSettle()` to change states.


### Testing

To test the widget, we can simulate the behavior of the service layer and track the response of the tested widget.

Mocks can return errors or wrong data:
```dart
when(authInteractor.checkAccess(any)).thenAnswer((_) => Future.error(UnknownHttpStatusCode(null)));
```

In the test, you can and should click where it is not necessary, and enter not what is required, 
and verify that this does not lead to fatal consequences
```dart
await tester.enterText(find.byKey(Key('phoneField')), 'bla-bla-bla');
```

After any actions with widgets, you need to call `tester.pumpAndSettle()` to change states.


## Integration testing

This testing method may well replace manual testing.
The testing process can be clearly observed in the emulator or on the device.

Among the disadvantages of this approach, it can be noted that there is no way 
to interact with the system dialogs of the platform.
But, for example, permission requests can be suppressed as described in [this issue](https://github.com/flutter/flutter/issues/12561).

### General information

Unlike the test widget, the integration test operation process can be observed in the simulator or on the device screen.

Files with integration tests are located in the `test_driver` subdirectory of the project.

The application starts after the launch of a special plugin that allows you to manage our application.

It looks like this:
```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:park_flutter/main.dart' as app;
void main() {
  enableFlutterDriverExtension();
  app.main();
}
```

The tests are run from the command line.
If the launch of the application is described in the file `app.dart`, 
and the test script is called` app_test.dart`, then the following command is enough:
```text
$ flutter drive --target=test_driver/app.dart
```

If the test script has a different name, then you need to specify it explicitly:
```text
flutter drive --target=test_driver/app.dart --driver=test_driver/home_test.dart
```

A test is created by the `test` function, and grouped by the `group` function.

```dart
group('park-flutter app', () {
    // driver through which we connect to the device
    FlutterDriver driver;

    // create a connection to the driver
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // close connection to the driver
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Test name', () async {
      // Test code
    });
    
    test('Another test', () async {
      // Test code
    });
}
```


### Interaction with the tested application

The `FlutterDriver` tool allows you to interact with the application under test through the following methods:

* tap — send click to widget
* waitFor — wait for the widget to appear on the screen
* waitForAbsent — wait for the widget to absent
* scroll, scrollIntoView, scrollUntilVisible — scroll the screen to a predetermined offset or to a specific widget
* enterText, getText — enter text or take widget text
* screenshot — get a screenshot
* requestData — more complex interaction through function call inside the application under test
* etc

In the application, you can specify a request handler, which can be accessed through a call to `driver.requestData('login')`
```dart
void main() {
  Future<String> dataHandler(String msg) async {
    if (msg == "login") {
      // some kind of call processing in the application with returning the result
      return 'some result';
    }
  }

  enableFlutterDriverExtension(handler: dataHandler);
  app.main();
}
```


### Widget search

Search widgets during integration testing is slightly different from similar functionality when testing widgets:

* in a tree by text — `find.text`, `find.widgetWithText`
* by key — `find.byValueKey`
* by type — `find.byType`
* by tooltip — `find.byTooltip`
* by semantics label — `find.bySemanticsLabel`
* using a widget predicate — `find.descendant` and `find.ancestor`