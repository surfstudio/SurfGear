import 'package:example/ui/base/owners/dialog_owner.dart';
import 'package:example/ui/widgets/example_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_controllers/surf_controllers.dart';

class HomeDialogOwner with DialogOwner {
  @override
  Map<ExampleDialogType, DialogBuilder<DialogData>> get registeredDialogs => {
        ExampleDialogType.text: DialogBuilder<ExampleDialogData>(_buildExampleDialog),
      };

  Widget _buildExampleDialog(BuildContext context, {ExampleDialogData data}) {
    return ExampleDialog(data: data);
  }
}
