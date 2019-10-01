import 'package:datalist/datalist.dart';
import 'package:datalist_example/common/paginationable.dart';
import 'package:mwwm/mwwm.dart';

class StreamedDataListState<T> extends StreamedState<OffsetDataList<T>> {
  StreamedDataListState([OffsetDataList<T> dataList])
      : super(dataList ?? OffsetDataList.empty());

  Future<void> merge(OffsetDataList<T> newList) {
    return accept(value.merge(newList));
  }
}

class EntityPaginationState extends StreamedState<PaginationState> {
  EntityPaginationState([PaginationState state = PaginationState.none])
      : super(state);

  Future<void> loadMore() {
    return accept(PaginationState.loading);
  }

  Future<void> error() {
    return accept(PaginationState.error);
  }

  Future<void> complete() {
    return accept(PaginationState.complete);
  }

  Future<void> none() {
    return accept(PaginationState.none);
  }
}
