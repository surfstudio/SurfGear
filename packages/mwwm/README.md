<!--![logo](logo.gif)-->

# <img src="https://i.ibb.co/N719LCW/logo.png" title="logo" align="middle"/>

#### [SurfGear](https://github.com/surfstudio/SurfGear)
[![pub package](https://img.shields.io/pub/v/mwwm?label=mwwm)](https://pub.dev/packages/mwwm)

Software architectural pattern for Flutter apps.


## Description

MWWM is based on principles of Clean Architecture and is a variation of *MVVM*.

It consists of three parts: *Widget*, *WidgetModel* and *Model*.

**Widget** — a representation layer that contains only UI related code. 

**WidgetModel** - handles and accumulates all data needed for Widget:
objects of the domain layer, scroll position, text fields values, animation state, etc.
WidgetModel uses Model for interaction with various data sources.

**Model** - a link between WidgetModel and "the external world": data sources,
services or other abstraction layers. It allows to develop both separately and have
a possibility to modify one layer with no need for changing the other. Model is
represented by two components: **Change** (a signal to model which means *what* we want
to achieve) and **Performer** (that knows *how* to achieve it).

![](https://github.com/surfstudio/mwwm/blob/dev/doc/images/mwwm.png?raw=true) 

## Why?

This architecture completely separates design and logic. Adds the ability to work on independent layers by different developers. Adds autonomy to work, like HTML and CSS.

##  How to use

Create a WidgetModel class by extending [WidgetModel].
```
class RepositorySearchWm extends WidgetModel {

  RepositorySearchWm(
    WidgetModelDependencies baseDependencies, //1
    Model model, //2
    ) : super(baseDependencies, model: model); //3

}
``` 
1 - [WidgetModelDependencies](./lib/src/dependencies/wm_dependencies.dart) is a bundle of required dependencies. Default there is [ErrorHandler](./lib/src/error/error_handler.dart), which 
give possibility to place error handling logic in one place. You must provide an implementation of handler.

2 - [Model](./lib/src/model/model.dart) is contract with service layer. For now, it is optional feature. It is possible to use services directly but 
not recommended.

3 - don't forgive about provide model to superclass if you wont to use Model.

Add Widget simply by creating StatefulWidget and replace parent class with [CoreMwwmWidget](./lib/src/widget_state.dart)

```
class RepositorySearchScreen extends CoreMwwmWidget {

  //...

  @override
  State<StatefulWidget> createState() {
    return _RepositorySearchScreenState();
  }
}
```

By **convention** create a same constructor:
```
  RepositorySearchScreen({
    WidgetModelBuilder wmBuilder, // need to testing
  }) : super(
          widgetModelBuilder: wmBuilder ??
              (ctx) => RepositorySearchWm(
                    // provide args,
                  ),
        );
```
or by route:
```
  class RepositorySearchRoute extends MaterialPageRoute {
    RepositorySearchRoute()
        : super(
            builder: (context) => RepositorySearchScreen(
              widgetModelBuilder: _buildWm,
            ),
          );
  }

  WidgetModel _buildWm(BuildContext context) => RepositorySearchWm(
        context.read<WidgetModelDependencies>(),
        Model([
          // performets
        ]),
      );
```

Change parent of State of StatefulWidget to [WidgetState](./lib/src/widget_state.dart):
```
class _RepositorySearchScreenState extends WidgetState<RepositorySearchWm>
```

All done! You create your presentation.

## FAQ

### Where can I place UI?

Simply in **build** method in WidgetState. No difference with Flutter framework.

### How can I obtain a WM?

WidgetState has WidgetModel after initState() called.
There is a getter - **wm** - to get your WidgetModel in your Widget.

### Where should I place navigation logic?

Only in WidgetModel. But we don't hardcodea way to do this, yet.

## Service(bussines) Layer

***It is optional paragraph. You can write connection with services your favorite way.***

To work with business logic need to decribe a contract which consists of two parts: [Change](./lib/src/model/changes/changes.dart) and [Performer](./lib/src/model/performer/performer.dart).

**Change** - is an intention to do something on service layer. Change can has data. Formally, it is an arguments of some function.

**Performer<R, Change>** - is a functional part of this contract. It is so close to UseCase. Performer, in ideal world, do only one thing. It is small part og logic which needed to perform Change.

## Recommended file structure

We recomend following structure:

- ./
  - data/
  - model/
    - services(repository)/
    - changes.dart  // can split
    - performer.dart // can split
  - ui/
    - screen(widget)/
      - wm.dart
      - route.dart
      - screen(widget).dart   


# Feature RoadMap

- Coordinator - abstraction to place navigation logic
- Code generation (may be)
- Somthing else ? Create an issue with request to feature.
