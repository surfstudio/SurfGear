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
