import 'package:logger/logger.dart';

Function? Log(message) {
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
  loggerNoStack.i('###: $message');
}
