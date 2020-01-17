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

library mwwm;

//controllers
export 'package:mwwm/src/controller/dialog_controller.dart';
export 'package:mwwm/src/controller/message_controller.dart';

//di
export 'package:mwwm/src/di/base_wm_component.dart';
export 'package:mwwm/src/di/wm_dependencies.dart';

//errors
export 'package:mwwm/src/error/error_handler.dart';

//relations
export 'package:mwwm/src/relation/event/entity_state.dart';
export 'package:mwwm/src/relation/event/action.dart';
export 'package:mwwm/src/relation/event/actions/controller_action.dart';
export 'package:mwwm/src/relation/event/actions/scroll_action.dart';
export 'package:mwwm/src/relation/event/actions/text_editing_action.dart';
export 'package:mwwm/src/relation/event/event.dart';
export 'package:mwwm/src/relation/event/streamed_state.dart';

//builders
export 'package:mwwm/src/relation/builder/entity_stream_builder.dart';
export 'package:mwwm/src/relation/builder/streamed_state_builder.dart';
export 'package:mwwm/src/relation/builder/textfield_state_builder.dart';

//main
export 'package:mwwm/src/mwwm_widget.dart';
export 'package:mwwm/src/wm_factory.dart';
export 'package:mwwm/src/widget_model.dart';