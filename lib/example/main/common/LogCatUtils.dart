import 'dart:developer' as developer;

extension FancyNum on num {
  num plus(num other) => this + other;

  num times(num other) => this * other;
}

extension LogCatUtils on String {
  Log() => (developer.log("===" + " : " + this,
      stackTrace: StackTrace.fromString("stackTraceString")));
  Logs(String message) => (developer.log("===" +message+ " : " + this,
      stackTrace: StackTrace.fromString("stackTraceString")));
}
