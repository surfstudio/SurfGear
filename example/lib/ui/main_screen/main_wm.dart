import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

/// Main screen's widget model
class MainWm extends WidgetModel {
  MainWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  final pageIndexState = StreamedState(0);

  final changePageAction = Action<int>();

  @override
  void onBind() {
    super.onBind();

    subscribe(changePageAction.stream, onChangePage);
  }

  void onChangePage(int pageIndex) {
    pageIndexState.accept(pageIndex);
  }
}
