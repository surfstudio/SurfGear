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
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';

typedef DependenciesBuilder<C> = C Function(BuildContext context);
typedef WidgetStateBuilder = State Function();

/// Base class for widgets that has [WidgetModel]
/// and has dependencies in [Component]
abstract class MwwmWidget<C extends Component> extends StatefulWidget {
  const MwwmWidget({
    required this.dependenciesBuilder,
    required this.widgetStateBuilder,
    required this.widgetModelBuilder,
    Key? key,
  }) : super(key: key);

  /// A function that build dependencies for WidgetModel and Widget
  final DependenciesBuilder<C> dependenciesBuilder;

  /// Builder for [WidgetState]
  final WidgetStateBuilder widgetStateBuilder;

  /// Builder for [WidgetModel].
  /// Typically is null because
  /// WidgetModelBuilders set in the `WidgetModelFactory`
  final WidgetModelBuilder widgetModelBuilder;

  @override
  _MwwmWidgetState createState() => _MwwmWidgetState<C>();
}

/// Hidden widget that create [WidgetState]
/// It's only proxy builder for [State]
class _ProxyMwwmWidget extends StatefulWidget {
  const _ProxyMwwmWidget({
    required WidgetStateBuilder widgetStateBuilder,
    required this.widgetModelBuilder,
    Key? key,
  })  : _wsBuilder = widgetStateBuilder,
        super(
          key: key,
        );
  final WidgetModelBuilder widgetModelBuilder;
  final WidgetStateBuilder _wsBuilder;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _wsBuilder();
}

/// Hold child widget
class _MwwmWidgetState<C extends Component> extends State<MwwmWidget> {
  late final Widget child;

  @override
  void initState() {
    super.initState();

    child = Injector<C>(
      component: widget.dependenciesBuilder(context) as C,
      builder: (ctx) => _ProxyMwwmWidget(
        widgetStateBuilder: widget.widgetStateBuilder,
        widgetModelBuilder: widget.widgetModelBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => child;
}

/// WidgetState which doesn't require Widget to be CoreMwwmWidget.
///
/// It is supposed to be used with [MwwmWidget] and not with [CoreMwwmWidget]
///
/// Because of complexity of changes and migration, and because of
/// changes are not profitable after surf_injector is not preferable DI solution
/// it is easier to use widget state from mwwm which is not coupled with widget by generic type
abstract class OldWidgetState<WM extends WidgetModel> extends State<CoreMwwmWidget> {
  /// [WidgetModel] for widget.
  late WM _wm;

  @protected
  WM get wm => _wm;

  /// Descendants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    _wm = widget.widgetModelBuilder(context) as WM;

    super.initState();

    _wm
      ..onLoad()
      ..onBind();
  }

  /// Descendants must call super in the end
  @override
  @protected
  @mustCallSuper
  void dispose() {
    _wm.dispose();
    super.dispose();
  }
}

/// Implementation of MwwmWidget based on [InheritedWidget]
/// todo test perfomance
abstract class MwwmInheritedWidget<WM extends WidgetModel, C extends Component>
    extends InheritedWidget {
  MwwmInheritedWidget({
    required DependenciesBuilder<C> dependenciesBuilder,
    required WidgetStateBuilder widgetStateBuilder,
    required WidgetModelBuilder<WM> widgetModelBuilder,
    Key? key,
  }) : super(
          key: key,
          child: Builder(
            builder: (context) => Injector<C>(
              component: dependenciesBuilder(context),
              builder: (ctx) {
                return _ProxyMwwmWidget(
                  widgetStateBuilder: widgetStateBuilder,
                  widgetModelBuilder: widgetModelBuilder,
                );
              },
            ),
          ),
        );

  /// Yet this forever true because otherwise hot reload not working.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
