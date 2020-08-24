import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_rate/in_app_rate.dart';

void main() {
  const MethodChannel channel = MethodChannel(channelName);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case openRatingDialogMethod:
          return true;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test(openRatingDialogMethod, () async {
    expect(await InAppRate.openRatingDialog(), true);
  });
}
