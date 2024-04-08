import 'package:flutter/foundation.dart';

class Log {
  static const String _tag = 'Logger';

  static void d(String message) {
    if (kDebugMode) {
      debugPrint('💡$_tag: $message');
    }
  }

  static void e(String message) {
    if (kDebugMode) {
      debugPrint('❌$_tag: $message');
    }
  }
}
