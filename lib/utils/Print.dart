import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum LOG_LEVEL {
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}

class Print {
  static DateFormat dateFormat = DateFormat('HH:mm:ss.sss');
  bool isShowLog = true;
  static String getTime() {
    return dateFormat.format(DateTime.now());
  }

  static d(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[34m$msg\x1B[0m");
  }

  static i(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[32m$msg\x1B[0m");
  }

  static w(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[33m$msg\x1B[0m");
  }

  static e(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[31m$msg\x1B[0m");
  }

  static api(msg) {
    msg = "${getTime()}::$msg";
    debugPrint("\x1B[35m$msg\x1B[0m");
  }

  static api2(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[45m$msg\x1B[0m");
  }

  static dd(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[44m$msg\x1B[0m");
  }

  static ii(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[42m$msg\x1B[0m");
  }

  static ww(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[43m$msg\x1B[0m");
  }

  static ee(msg) {
    msg = "${getTime()}:: $msg";
    debugPrint("\x1B[41m$msg\x1B[0m");
  }

  static largeLog(msg) {
    msg = "${getTime()}:: $msg";
  }

  static void LogPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}
