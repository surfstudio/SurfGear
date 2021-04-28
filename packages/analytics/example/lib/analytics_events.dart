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

import 'package:example/firebase/firebase_analytic_event.dart';

class FantasticButtonTappedEvent implements FirebaseAnalyticEvent {
  const FantasticButtonTappedEvent();

  @override
  String get key => 'fantastic_button_tapped';

  @override
  Map<String, Object> get params => <String, Object>{};

  @override
  String toString() => 'FantasticButtonTappedEvent';
}

class SparklingButtonTappedEvent implements FirebaseAnalyticEvent {
  const SparklingButtonTappedEvent(this.payload);

  final String payload;

  @override
  String get key => 'sparkling_button_tapped';

  @override
  Map<String, String> get params => {
        'payload': payload,
      };

  @override
  String toString() => 'SparklingButtonTappedEvent';
}

class DelightfulButtonTappedEvent implements FirebaseAnalyticEvent {
  const DelightfulButtonTappedEvent({required this.isDelightful});

  final bool isDelightful;

  @override
  String get key => 'delightful_button_tapped';

  @override
  Map<String, bool> get params => {
        'isDelightful': isDelightful,
      };

  @override
  String toString() => 'DelightfulButtonTappedEvent';
}
