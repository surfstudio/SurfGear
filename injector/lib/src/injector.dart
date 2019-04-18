import 'package:flutter/widgets.dart';
import 'package:injector/src/component.dart';

Type _typeOf<T>() => T;

/// Special widget for DI
/// It provide dependencies to children.
/// Children can get component dependency by 'of' and 'Component.get(Type)'
///
class Injector<C extends Component> extends StatefulWidget {
  final C component;
  final WidgetBuilder builder;

  //конст - кеширование?
  const Injector({this.component, Key key, this.builder}) : super(key: key);

  static _Injector<C> of<C extends Component>(BuildContext context) {
    Type type = _typeOf<_Injector<C>>();
    var injector;
    try {
      injector =
          context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
      if (injector == null) {
        throw Exception(
            "Can not find nearest Injector of type $type. Do you define it?");
      }
    } catch (e) {
      injector = context
          .ancestorInheritedElementForWidgetOfExactType(_Injector)
          ?.widget;
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
      component: widget.component,
      child: _InjectorProxy(
        builder: (c) => widget.builder(c),
      ),
    );
  }
}

class _InjectorProxy extends StatelessWidget {
  final WidgetBuilder builder;

  const _InjectorProxy({Key key, this.builder}) : super(key: key);

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
  final C component;

  //конст - кеширование?
  const _Injector({this.component, Key key, Widget child})
      : super(key: key, child: child);

  ///проверить
  T get<T>(Type t) {
    return component.get<T>(t);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    //не имеет своего стейта, не реагирует на изменение зависимостей,
    //это лишь провайдер
    return false;
  }
}
