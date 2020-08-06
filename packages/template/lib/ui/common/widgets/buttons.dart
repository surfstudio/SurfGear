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

import 'package:flutter/material.dart';
import 'package:flutter_template/ui/res/colors.dart';

/// FAB с Opacity при дизейбле
class OpacityFab extends StatelessWidget {
  const OpacityFab({
    @required this.onPressed,
    Key key,
    this.enabled = true,
  })  : assert(onPressed != null),
        super(key: key);

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : .4,
      child: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: enabled ? onPressed : null,
          disabledElevation: 0.0,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Icon(
            Icons.arrow_forward,
            color: white,
          ),
        ),
      ),
    );
  }
}
