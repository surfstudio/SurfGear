import 'package:flutter/material.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/base/view_model.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

///Модель виджета [MyHomePage]
class HomePageModel extends ViewModel {
  final CounterInteractor _counterInteractor;

  BehaviorSubject<int> _counterSubject;
  BehaviorSubject<String> _buttonTextSubject;

  HomePageModel(this._counterInteractor) {
    _counterSubject = createSubject();
    _buttonTextSubject = createSubject();
    _counterInteractor.counterObservable
        .listen((c) => _counterSubject.add(c.count));
  }

  Observable<int> get counterObservable => _counterSubject.stream;

  incrementCounter() {
    _counterInteractor.incrementCounter();
  }
}

///Главная страница
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  HomePageModel _model;

  @override
  Widget build(BuildContext context) {
    return Injector(
      component: HomePageComponent(Injector.of(context).get(CounterInteractor)),
      builder: (context) {
        _model = Injector.of(context).get(HomePageModel);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  homePageText,
                ),
                StreamBuilder<int>(
                  stream: _model.counterObservable,
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
                ProgressBar(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _model.incrementCounter,
            tooltip: incButtonTooltip,
            child: Icon(Icons.add),
          ),
        );
      } ,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
