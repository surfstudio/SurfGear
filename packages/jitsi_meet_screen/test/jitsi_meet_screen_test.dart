import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jitsi_meet_screen/jitsi_meet_screen.dart';

void main() {
  const MethodChannel channel = MethodChannel('jitsi_meet_screen');

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
