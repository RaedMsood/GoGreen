import 'package:logger/logger.dart';

class WingsLogger {
  static final WingsLogger _instance = WingsLogger._internal();
  static Logger logger = Logger();

  factory WingsLogger() {
    return _instance;
  }

  WingsLogger._internal();

  void log(String message) {
    logger.d(message);
  }

  void logError(dynamic message) {
    logger.e(message.toString());
  }

  void logWarning(String message) {
    logger.w(message);
  }

  void logInfo(String message) {
    logger.i(message);
  }

  void logVerbose(String message) {
    logger.v(message);
  }

  void logWtf(String message) {
    logger.wtf(message);
  }

  void logDebug(String message) {
    logger.d(message);
  }
}

final wingsLogger = WingsLogger();
