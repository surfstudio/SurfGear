import 'package:ci/ci.dart';

void main(List<String> arguments) async {
  await Ci.instance.execute(arguments);
}
