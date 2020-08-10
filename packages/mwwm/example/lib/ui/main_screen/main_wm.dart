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

import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

/// Main screen's widget model
class MainWm extends WidgetModel {
  MainWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  final pageIndexState = StreamedState(0);

  final changePageAction = Action<int>();

  @override
  void onBind() {
    super.onBind();

    subscribe(changePageAction.stream, onChangePage);
  }

  void onChangePage(int pageIndex) {
    pageIndexState.accept(pageIndex);
  }
}
