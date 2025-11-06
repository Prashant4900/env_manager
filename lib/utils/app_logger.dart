import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(
        message,
        time: DateTime.now(),
        name: name ?? 'Logger',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void info(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      log(
        message,
        time: DateTime.now(),
        name: name ?? 'Logger',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
