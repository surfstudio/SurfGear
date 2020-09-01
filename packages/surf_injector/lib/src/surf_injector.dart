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
import 'package:surf_injector/src/component.dart';

Type _typeOf<T>() => T;

/// Special widget for DI
/// It provide dependencies to children.
/// Children can get component dependency by 'of' and 'Component.get(Type)'
///
class Injector<C extends Component> extends StatefulWidget {
  // const - кеширование?
  const Injector({this.component, Key key, this.builder}) : super(key: key);

  final C component;
  final WidgetBuilder builder;

  static _Injector<C> of<C extends Component>(BuildContext context) {
    final Type type = _typeOf<_Injector<C>>();
    InheritedWidget injector;
    try {
      injector =
          // ignore: deprecated_member_use
          context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
      if (injector == null) {
        throw Exception(
            'Can not find nearest Injector of type $type. Do you define it?');
      }
    } on Exception {
      injector =
          context.getElementForInheritedWidgetOfExactType<_Injector>()?.widget;
    }

    return injector as _Injector<C>;
  }

  @override
  _InjectorState createState() => _InjectorState<C>();
}

class _InjectorState<C extends Component> extends State<Injector> {
  @override
  Widget build(BuildContext context) {
    return _Injector<C>(
      component: widget.component as C,
      child: _InjectorProxy(
        builder: (c) => widget.builder(c),
      ),
    );
  }
}

//todo remove this
class _InjectorProxy extends StatelessWidget {
  const _InjectorProxy({Key key, this.builder}) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

/// Special class fo Dependency Injection
/// Here you are able to manipulate your dependencies
/// Making this class extend [InheritedWidget] able to provide dependencies
/// and define "scopes"
class _Injector<C extends Component> extends InheritedWidget {
  //конст - кеширование?
  const _Injector({this.component, Key key, Widget child})
      : super(key: key, child: child);

  final C component;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    //не имеет своего стейта, не реагирует на изменение зависимостей,
    //это лишь провайдер
    return false;
  }
}
