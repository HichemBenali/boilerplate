import 'package:logger/logger.dart';

class Log {
  static Logger _logger = new Logger();

  static void verbose(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void debug(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void info(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  static void warning(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  static void error(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }

  static void log(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _logger.log(message, error, stackTrace);
  }
}
