import 'dart:async';
import 'dart:isolate';

const int _DEFAULT_BACKGROUND_WORKER_CAPACITY = 1;

/// Background Worker is a helper class for work with isolates
///
/// Required method for executing : start() and stop()
class BackgroundWorker {
  /// isolates count in worker
  final int capacity;

  List<_Worker> _workers = [];

  BackgroundWorker({
    this.capacity: _DEFAULT_BACKGROUND_WORKER_CAPACITY,
  });

  ///Start BackgroundWorker
  ///
  ///Create and start isolates
  Future<void> start() async {
    if (_workers.isNotEmpty) {
      throw Exception("BackgroundWorker started already!");
    }

    for (int i = 0; i < capacity; i++) {
      _Worker worker = _Worker();
      await worker.start();
      _workers.add(worker);
    }
  }

  /// Send WorkItem to execute it in background
  Future<WorkItem> send(WorkItem workItem) async {
    if (_workers.isEmpty) {
      throw Exception("BackgroundWorker isn't started.");
    }
    return await _getWorkerWithMinWorks().doInBackground(workItem);
  }

  /// Stop BackgroundWorker
  void stop() {
    if (_workers.isNotEmpty) {
      _workers.forEach((worker) => worker.stop());
      _workers.clear();
    }
  }

  _Worker _getWorkerWithMinWorks() {
    _Worker worker = _workers.first;
    for (var i = 0; i < _workers.length; i++) {
      if (_workers[i].size < worker.size) {
        worker = _workers[i];
      }
    }
    return worker;
  }
}

/// Contain isolate and some data for balancing performance
class _Worker {
  int size = 0;
  Isolate isolate;
  SendPort port;
  bool isWork = false;

  /// Start worker
  ///
  /// Create and initialize isolate
  Future<void> start() async {
    ReceivePort receivePort = ReceivePort();
    isolate = await Isolate.spawn(_initBackgroundIsolate, receivePort.sendPort);
    port = await receivePort.first;
  }

  ///Background work
  Future<WorkItem> doInBackground(WorkItem workItem) async {
    size++;

    ReceivePort response = new ReceivePort();
    port.send([workItem, response.sendPort]);
    WorkItem result = await response.first;

    size--;

    return result;
  }

  /// Stop worker
  ///
  /// Kill isolate
  void stop() {
    if (isolate != null) {
      isolate.kill();
      isolate = null;
      port = null;
    }
  }
}

/// Entry point for background isolate
void _initBackgroundIsolate(SendPort sendPort) async {
  var receivePort = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(receivePort.sendPort);

  /// Infinit loop makes background work
  await for (var message in receivePort) {
    WorkItem workItem = message[0];
    SendPort replyTo = message[1];
    replyTo.send(
      await _doBackgroundWork(workItem),
    );
  }
}

Future<WorkItem> _doBackgroundWork(WorkItem backgroundWorkItem) async {
  backgroundWorkItem.output = await backgroundWorkItem.calculation(
    backgroundWorkItem.input,
  );
  return backgroundWorkItem;
}

/// Represent background work
class WorkItem<I, O> {
  WorkItem();

  WorkItem.calculate(this.calculation);

  /// Function executes in background
  ///
  /// Must be static or top-level function
  Future<O> Function(I input) calculation;

  /// Input for background function
  I input;

  /// Output from background function
  O output;
}
