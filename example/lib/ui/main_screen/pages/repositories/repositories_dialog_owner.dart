import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/util/dialog_controller.dart';

enum RepositoryDialog {
  repoSheet,
}

class RepositoryDialogOwner with DialogOwner {
  @override
  Map<dynamic, DialogBuilder> get registeredDialogs => {
        RepositoryDialog.repoSheet:
            DialogBuilder<TestDataForSheet>(_buildSheet),
      };
}

/// Data for sheet and modalSheet
class TestDataForSheet implements DialogData {
  TestDataForSheet({
    this.testData,
  });

  final String testData;
}

Widget _buildSheet(
  BuildContext context, {
  TestDataForSheet data,
}) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Center(
      child: Text(
        'Hello ${data.testData}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 42,
        ),
      ),
    ),
  );
}
