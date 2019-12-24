import 'package:flutter/material.dart';

mixin LifecycleLoggingMixin<T extends StatefulWidget> on State<T>{

  @override
  void initState() {
    super.initState();
    debugPrint("${this} initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("${this} didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("${this} dispose");
  }
}