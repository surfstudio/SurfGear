import 'package:datalist/datalist.dart';
import 'package:datalist_example/common/datalist_state.dart';
import 'package:datalist_example/common/paginationable.dart';
import 'package:datalist_example/interactor/data/user.dart';
import 'package:datalist_example/interactor/user_interactor.dart';
import 'package:mwwm/mwwm.dart';

class AppWidgetModel extends WidgetModel {
  final paginationState = EntityPaginationState(PaginationState.none);
  final itemsState = StreamedDataListState<User>(OffsetDataList.empty());
  final userListState = StreamedState<List<User>>();

  final loadMoreAction = Action();

  UserInteractor _userInteractor;

  AppWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._userInteractor,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    _bindActions();
    _loadItems(0);

    super.onLoad();
  }

  void _bindActions() {
    bind(loadMoreAction, (_) => _loadMore());
  }

  void _loadItems(offset) {
    paginationState.loadMore();

    doFuture(
      _userInteractor.getUserList(offset, 10),
      (res) {
        if (res.isEmpty) {
          paginationState.complete();
        } else {
          itemsState.merge(res);
          paginationState.none();
        }
      },
      onError: (e) {
        paginationState.error();
      },
    );
  }

  void _loadMore() {
    paginationState.loadMore();
    _loadItems(itemsState.value.nextOffset);
  }
}
