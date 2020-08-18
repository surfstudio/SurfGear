[Главная](../main.md)

# Диалоги

Для отображения диалогов существует два вида [контроллеров](../../../template/lib/ui/base/default_dialog_controller.dart):

* `DefaultDialogController` для всплывающих диалогов и шторок (bottom sheet)
* `DatePickerDialogController` для выбора даты

С помощью showAlertDialog() у DefaultDialogController можно отобразить всплывающий диалог, внешний вид которого автоматически подстроится под платформу. Если же необходимо переопределить пользовательский интерфейс диалога, то для этого нужно воспользоваться DialogOwner.

## DialogOwner

Работа с диалогами строится вокруг миксина [DialogOwner](../../../template/lib/ui/base/owners/dialog_owner.dart). Чтобы описать необходимые диалоги, нужно создать класс, в котором переопределяется геттер *registeredDialogs* этого миксина. Геттер возвращает Map, где значения — билдеры, которые возвращают виджеты диалогов. В WidgetModel нужный диалог находится по ключу этой Map.

Применение:

1. Для нужного экрана необходимо создать свой DialogOwner:

```dart
// Ключи для registeredDialogs, по ним будем находить
// нужные диалоги в WidgetModel.
enum OnboardingDialog {
  requestPermission,
  openSystemSettings,
}

// Класс, содержащий данные для диалога.
// Объект этого класса передаётся в качестве аргумента при вызове
// диалога из WidgetModel.
class OnboardingDialogData implements DialogData {
  final Function(BuildContext) onButtonPressed;

  OnboardingDialogData({
    this.onButtonPressed,
  });
}

// Набор диалогов
class OnboardingDialogOwner with DialogOwner {
  @override
  Map<dynamic, DialogBuilder> get registeredDialogs => {
        OnboardingDialog.requestPermissionAgain:
            DialogBuilder<OnboardingDialogData>(_buildRequestPermissionDialog),
        OnboardingDialog.openSystemSettings:
            DialogBuilder<OnboardingDialogData>(_buildOpenSettingsDialog),
      };
}

Widget _buildRequestPermissionDialog(
  BuildContext context, {
  OnboardingDialogData data,
}) {
  return FooBottomSheet(
      // …
  );
}

Widget _buildOpenSettingsDialog(
  BuildContext context, {
  OnboardingDialogData data,
}) {
  return BarBottomSheet(
      // …
  );
}

```
2. В Component экрана объявить контроллер диалогов и в его конструктор передать созданный DialogOwner:

```dart
class OnboardingScreenComponent implements Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DefaultDialogController dialogController;

  OnboardingScreenComponent(BuildContext context) {
    dialogController = DefaultDialogController(
      scaffoldKey,
      dialogOwner: OnboardingDialogOwner(),
    );
  }
}
```
3. В WidgetModel, используя контроллер диалогов из компонента, вызвать нужный диалог и передать ему необходимые данные:
```dart
    _dialogController.showModalSheet(
      OnboardingDialog.openSystemSettings,
      isScrollControlled: true,
      data: OnboardingDialogData(
        onButtonPressed: (context) {
          w.Navigator.pop(context);
          _permissionInteractor.openSettings();
        },
      ),
    );
```