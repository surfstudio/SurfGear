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

import 'dart:async';
import 'dart:isolate';

const int _defaultBackgroundWorkerCapacity = 1;

/// Background Worker is a helper class for work with isolates
///
/// Required method for executing : start() and stop()
class BackgroundWorker {
  /// isolates count in worker
  final int capacity;

  final _workers = <_Worker>[];

  // ignore: sort_constructors_first
  BackgroundWorker({
    this.capacity = _defaultBackgroundWorkerCapacity,
  });

  ///Start BackgroundWorker
  ///
  ///Create and start isolates
  Future<void> start() async {
    if (_workers.isNotEmpty) {
      throw Exception('BackgroundWorker started already!');
    }

    for (int i = 0; i < capacity; i++) {
      final _Worker worker = _Worker();
      await worker.start();
      _workers.add(worker);
    }
  }

  /// Send WorkItem to execute it in background
  Future<WorkItem> send(WorkItem workItem) async {
    if (_workers.isEmpty) {
      throw Exception("BackgroundWorker isn't started.");
    }
    return _getWorkerWithMinWorks().doInBackground(workItem);
  }

  /// Stop BackgroundWorker
  void stop() {
    if (_workers.isNotEmpty) {
      for (final worker in _workers) {
        worker.stop();
      }
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
    final receivePort = ReceivePort();
    isolate = await Isolate.spawn(_initBackgroundIsolate, receivePort.sendPort);
    port = await receivePort.first as SendPort;
  }

  ///Background work
  Future<WorkItem> doInBackground(WorkItem workItem) async {
    size++;

    final response = ReceivePort();
    port.send([workItem, response.sendPort]);
    final result = await response.first as WorkItem;

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
Future<void> _initBackgroundIsolate(SendPort sendPort) async {
  final receivePort = ReceivePort();

  // Notify any other isolates what port this isolate listens to.
  sendPort.send(receivePort.sendPort);

  /// Infinit loop makes background work
  await for (final message in receivePort) {
    final workItem = message[0] as WorkItem;
    // ignore: unused_local_variable
    final replyTo = message[1] as SendPort
      ..send(await _doBackgroundWork(workItem));
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
