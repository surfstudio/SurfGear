import 'package:example/ui/base/owners/dialog_owner.dart';
import 'package:example/ui/widgets/example_dialog.dart';
import 'package:surf_controllers/surf_controllers.dart';

class HomeDialogOwner with DialogOwner {
  @override
  Map<ExampleDialogType, DialogBuilder<DialogData>> get registeredDialogs => {
        ExampleDialogType.text: DialogBuilder<ExampleDialogData>((
          context, {
          required data,
        }) {
          return ExampleDialog(data: data);
        }),
      };
}
