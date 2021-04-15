import 'dart:async';

import 'package:mocktail/mocktail.dart';

class StreamSubscriptionMock<T> extends Mock implements StreamSubscription<T> {}
