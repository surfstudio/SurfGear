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

import 'package:flutter/widgets.dart';

/// Mixin for register Flexible Bottom Sheet
mixin FlexibleBottomSheetOwner {
  Map<Object, BottomSheetShower> get registeredBottomSheetShowers;
}

/// Class represent data for bottom sheet building
abstract class BottomSheetData {}

class BottomSheetShower<T extends BottomSheetData, R> {
  BottomSheetShower(this.builder);

  final Future<R> Function(BuildContext context, {T? data}) builder;

  Future<R> call(BuildContext context, {T? data}) =>
      builder(context, data: data);
}
