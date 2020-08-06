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

/// additional application settings in debug mode
class DebugOptions {
  DebugOptions({
    this.showPerformanceOverlay = false,
    this.debugShowMaterialGrid = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = false,
  });

  final bool showPerformanceOverlay;
  final bool debugShowMaterialGrid;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  DebugOptions copyWith({
    bool showPerformanceOverlay,
    bool debugShowMaterialGrid,
    bool checkerboardRasterCacheImages,
    bool checkerboardOffscreenLayers,
    bool showSemanticsDebugger,
    bool debugShowCheckedModeBanner,
  }) =>
      DebugOptions(
        showPerformanceOverlay:
            showPerformanceOverlay ?? this.showPerformanceOverlay,
        checkerboardOffscreenLayers:
            checkerboardOffscreenLayers ?? this.checkerboardOffscreenLayers,
        checkerboardRasterCacheImages:
            checkerboardRasterCacheImages ?? this.checkerboardRasterCacheImages,
        debugShowCheckedModeBanner:
            debugShowCheckedModeBanner ?? this.debugShowCheckedModeBanner,
        debugShowMaterialGrid:
            debugShowMaterialGrid ?? this.debugShowMaterialGrid,
        showSemanticsDebugger:
            showSemanticsDebugger ?? this.showSemanticsDebugger,
      );
}
