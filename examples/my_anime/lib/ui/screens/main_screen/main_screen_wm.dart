import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class MainScreenWM extends WidgetModel {
  final StreamedState<int> _selectedScreenIndexState = StreamedState(0);

  MainScreenWM() : super(const WidgetModelDependencies());
  StreamedState<int> get selectedScreenIndexState => _selectedScreenIndexState;

  void navigationTap(int index) {
    _selectedScreenIndexState.accept(index);
  }
}
