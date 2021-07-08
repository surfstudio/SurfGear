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

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

typedef WidgetModelBuilder<WM> = WM Function(BuildContext context);

/// Class for widgets that has [WidgetModel]
/// You must provide [WidgetModel] in constructor or by WidgetModelFactory
abstract class CoreMwwmWidget<WM extends WidgetModel> extends StatefulWidget {
  /// Builder for `WidgetModel`
  /// There are two possibilities to provide `WidgetModel` :
  ///  1. Here by [widgetModelBuilder] (prefer)
  ///  2. Or by `WidgetModelFactory`
  ///
  /// By convention provide builder for WM this way
  /// ```
  /// const MyAwesomeWidget(
  ///   WidgetModel wmBuilder,
  /// ) : super(
  ///   widgetModelBuilder: wmBuilder ?? myBuilderFn
  /// );
  /// ```
  final WidgetModelBuilder<WM> widgetModelBuilder;

  const CoreMwwmWidget({
    required this.widgetModelBuilder,
    Key? key,
  }) : super(key: key);

  @override
  @nonVirtual
  // ignore: no_logic_in_create_state
  State createState() => createWidgetState();

  WidgetState<CoreMwwmWidget<WM>, WM> createWidgetState();
}

/// Base class for state of [CoreMwwmWidget].
/// Has [WidgetModel] from [initState].
abstract class WidgetState<W extends CoreMwwmWidget<WM>, WM extends WidgetModel>
    extends State<W> {
  @protected
  WM get wm => _wm;

  /// [WidgetModel] for widget.
  late WM _wm;

  /// Descendants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    _wm = widget.widgetModelBuilder(context);

    super.initState();

    _wm
      ..onLoad()
      ..onBind();
  }

  /// Descendants must call super in the end
  @protected
  @mustCallSuper
  @override
  void dispose() {
    _wm.dispose();
    super.dispose();
  }
}
