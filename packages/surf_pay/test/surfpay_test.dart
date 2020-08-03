import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surfpay/surfpay.dart';

void main() {
  const MethodChannel channel = MethodChannel('surfpay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
