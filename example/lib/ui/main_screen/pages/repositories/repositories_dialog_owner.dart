// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
