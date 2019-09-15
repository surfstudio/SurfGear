import 'package:datalist/datalist.dart';
import 'package:datalist_example/common/overscroll_glow_absorber.dart';
import 'package:datalist_example/common/paginationable.dart';
import 'package:datalist_example/common/streamed_state_builder.dart';
import 'package:datalist_example/interactor/data/user.dart';
import 'package:datalist_example/ui/app_component.dart';
import 'package:datalist_example/ui/app_wm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends WidgetState<App, AppWidgetModel, AppComponent> {
  @override
  Widget buildState(BuildContext context) => MaterialApp(
        title: "DataList example",
        home: Scaffold(
          appBar: AppBar(
            title: Text("DataList example"),
          ),
          body: StreamedStateBuilder<OffsetDataList<User>>(
            streamedState: wm.itemsState,
            builder: (context, items) {
              return OverscrollGlowAbsorber(
                child: PaginationStateBuilder(
                  mode: ListMode.list,
                  onLoadMore: wm.loadMoreAction.accept,
                  currentPaginationState: wm.paginationState.stream,
                  children: <Widget>[for (var item in items) Text(item.login)],
                  paginationFooterBuilder: (context, state) {
                    if (state == PaginationState.loading ||
                        state == PaginationState.none) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            },
          ),
        ),
      );

  @override
  AppComponent getComponent(BuildContext context) {
    return AppComponent();
  }
}
