import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:logger/logger.dart';

Function Log(message){
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
  loggerNoStack.i('###: $message');
}