import 'package:flutter/material.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/base/view_model.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class HomePageModel extends ViewModel {
  final CounterInteractor _counterInteractor;

  BehaviorSubject<int> _counterSubject = BehaviorSubject<int>();
  BehaviorSubject<String> _buttonTextSubject = BehaviorSubject<String>();

  HomePageModel(this._counterInteractor) {
    _counterInteractor.counterObservable.listen((c) => _counterSubject.add(c.count));
  }

  Observable<int> get counterObservable => _counterSubject.stream;

  incrementCounter() {
    print("DEV_INFO increnemt");
    _counterInteractor.incrementCounter();
  }

  dispose() {
    _counterSubject.close();
    _buttonTextSubject.close();
  }
}

// по скути специально чтобы выделит контекст для зависимостей
// Выделить в конфигуратор?
// Большое количество стейтфул -- плохо для перфоманса
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Injector(
      component: HomePageComponent(Injector.of(context).get(CounterInteractor)),
      builder: (context) => new HomePage(title: widget.title),
    );
  }
}

/// Сам виджет
class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageModel _model;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _model = Injector.of(context).get<HomePageModel>(HomePageModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
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
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }


  @override
  void dispose() {
    _model.dispose();
    super.dispose();

  }
}
