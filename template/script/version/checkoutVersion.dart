import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;
}