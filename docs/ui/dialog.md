# Диалоги 

[Главная](../main.md)

Для автоматизации работы с диалогами используется DefaultDialogController для обычных диалогов и
DatePickerDialogController - для выбора даты. Классы автоматически определяют исполняемую среду и 
адаптируют диалоговое окно в нативный вид. Диалоги необходимо кастомизировать и вызывать только в сущности
WidgetModel. 

# Виды диалогов

- AlertDialog - всплывающее окно. 

Имеет свойства:
    title - название диалогового окна,
    message - текст всплывающего окна.
Две функции-каллбэка:
    onDisagreeClicked - срабатывает по нажатию кнопки "отмена".
    onAgreeClicked - срабатывает по нажатию кнопки "принять".
    
Для программного закрытия AlertDialog необходимо воспользоваться ```dart Navigator.pop()```.

- ModalSheet - всплывающее окно, которое появляется снизу экрана.
    Имеет кастомизируемый ui. Для настройки внешнего вида, использутеся WidgetBuilder,
    который хранится в ```Map<dynamic, WidgetBuilder> registeredDialogs``` в миксине DialogOwner.
    
- Sheet ```///todo``` не нашел использования

- DatePicker - всплывающее окно с выбором даты. Для получения даты из DatePicker, необходимо
    совершить подписку на метод show(), который представляет реактивный поток, в который возвращается
    выбраная дата.

# Пример использования

1) Необходио сконфигурировать компоненту экрана. Создать виджет модель, передать все необходимые зависимости.

```dart 
class ScreenComponent extends BaseWidgetModelComponent<ScreenWidgetModel> {
  @override
  InputNumberScreenWidgetModel wm;

  InputNumberScreenComponent(
    AppComponent parentComponent,
    GlobalKey<ScaffoldState> context,
    DialogOwner owner,
  ) {
    WidgetModelDependencies wmDependencies = WidgetModelDependencies();
    wm = ScreenWidgetModel(
      wmDependencies,
      DefaultDialogController(context, dialogOwner: owner),
      DatePickerDialogController(context),
    );
  }
}
```

2) По необходимости, в сущности Widget сконфигурировать WidgetBuilder'ы, из DialogOwner,
   которые будут использоваться для отображения ui в ModalSheet. Так-же связать действия
   открытия диалогов c WidgetModel.

```dart 
class SomeScreen extends StatefulWidget {
  @override
  _SomeScreenState createState() => _SomeScreenState();
}

class _SomeScreenState extends WidgetState<SomeScreen, ScreenWidgetModel, ScreenComponent> with DialogOwner {
  @override
  Map<dynamic, WidgetBuilder> get registeredDialogs => {
        "create": (ctx) => CreateDialogScreen(),
      };
      
        @override
        Widget buildState(BuildContext context) => Scaffold(
            floatingActionButton: _buildFab(),
            key: _scaffoldKey,
            body: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("show alert dialog"),
                  onPressed: wm.showAlertDialog,
                ),
                RaisedButton(
                  child: Text("show modal dialog"),
                  onPressed: wm.showModalDialog,
                ),
                RaisedButton(
                  child: Text("show sheet dialog"),
                  onPressed: wm.showBottomSheet,
                ),
                RaisedButton(
                  child: Text("show datepicker"),
                  onPressed: wm.showDatePicker,
                ),
              ],
            ));
}
```
3) Описать логику работы диалогов в WidgetModel.

```dart 
class ScreenWidgetModel extends WidgetModel {

  Action showAlertDialog = Action();
  Action showModalDialog = Action();
  Action showDatePicker = Action();

  InputNumberScreenWidgetModel(
      WidgetModelDependencies baseDependencies,
      this._dialogController,
      this._datePickerDialogController)
      : super(baseDependencies);

  @override
  void onLoad() {
    _bindActions();
    super.onLoad();
  }

  void _bindActions() {
    bind(showAlertDialog, (_) {
      _dialogController.showAlertDialog(
          title: "AlertDialogDemo",
          message: "This is AlertDialog. That's fine!",
          onDisagreeClicked: (_) {
            _navigator.pop();
          },
          onAgreeClicked: (_) {
            print("agree");
            _navigator.pop();
          });
    });
    bind(showModalDialog, (_) {
      _dialogController.showModalSheet("create");
    });

    bind(showDatePicker, (_) => _openDatepicker());
  }
  
   void _openDatepicker() {
      subscribe<DateTime>(
        Observable(_datePickerDialogController.show(
          initialDate: DateTime.now(),
        )),
        _updateDate,
      );
    }
  
    void _updateDate(date) {
      if (date != null) {
        print(date);
      }
    }
}
```