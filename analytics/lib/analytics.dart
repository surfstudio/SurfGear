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

library analytics;

export 'package:analytics/core/analytic_action.dart';
export 'package:analytics/core/analytic_service.dart';
export 'package:analytics/core/analytic_action_performer.dart';
export 'package:analytics/core/analytic_action_performer_creator.dart';

export 'package:analytics/has_key.dart';
export 'package:analytics/has_map_params.dart';

export 'package:analytics/impl/default_analytic_service.dart';

export 'package:analytics/impl/firebase/firebase_analytic_set_user_property_action_performer.dart';
export 'package:analytics/impl/firebase/firebase_analytic_set_user_property_action.dart';
export 'package:analytics/impl/firebase/firebase_analytic_event.dart';
export 'package:analytics/impl/firebase/firebase_analytic_event_sender.dart';
export 'package:analytics/impl/firebase/const.dart';
