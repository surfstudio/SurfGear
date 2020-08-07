import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Death red screen error handler
///
///To replace the standard red screen of death,
///you need to connect to ErrorWidget.builder in the builder
///of instance MaterialApp or CupertinoApp
class ErrorWidget extends StatelessWidget {
  ///Create ErrorWidget instance
  ///
  /// @param context - BuildContext of app
  /// @param error - Contains error information
  /// @param backgroundColor - color of background
  /// @param textColor - color of text
  /// @param errorMessage - optional info about error
  /// @param customMessageWidget - custom ui of widget
  const ErrorWidget({
    @required this.context,
    @required this.error,
    Key key,
    this.backgroundColor,
    this.textColor,
    this.errorMessage,
    this.customMessageWidget,
  }) : super(key: key);

  final BuildContext context;
  final FlutterErrorDetails error;
  final Color backgroundColor, textColor;
  final String errorMessage;
  final Widget customMessageWidget;

  @override
  Widget build(BuildContext context) {
    if (customMessageWidget == null) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (errorMessage != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Message:',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: textColor, fontSize: 18)),
                            Text(errorMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: textColor, fontSize: 14)),
                          ],
                        ),
                      Text('Error stacktrace: ${error.runtimeType}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: textColor, fontSize: 18)),
                      Text(
                        error.exceptionAsString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: textColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return customMessageWidget;
    }
  }
}
