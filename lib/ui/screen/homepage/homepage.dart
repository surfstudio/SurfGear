import 'package:flutter/material.dart';
import 'package:flutter_template/di/homepage_module.dart';
import 'package:flutter_template/di/injector.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/common/progress_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


abstract class ViewModel {

  List<Subject> _subjects = List();

  BehaviorSubject<T> createSubject<T>() {
    BehaviorSubject<T> bs = BehaviorSubject<T>();
    _subjects.add(bs);
    return bs;
  }

  dispose() {
    _subjects.forEach(
      (s) => s.close()
    );
  }

}
class HomePageModel extends ViewModel {
  final CounterInteractor _counterInteractor;
  int _counter = 0;

  BehaviorSubject<int> _counterSubject = BehaviorSubject<int>();
  BehaviorSubject<String> _buttonTextSubject = BehaviorSubject<String>();

  HomePageModel(this._counterInteractor) {
    _counterInteractor.counterObservable.listen(_counterSubject.add);
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

class _MyHomePageState extends State<MyHomePage> {
  HomePageModel _model;

  @override
  Widget build(BuildContext context) {
    return Injector(
      component: HomePageComponent(Injector.of(context).get(CounterInteractor)),
      builder: (context) => new HomePage(title: widget.title),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: Injector.of(context).get<HomePageModel>(HomePageModel).counterObservable,
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
        onPressed: Injector.of(context).get(HomePageModel).incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
