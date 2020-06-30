[Main](../main.md)

# Dialogs

There are two types of [controllers](../../../packages/template/lib/ui/base/default_dialog_controller.dart) for displaying dialogs:

* `DefaultDialogController` for pop-up dialogs and bottom sheet
* `DatePickerDialogController` to select a date

Using showAlertDialog(), DefaultDialogController can display a pop-up dialog whose appearance automatically adjusts to the platform. If you need to redefine the user interface of the dialog, then you need to use DialogOwner.

## DialogOwner

Work with dialogs is built around the mixin [DialogOwner](../../../packages/template/lib/ui/base/owners/dialog_owner.dart). 
To describe the necessary dialogs, you need to create a class in which the getter *registeredDialogs* of this mixin is redefined. The getter returns a Map, where the values are the builders that return the dialog widgets. 
In WidgetModel, the necessary dialog is located by the key of this Map.

Usage:

1. For the desired screen, you need to create your DialogOwner:

```dart
// Keys for registeredDialogs, we will find the 
// necessary dialogs in WidgetModel by them.
enum OnboardingDialog {
  requestPermission,
  openSystemSettings,
}

// A class containing the data for the dialog.
// An object of this class is passed as an argument when calling a 
// dialog from WidgetModel.
class OnboardingDialogData implements DialogData {
  final Function(BuildContext) onButtonPressed;

  OnboardingDialogData({
    this.onButtonPressed,
  });
}

// Dialog map
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
2. In the Component of the screen, declare the dialog controller and transfer the created DialogOwner to its constructor:

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
3. In WidgetModel, using the dialog controller from the component, call the desired dialog and pass the necessary data to it:
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