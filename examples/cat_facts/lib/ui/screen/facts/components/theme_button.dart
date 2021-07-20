// Copyright (c) 2019-present, SurfStudio LLC
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

import 'dart:math';

import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final AppTheme? theme;

  const ThemeButton({
    Key? key,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        theme == AppTheme.light ? 'Switch Off' : 'Switch On',
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(width: 10),
      if (theme == AppTheme.light)
        Transform.rotate(
          angle: pi / 6,
          child: const Icon(Icons.brightness_3, color: Colors.white),
        )
      else
        const Icon(Icons.brightness_7, color: Colors.white),
    ]);
  }
}
