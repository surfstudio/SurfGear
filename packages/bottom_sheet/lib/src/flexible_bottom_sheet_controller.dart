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

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bottom_sheet/src/flexible_bottom_sheet_owner.dart';
import 'package:flutter/material.dart';

/// Default controller of showing bottom sheet that can resize and scroll.
class FlexibleBottomSheetController {
  FlexibleBottomSheetController(
    this._context, {
    required this.owner,
  });

  final BuildContext _context;
  final FlexibleBottomSheetOwner owner;

  /// Show registered bottom sheet.
  Future<T> show<T>(
    Object type, {
    BottomSheetData? data,
  }) {
    final showers = owner.registeredBottomSheetShowers[type];

    if (showers != null) {
      return showers(
        _context,
        data: data,
      ) as Future<T>;
    } else {
      throw Exception('BottomSheetShowers not registered for type: $type');
    }
  }
}
